extends Node
## 第 6 批：敌人的冒烟测试，按小批分组。
## 运行：godot --headless --path port res://tests/test_enemies.tscn -- <小批> [画风编号…] 2>&1 | tee log
##   小批：land（6a）……，或 all
## 每种画风载入一次样本关卡；对小批里的每个 object 跑三种变体（普通、wings=1、paracaidas=1，
## 和 scripts/scr_edit_to_play 一样在 Create 之后赋值；实例上没有这个变量的变体跳过），每种变体两轮：
##   walk：敌人生成在 Mario 前方 64px，Mario 不动，等 150 步（敌人自己走动、碰到 Mario）；
##   stomp：敌人生成在 Mario 前方，Mario 放到它头顶 40px 处往下落，等 60 步，再往右走一段。
## 每轮先打印 "== RUN style=… obj=… var=… mode=… =="，之后到下一行 "== RUN" 之前出现的
## "SCRIPT ERROR" 属于这一轮（tools/triage_player_log.py 汇总）。
## 判据：没有 SCRIPT ERROR、还在关卡里（Mario 死了会重新载入）。这是冒烟测试，不验证动作和原版一致。

const GROUPS: Dictionary = {
	"land": [
		"obj_galoomba_b", "obj_galoomba2", "obj_galoomba2_b", "obj_koopa_b", "obj_koopa_red",
		"obj_koopa_red_b", "obj_beachkoopa_b", "obj_beachkoopa_red", "obj_beachkoopa_red_b",
		"obj_waddlewing", "obj_cooligan", "obj_mechakoopa", "obj_piranhaplant", "obj_plant_fire",
		"obj_jumppiranha", "obj_big_pplant", "obj_big_pplant_b",
		"obj_wings_dead", "obj_wings_dead_b", "obj_paracaidas_go", "obj_smoke_goomba",
		"obj_big_plant_dead", "obj_big_plant_b_dead", "obj_splash_lava", "obj_splash_posion",
	],
	"castle": [
		"obj_bobomb", "obj_bobomb_ready", "obj_bonybeetle", "obj_bonybeetle_b", "obj_drybones",
		"obj_crumblebones", "obj_crumblebony", "obj_crumblebony_b", "obj_firebar", "obj_grinder",
		"obj_grrrol", "obj_grrrol_b", "obj_grrrol_new", "obj_podoboo", "obj_podoboo_b", "obj_skewer",
		"obj_skewertrunk", "obj_soplete", "obj_soplete_global", "obj_soplete_invert",
		"obj_soplete_invert_global", "obj_thwomp", "obj_thwomp_b",
	],
	"airship": [
		"obj_cannon", "obj_cannon_red", "obj_bulletbill", "obj_bulletbull_red", "obj_bullebill_base",
		"obj_bullebill_base_red", "obj_banzaibill", "obj_billbanzai_red", "obj_monty_chase", "obj_rocky",
	],
	"water": [
		"obj_blooper", "obj_cheepcheep", "obj_cheepcheep2", "obj_fishbone", "obj_goomba_swim",
		"obj_angrysun", "obj_rocangrejo", "obj_rorock", "obj_splash_agua",
	],
	"other": [
		"obj_spiny", "obj_spiny_thrown", "obj_spiny_ball", "obj_lakitu", "obj_cloud_lakitu", "obj_pokey",
		"obj_chain_chomp_free", "obj_chain_chomp_free_b", "obj_buzzybeetle", "obj_buzzybeetle_b",
		"obj_buzzy_ceiling", "obj_spike", "obj_spike_ball", "obj_spike_ball_b", "obj_bone", "obj_boo",
		"obj_magikoopa", "obj_magic", "obj_foo", "obj_foo_fog", "obj_floruga", "obj_floruga_body",
		"obj_enemy_multidead", "obj_charginchuck", "obj_NSMBU_charginchuck", "obj_ninji", "obj_NSMBU_ninji",
		"obj_smoke_steps", "obj_hammerbro", "obj_boomerangbro", "obj_firebro", "obj_icebro", "obj_sledgebro",
		"obj_brohammer", "obj_fireball_bro", "obj_snowball_bro", "obj_shake_mario", "obj_claw",
		"obj_block_hidden",
	],
}
const VARIANTS: Array[String] = ["plain", "wings", "paracaidas"]
## 原版由编辑器资源（_res）在 instance_create 之后写入的变量（_res 第 9 批才移植，这里按 _res 的默认值补上）。
## obj_bullebill_base(_red)：objects/obj_bullebill_base(_red)_res/Other_13.gml，sprite = _res 的 sprite_index，size_y 默认 2
const INIT: Dictionary = {
	"obj_bullebill_base": {"sprite": "spr_SMB_bulletbill_base", "size_y": 2.0, "image_yscale": 2.0, "sprout": 0.0},
	"obj_bullebill_base_red": {"sprite": "spr_SMB_bulletbill_base_red", "size_y": 2.0, "image_yscale": 2.0, "sprout": 0.0},
}

