extends Node
## 第 2 批：启动链（obj_persistent → rm_logo → rm_intro → intro 结束）的 headless 测试。
## 运行：godot --headless --path port res://tests/test_boot.tscn
## 用真实的 object 和数据表，按 tick 推进，检查各阶段在预期的 tick 发生。全部通过时退出码 0。

var _fails: int = 0
var _checks: int = 0
var _cur: String = ""


func _ready() -> void:
	GM.auto_tick = false
	# 0 = 星期日：龟壳版本；6 = 星期六：咚咚版本（obj_intro_controller/Other_4.gml）
	for wd: int in [0, 6]:
		_cur = "weekday %d" % wd
		GM._reset_for_test()
		GM.weekday_override = wd
		_run_boot(wd)
	GM._reset_for_test()
	GM.weekday_override = -1
	_cur = "layers"
	_test_layers()
	GM._reset_for_test()
	print("boot tests: %d checks, %d failed" % [_checks, _fails])
	await get_tree().create_timer(0.3).timeout
	get_tree().quit(1 if _fails > 0 else 0)


func ok(cond: bool, msg: String) -> void:
	_checks += 1
	if not cond:
		_fails += 1
		printerr("FAIL [%s] %s" % [_cur, msg])


func _tick_until(cond: Callable, limit: int) -> int:
	for i: int in limit:
		if cond.call():
			return i
		GM.tick()
	return -1


func _run_boot(wd: int) -> void:
	GM.game_start(A.rm_logo)
	ok(GM.room == A.rm_logo, "从 rm_logo 开始")
	var p: GMObject = GM.instance_find(A.obj_persistent, 0)
	ok(p != null, "obj_persistent 存在")
	ok(GM.instance_exists(A.obj_logo_c), "obj_logo_c 存在")
	ok(p != null and p.alarm[4] == 240.0, "Room Start 把 alarm[4] 设成 240（覆盖 Game Start 的 260）")
	ok(G.font_google >= 0, "字体已创建")
	ok(String(Scr.scr_language(p, 0.0)) != "", "scr_language(0) 有文字")

	# rm_logo 停 240 步后进 rm_intro
	var n: int = _tick_until(func() -> bool: return GM.room == A.rm_intro, 400)
	ok(n == 240, "第 240 步进 rm_intro（实际 %d）" % n)
	ok(GM.instance_find(A.obj_persistent, 0) == p, "obj_persistent 跨 room 保留")
	ok(not GM.instance_exists(A.obj_logo_c), "obj_logo_c 随 room 销毁")
	ok(GM.sprite_exists(int(p.get("back"))), "Room End 截了图")
	ok(GM._app_w == 768.0 and GM._app_h == 432.0, "application_surface 被 Other_11 设成 768x432")
	# 换 room 后同一帧立刻再跑一步：Room End 设的 alarm[1] 在这一步触发，冻结除自己以外的实例
	ok(not GM.instance_exists(A.obj_intro_controller), "淡出期间 intro 被冻结")
	var want: int = A.obj_shell_intro if wd == 0 else A.obj_thwomp_intro
	var cnt: int = 0
	for inst: GMObject in GM.instances:
		if inst.object_index == want:
			cnt += 1
	ok(cnt == 1, "星期日出龟壳 / 星期六出咚咚（Room Start 里创建，已冻结）")
	# Room Start 设的 alarm[0] = 30：算上换 room 那一步，第 30 步解冻并删截图
	n = _tick_until(func() -> bool: return GM.instance_exists(A.obj_intro_controller), 60)
	ok(n == 29, "Alarm_0 在进 room 后第 30 步解冻（实际 %d）" % (n + 1))
	ok(not GM.sprite_exists(int(p.get("back"))), "截图已删除")

	# 马里奥被撞飞 → 标题落下、弹跳停住 → obj_persistent.alarm[4] = 220
	n = _tick_until(func() -> bool: return not GM.instance_exists(A.obj_mario_intro), 1000)
	ok(n > 0, "马里奥离开画面后被销毁（%d 步）" % n)
	var ctrl: GMObject = GM.instance_find(A.obj_intro_controller, 0)
	n = _tick_until(func() -> bool: return ctrl.get("ready_v") == 2.0, 600)
	ok(n > 0, "标题落定（%d 步）" % n)
	ok(ctrl.y == 0.0, "标题停在视图顶端")
	ok(p.alarm[4] == 220.0, "intro 结束后 alarm[4] = 220")

	# 220 步后：intro 控制器销毁、登录界面的按钮出现、背景 0 换成 bg_lg
	n = _tick_until(func() -> bool: return not GM.instance_exists(A.obj_intro_controller), 300)
	ok(n == 220, "第 220 步进登录界面（实际 %d）" % n)
	ok(GM.instance_number(A.obj_btn_social) == 4, "4 个社交按钮")
	var socials: Array = GM.with_list(A.obj_btn_social)
	ok(socials.size() == 4 and String(socials[1].get("link")) == "https://discord.gg/YwpyCfHgSr", "第二个按钮链接到 Discord")
	var bg: int = GM.layer_background_get_id(GM.layer_get_id("Compatibility_Background_0"))
	ok(GM.layer_background_get_sprite(bg) == A.bg_lg, "背景 0 换成 bg_lg")
	ok(GM.layer_background_get_alpha(bg) == 1.0, "换 sprite 时 alpha 置 1")
	for i: int in 10:
		GM.tick()
	ok(GM.room == A.rm_intro, "停在 rm_intro（登录界面，第 10 批）")


func _test_layers() -> void:
	GM.game_start(A.rm_intro)
	var all_l: Array = GM.layer_get_all()
	ok(all_l.size() == 4, "rm_intro 有 4 个图层（2 个实例图层 + 2 个背景图层），实际 %d" % all_l.size())
	var col: int = GM.layer_get_id("Compatibility_Colour")
	var el: int = GM.layer_background_get_id(col)
	ok(GM.layer_background_get_blend(el) == GM.make_colour_rgb(255, 202, 33), "纯色背景的颜色")
	ok(GM.layer_get_depth(col) == 16777216.0, "纯色背景的 depth")
	# __background_set 找不到 Compatibility_Background_1 时新建图层
	Scr.__background_set(null, Scr.e__BG.Index, 1.0, A.bg_lg)
	var l1: int = GM.layer_get_id("Compatibility_Background_1")
	ok(l1 >= 0, "新建了 Compatibility_Background_1")
	ok(GM.layer_background_get_sprite(GM.layer_background_get_id(l1)) == A.bg_lg, "新图层的 sprite")
	ok(GM.layer_get_depth(col) == 2147483600.0, "纯色图层被挪到最远（max(…, 2147483600)）")
	Scr.__background_set(null, Scr.e__BG.Visible, 1.0, 0.0)
	ok(not GM.layer_get_visible(l1), "Visible 设为 0")
	for i: int in 3:
		GM.tick()
