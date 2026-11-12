extends "res://tests/test_enemies.gd"
## 第 7 批：机关、平台、终点、门、装饰、特效、天气的冒烟测试。做法同 test_enemies.gd（同一套
## 关卡和 walk/stomp 两轮），只跑普通变体。
## 运行：godot --headless --path port res://tests/test_specials.tscn -- <组> [画风编号…] 2>&1 | tee log
##   组：helmet clown goal door platform gadget deco effect weather，或 all
## 判据：没有 SCRIPT ERROR；还在关卡里、或 Mario 死了、或是终点/门这类本来就会离开关卡的 object。
## 另外 weather 组检查粒子系统确实生成了粒子、销毁后系统被删掉。
## 这是冒烟测试，不验证动作和原版一致。

const GROUPS7: Dictionary = {
	"helmet": ["obj_helmet", "obj_helmet_spiny", "obj_brickhelmet"],
	"clown": [
		"obj_clown", "obj_clown_fire", "obj_fire_clown_small", "obj_fire_clown", "obj_clown_explotion",
		"obj_tongue", "obj_tongue_blue",
	],
	# 终点件依赖 obj_ground3 和配套 object（旗杆建旗子、门柱建带子……），原版只由 scr_edit_to_play 按画风
	# 建一个，单独摆会读不存在的实例（原版同样报错），所以只单放检查点；终点本身由 goalrun 测（见 _extra_tests）
	"goal": ["obj_checkpoint"],
	"door": [
		"obj_door", "obj_door_exit", "obj_door_switch", "obj_door_switch_exit", "obj_door_lock",
		"obj_door_lock_exit", "obj_tuberia", "obj_autoscroll",
	],
	"platform": [
		"obj_pinchos", "obj_plataforma", "obj_lava_lift", "obj_fast_lava_lift", "obj_lava_lift_part",
		"obj_plataforma_blue", "obj_donut", "obj_bouncycloud", "obj_cinta", "obj_cinta_switch", "obj_icicle",
		"obj_mini_icicle", "obj_icicle2", "obj_mini_icicle2",
	],
	"gadget": [
		"obj_onewaygate_top", "obj_onewaygate_bottom", "obj_bumper", "obj_bortice", "obj_torbellino",
		"obj_vine", "obj_vine_green", "obj_solidphy", "obj_enabledsolid", "obj_solidhold", "obj_hurtsolid2",
		"obj_solid_appear", "obj_muncher", "obj_muncher_b",
	],
	"deco": [
		"obj_beanstalk", "obj_arrow", "obj_arrow_big", "obj_quicksand", "obj_decoracion_1", "obj_decoracion_2",
		"obj_decoracion_3", "obj_decoracion_4",
	],
	"effect": [
		"obj_paracaidas_dead", "obj_rotten_signal", "obj_stomp", "obj_blockbumper",
		"obj_meteorites", "obj_meteorites_big", "obj_meteorites_maker", "obj_fadein", "obj_fadeout",
		"obj_lava_water", "obj_lava_water_drybones", "obj_score_flag", "obj_sparkles_blend", "obj_blend_ring",
		"obj_bowser_fire", "obj_bowser_fire_down", "obj_bowserfire_up", "obj_NSMBU_bowser_fire",
		"obj_NSMBU_bowser_fire_up", "obj_bowserjr_fire", "obj_NSMBU_bowserjr_fire", "obj_blownbubble",
		"obj_statuesmoke", "obj_spinsmoke", "obj_spinthump", "obj_bubble", "obj_detroy_enemy", "obj_gotas",
		"obj_lave_draw",
	],
	"weather": ["obj_rainmaker", "obj_snowmaker", "obj_leafmaker", "obj_firemaker"],
}
## obj_sidefade 不测：Draw 里 camera_get_view_width(view_get_camera(0) + 50)（原版 bug）会越界，原版也没有地方创建它
const VARIANTS7: Array[String] = ["plain"]
const LEAVE7: Array[String] = [
	"obj_axe_smw", "obj_crystalorb", "obj_hawmask", "obj_goalcard", "obj_flagpole", "obj_SMB_flag",
	"obj_goalgate", "obj_goalgate_tape", "obj_door", "obj_door_exit", "obj_door_switch",
	"obj_door_switch_exit", "obj_door_lock", "obj_door_lock_exit", "obj_tuberia",
]