var _fails: int = 0
var _checks: int = 0
var _sx: float = 0.0
var _sy: float = 0.0


func ok(cond: bool, msg: String) -> void:
	_checks += 1
	if not cond:
		_fails += 1
		printerr("FAIL ", msg)


func _find(obj: int) -> GMObject:
	for inst: GMObject in GM.instances:
		if not inst._destroyed and inst._isa[obj] != 0:
			return inst
	return null


## 把样本关卡的画风改掉，重新签名，写到关卡目录（同 test_items.gd）
func _make_level(style: int) -> String:
	var src: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	var raw: PackedByteArray = FileAccess.get_file_as_bytes(src)
	while not raw.is_empty() and raw[raw.size() - 1] == 0:
		raw.resize(raw.size() - 1)
	var s: String = raw.get_string_from_utf8()
	var data: Dictionary = JSON.parse_string(Marshalls.base64_to_utf8(s.substr(0, s.length() - 40)))
	# 同 tests/play_enemies.gd：改成一条平地，去掉样本里原有的物件（免得 Mario 走过去碰上样本的敌人）
	var main: Dictionary = data["S0"]
	var cfg: Dictionary = main["S1"][0]
	cfg["gamestyle"] = style
	cfg["gametheme"] = "ground"
	cfg["size"] = 1600
	cfg["start_y"] = 384
	cfg["goal_x"] = 1600 - 160
	cfg["goal_y"] = 384
	cfg["wl"] = 448
	cfg["wl_limit"] = 448
	cfg["wl_speed"] = 0
	cfg["timer"] = 999
	var ground: Array = []
	var gx: int = 112
	while gx < 1600 - 160:
		for gy: int in [384, 400, 416]:
			ground.append({"xx": gx, "yy": gy, "i": 0})
		gx += 16
	main["S2"] = ground
	for k: String in ["S3", "S4", "S5", "S6", "S7", "S8"]:
		main[k] = []
	var b64: String = Marshalls.utf8_to_base64(JSON.stringify(data))
	var mac: String = Crypto.new().hmac_digest(HashingContext.HASH_SHA1, String(G.drez).to_utf8_buffer(), b64.to_utf8_buffer()).hex_encode()
	var fname: String = "t6_style%d.swe" % style
	GM.directory_create(G.directorio)
	var f: FileAccess = FileAccess.open(GM._fix_path(G.directorio + fname), FileAccess.WRITE)
	f.store_string(b64 + mac)
	f.store_8(0)
	f.close()
	return fname


func _start(style: int) -> GMObject:
	GM._reset_for_test()
	GM.random_set_seed(1)
	GM.game_start(A.rm_logo)
	G.levelguardabot = _make_level(style)
	G.nm_play = 0.0
	GM.room_goto(A.rm_guardabot_play)
	GM.tick()
	var p: GMObject = GM.instance_find(A.obj_persistent, 0)
	if p != null:
		p.alarm[4] = -1.0
	var m: GMObject = _find(A.obj_mario)
	if m == null:
		return null
	var n: int = 0
	while n < 400 and not m._active:
		GM.tick()
		n += 1
	_ticks(20)
	m = _find(A.obj_mario)
	if m != null:
		_sx = m.x
		_sy = m.y
	return m


func _ticks(n: int) -> void:
	for i: int in n:
		GM.tick()


