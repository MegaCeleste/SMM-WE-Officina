extends "res://tests/test_enemies.gd"
## 第 8 批：按 scr_edit_to_play 的画风映射测试 Boss。
## 运行：godot --headless --path port res://tests/test_bosses.tscn -- [all|bowser|junior|boomboom] [画风编号…]
## 每轮重新载入平地关卡，测试普通 Boss 的侧碰/踩踏；仅 Jr 的 _res 会传 wings/paracaidas，另测这两种变体。
## 断言只检查实际加载、有效 sprite、运行状态；SCRIPT ERROR 必须同时检查日志。这是冒烟测试，不能证明动作与原版一致。

const GROUPS8: Dictionary = {
	"bowser": ["obj_SMB_bowser", "obj_SMB3_bowser", "obj_SMW_bowser", "obj_NSMBU_bowser"],
	"junior": ["obj_bowserjr", "obj_NSMBU_bowserjr"],
	"boomboom": ["obj_boomboom", "obj_boomboom_b", "obj_NSMBU_boomboom", "obj_NSMBU_boomboom_b"],
}


## from scripts/scr_edit_to_play/scr_edit_to_play.gml:1065–1151
static func names_for(style: int, group: String) -> Array[String]:
	var names: Array[String] = []
	if group == "all" or group == "bowser":
		names.append(GROUPS8["bowser"][style])
	if group == "all" or group == "junior":
		names.append("obj_NSMBU_bowserjr" if style == 3 else "obj_bowserjr")
	if group == "all" or group == "boomboom":
		names.append("obj_NSMBU_boomboom" if style == 3 else "obj_boomboom")
		names.append("obj_NSMBU_boomboom_b" if style == 3 else "obj_boomboom_b")
	return names


## _res 的默认 key/wings/paracaidas 全为 0（obj_parent_resource/Create_0），
## scr_edit_to_play 只向 Jr 传 wings/paracaidas，另外三类只传 key。
static func apply_resource_defaults(inst: GMObject, name: String) -> void:
	inst.set("key", 0.0)
	if name == "obj_bowserjr" or name == "obj_NSMBU_bowserjr":
		inst.set("wings", 0.0)
		inst.set("paracaidas", 0.0)


func _groups() -> Dictionary:
	return GROUPS8


func _label() -> String:
	return "boss tests"


func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	var group: String = args[0] if not args.is_empty() else "all"
	if group != "all" and not GROUPS8.has(group):
		printerr("Unknown boss group: ", group)
		get_tree().quit(2)
		return
	var styles: Array[int] = []
	for j: int in range(1, args.size()):
		var style: int = int(args[j])
		if style < 0 or style > 3:
			printerr("Boss style must be 0..3: ", style)
			get_tree().quit(2)
			return
		styles.append(style)
	if styles.is_empty():
		styles = [0, 1, 2, 3]
	for style: int in styles:
		for name: String in names_for(style, group):
			var variants: Array[String] = ["plain"]
			if name == "obj_bowserjr" or name == "obj_NSMBU_bowserjr":
				variants.append_array(["wings", "paracaidas"])
			for variant: String in variants:
				for mode: String in ["walk", "stomp"]:
					_run_boss(style, name, variant, mode)
	_extra_tests()
	print("%s: %d checks, %d failed" % [_label(), _checks, _fails])
	get_tree().quit(1 if _fails > 0 else 0)


func _run_boss(style: int, name: String, variant: String, mode: String) -> void:
	print("== RUN style=%d obj=%s var=%s mode=%s ==" % [style, name, variant, mode])
	var m: GMObject = _start(style)
	ok(m != null, "%s %s %s style %d：关卡有 Mario" % [name, variant, mode, style])
	if m == null:
		return
	var boss: GMObject = GM.instance_create(m.x + 96.0, m.y - 8.0, GM.asset_get_index(name))
	ok(boss != null and not boss._destroyed, "%s：创建成功" % name)
	if boss == null or boss._destroyed:
		return
	ok(boss.get_script().resource_path == "res://objects/%s.gd" % name, "%s：加载已移植脚本" % name)
	apply_resource_defaults(boss, name)
	if variant != "plain":
		boss.set(variant, 1.0)
	ok(boss.sprite_index >= 0 and GM.sprite_get_number(boss.sprite_index) > 0, "%s：有有效 sprite" % name)
	if mode == "stomp":
		m.x = (boss.bbox_left + boss.bbox_right) / 2.0
		m.y = boss.bbox_top - 32.0
		m.vspeed = 1.0
	_ticks(240)
	print("   end: ", _alive_msg())
	ok(GM.room == A.rm_guardabot_play or _find(A.obj_deadmario) != null,
		"%s %s %s style %d：仍在关卡或正常死亡" % [name, variant, mode, style])