func _groups() -> Dictionary:
	return GROUPS7


func _variants() -> Array[String]:
	return VARIANTS7


func _may_leave(name: String) -> bool:
	return LEAVE7.has(name)


func _label() -> String:
	return "special tests"


## 天气：建出来跑一会儿，粒子数应大于 0；销毁后系统被删
func _extra_tests() -> void:
	var a: PackedStringArray = OS.get_cmdline_user_args()
	var group: String = a[0] if a.size() > 0 else "all"
	if group == "all" or group == "goal":
		_goal_runs(a)
	if group != "all" and group != "weather":
		return
	var m: GMObject = _reset(2)
	if m == null:
		ok(false, "weather：重新载入失败")
		return
	for name: String in GROUPS7["weather"]:
		print("== RUN style=2 obj=%s var=particles mode=count ==" % name)
		var w: GMObject = GM.instance_create(0.0, 0.0, GM.asset_get_index(name))
		_ticks(120)
		var sys_v: Variant = w.get("rain_sys") if name == "obj_rainmaker" else w.get("snow_sys")
		ok(sys_v != null and GM.part_system_exists(float(sys_v)), "%s：粒子系统存在" % name)
		if sys_v != null:
			var n: float = GM.part_particles_count(float(sys_v))
			print("   particles: ", n)
			ok(n > 0.0, "%s：有粒子（%s）" % [name, n])
		GM.instance_destroy(w)
		if sys_v != null:
			ok(not GM.part_system_exists(float(sys_v)), "%s：销毁后粒子系统被删" % name)


## 每种画风：Mario 从起点按住右走到关卡终点（goal_x = 1440，见 _make_level），最多 1500 步。
## （直接改 Mario 的 x 会被拉回起点，原因没查，所以老实走过去）
## 关卡自带的终点由 scr_edit_to_play 按画风建（SMB1/NSMBU 旗杆、SMB3 卡片、SMW 门柱）。
## 判据：Mario 进了过关流程（obj_mario 消失）或已离开关卡；SCRIPT ERROR 由日志统计。
func _goal_runs(a: PackedStringArray) -> void:
	var styles: Array[int] = []
	for i: int in range(1, a.size()):
		styles.append(int(a[i]))
	if styles.is_empty():
		styles = [0, 1, 2, 3]
	for style: int in styles:
		var m: GMObject = _start(style)
		if m == null:
			ok(false, "goalrun style %d：载入失败" % style)
			continue
		print("== RUN style=%d obj=goal var=plain mode=goalrun ==" % style)
		var left_level: bool = false
		var goal_seen: bool = false
		var jump_t: int = 0
		GM.keyboard_key_press(int(G.derecha))
		for t: int in 1500:
			GM.tick()
			if GM.room != A.rm_guardabot_play:
				left_level = true
				break
			if _find(A.obj_mario) == null and _find(A.obj_deadmario) == null:
				if not goal_seen:
					print("   goal at t=%d powerup=%s jugador=%s apariencia=%s" % [t, G.powerup, G.jugador, G.apariencia])
				goal_seen = true
			# 旗杆前有底座方块、SMB3 的卡片在半空，原版也得跳：x 在 1300–1500 之间、站在地上时起跳，按 18 步
			var mj: GMObject = _find(A.obj_mario)
			if jump_t > 0:
				jump_t -= 1
				if jump_t == 0:
					GM.keyboard_key_release(int(G.saltar))
			elif mj != null and mj.x > 1300.0 and mj.x < 1500.0 and mj.vspeed == 0.0:
				GM.keyboard_key_press(int(G.saltar))
				jump_t = 18
			if t % 300 == 0:
				var mm: GMObject = _find(A.obj_mario)
				print("   t=%d %s" % [t, "none" if mm == null else "x=%s y=%s hs=%s" % [mm.x, mm.y, mm.hspeed]])
		GM.keyboard_key_release(int(G.derecha))
		GM.keyboard_key_release(int(G.saltar))
		print("   end: room=%d goal_seen=%s left=%s %s" % [GM.room, goal_seen, left_level, _alive_msg()])
		ok(goal_seen or left_level, "goalrun style %d：进了过关流程" % style)