func _hold(vk: float, n: int) -> void:
	GM.keyboard_key_press(int(vk))
	_ticks(n)
	GM.keyboard_key_release(int(vk))


## 关卡状态复位：Mario 回起点、小个子；死了或不在关卡里就重新载入
func _reset(style: int) -> GMObject:
	var m: GMObject = _find(A.obj_mario)
	if m == null or GM.room != A.rm_guardabot_play:
		m = _start(style)
		if m == null:
			return null
	var w: int = 0
	while w < 300 and (_find(A.obj_mario_transform2) != null or GM.instance_find(A.obj_levelmanager, 0) == null):
		GM.tick()
		w += 1
	m = _find(A.obj_mario)
	if m == null or GM.room != A.rm_guardabot_play:
		m = _start(style)
		if m == null:
			return null
	m.x = _sx
	m.y = _sy
	m.hspeed = 0.0
	m.vspeed = 0.0
	G.powerup = 0.0
	return m


func _alive_msg() -> String:
	var m: GMObject = _find(A.obj_mario)
	if m == null:
		return "mario=none dead=%s" % (_find(A.obj_deadmario) != null)
	return "mario=%s pos=(%s,%s)" % [GM.object_get_name(m.object_index), m.x, m.y]


func _spawn(m: GMObject, name: String, variant: String, dx: float) -> GMObject:
	var inst: GMObject = GM.instance_create(m.x + dx, m.y - 8.0, GM.asset_get_index(name))
	_apply_init(inst, name)
	if variant != "plain" and inst != null:
		inst.set(variant, 1.0)
	return inst


static func _apply_init(inst: GMObject, name: String) -> void:
	if inst == null or not INIT.has(name):
		return
	var d: Dictionary = INIT[name]
	for k: String in d:
		var v: Variant = d[k]
		inst.set(k, GM.asset_get_index(v) if v is String else v)


func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	var group: String = args[0] if args.size() > 0 else "all"
	var names: Array = []
	if group == "all":
		for g: String in GROUPS:
			names.append_array(GROUPS[g])
	else:
		names = GROUPS[group]
	var styles: Array[int] = []
	for i: int in range(1, args.size()):
		styles.append(int(args[i]))
	if styles.is_empty():
		styles = [0, 1, 2, 3]
	for style: int in styles:
		var m: GMObject = _start(style)
		ok(m != null, "style %d：载入后有 obj_mario" % style)
		if m == null:
			continue
		for name: String in names:
			var idx: int = GM.asset_get_index(name)
			ok(idx >= 0, "%s 有编号" % name)
			if idx < 0:
				continue
			for variant: String in VARIANTS:
				for mode: String in ["walk", "stomp"]:
					m = _reset(style)
					if m == null:
						ok(false, "style %d obj %s：重新载入失败" % [style, name])
						continue
					var probe: GMObject = null
					if variant != "plain":
						# 先看实例上有没有这个变量，没有就跳过该变体
						probe = GM.instance_create(m.x + 400.0, m.y - 8.0, idx)
						var has: bool = probe != null and is_instance_valid(probe) and variant in probe
						if probe != null and is_instance_valid(probe) and not probe._destroyed:
							GM.instance_destroy(probe)
						if not has:
							continue
					print("== RUN style=%d obj=%s var=%s mode=%s ==" % [style, name, variant, mode])
					if mode == "walk":
						_spawn(m, name, variant, 64.0)
						_ticks(150)
					else:
						_spawn(m, name, variant, 32.0)
						m.x += 32.0
						m.y -= 40.0
						_ticks(60)
						_hold(G.derecha, 40)
						_ticks(30)
					print("   end: ", _alive_msg())
					ok(GM.room == A.rm_guardabot_play or _find(A.obj_deadmario) != null,
						"style %d obj %s %s %s：还在关卡里" % [style, name, variant, mode])
					for o: GMObject in GM.with_list(idx):
						GM.instance_destroy(o)
	print("enemy tests: %d checks, %d failed" % [_checks, _fails])
	await get_tree().create_timer(0.3).timeout
	get_tree().quit(1 if _fails > 0 else 0)
