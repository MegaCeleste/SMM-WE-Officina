extends Node
## 第 4 批：玩家冒烟测试。四种画风 × 各 powerup 各跑一段固定的按键序列（走、跳、蹲、发射、旋转跳、上）。
## 运行：godot --headless --path port res://tests/test_player.tscn [-- 画风编号…] 2>&1 | tee log
## 这个测试主要靠日志判断：每一轮先打印一行 "== RUN style=… powerup=… =="，
## 之后到下一行 "== RUN" 之前出现的 "SCRIPT ERROR" 就属于这一轮（tools/triage_player_log.py 汇总）。
## 原版里并不是每个 powerup 在每种画风下都存在，不存在的组合报错不算移植错误，要对照原脚本分辨。

const POWERUPS: Array[float] = [0.0, 1.0, 2.0, 3.0, 24.0, -29.0, -30.0, -37.0, -38.0, -39.0, -43.0, -46.0, -50.0, -77.0, -78.0, -80.0, -82.0, -85.0]
## 额外场景：骑耀西、穿鞋（把对应 object 放到 Mario 脚下）
const RIDES: Array[String] = ["obj_yoshi2", "obj_yoshi_red", "obj_yoshi_blue", "obj_kuriboshoe", "obj_kuriboshoe2", "obj_kuribo_drybones"]

var _fails: int = 0
var _checks: int = 0


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


## 把样本关卡的画风改掉，重新签名，写到关卡目录
func _make_level(style: int) -> String:
	var src: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	var raw: PackedByteArray = FileAccess.get_file_as_bytes(src)
	while not raw.is_empty() and raw[raw.size() - 1] == 0:
		raw.resize(raw.size() - 1)
	var s: String = raw.get_string_from_utf8()
	var data: Dictionary = JSON.parse_string(Marshalls.base64_to_utf8(s.substr(0, s.length() - 40)))
	data["S0"]["S1"][0]["gamestyle"] = style
	var b64: String = Marshalls.utf8_to_base64(JSON.stringify(data))
	var mac: String = Crypto.new().hmac_digest(HashingContext.HASH_SHA1, String(G.drez).to_utf8_buffer(), b64.to_utf8_buffer()).hex_encode()
	var fname: String = "t4_style%d.swe" % style
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
	for i: int in 20:
		GM.tick()
	return _find(A.obj_mario)


func _hold(vk: float, n: int) -> void:
	GM.keyboard_key_press(int(vk))
	for i: int in n:
		GM.tick()
	GM.keyboard_key_release(int(vk))


func _play() -> void:
	_hold(G.derecha, 40)
	_hold(G.saltar, 20)
	for i: int in 50:
		GM.tick()
	_hold(G.abajo, 20)
	_hold(G.lanzar_agarrar, 4)
	for i: int in 10:
		GM.tick()
	_hold(G.lanzar_agarrar, 4)
	GM.keyboard_key_press(int(G.izquierda))
	_hold(G.lanzar_agarrar, 40)
	GM.keyboard_key_release(int(G.izquierda))
	_hold(G.saltar_spin, 20)
	for i: int in 50:
		GM.tick()
	_hold(G.arriba, 10)
	GM.keyboard_key_press(int(G.derecha))
	_hold(G.saltar, 30)
	_hold(G.abajo, 30)
	GM.keyboard_key_release(int(G.derecha))
	for i: int in 40:
		GM.tick()


func _alive_msg() -> String:
	var m: GMObject = _find(A.obj_mario)
	if m == null:
		return "mario=none dead=%s" % (_find(A.obj_deadmario) != null)
	return "mario=%s pos=(%s,%s) state=%s spr=%s powerup=%s" % [GM.object_get_name(m.object_index), m.x, m.y, m.get("state"), GM.sprite_get_name(m.sprite_index) if m.sprite_index >= 0 else "-1", G.powerup]


func _ready() -> void:
	GM.auto_tick = false
	var styles: Array[int] = []
	for a: String in OS.get_cmdline_user_args():
		styles.append(int(a))
	if styles.is_empty():
		styles = [0, 1, 2, 3]
	for style: int in styles:
		for pw: float in POWERUPS:
			print("== RUN style=%d powerup=%s ==" % [style, pw])
			var m: GMObject = _start(style)
			ok(m != null, "style %d：载入后有 obj_mario" % style)
			if m == null:
				continue
			ok((m.object_index == A.obj_marioU) == (style == 3), "style %d：玩家 object 是 %s" % [style, GM.object_get_name(m.object_index)])
			G.powerup = pw
			# 原版并不是每个 powerup 在每种画风下都有：站立 sprite 查不到的组合跳过
			var idle: Variant = Scr.scr_NSMBU_ground_idle(m) if style == 3 else Scr.scr_marioidle(m)
			if idle == null:
				print("   skip: 该画风没有这个 powerup")
				continue
			_play()
			print("   end: ", _alive_msg())
			ok(GM.room == A.rm_guardabot_play, "style %d powerup %s：还在关卡里" % [style, pw])
		for ride: String in RIDES:
			# 原版：耀西只在 SMW 画风存在（obj_yoshi2/Create_0 开头自毁）；鞋只有 SMB、SMB3 的 sprite（scr_mario_shoe）
			if ride.begins_with("obj_yoshi") and style != 2:
				continue
			if ride.begins_with("obj_kuriboshoe") and style > 1:
				continue
			print("== RUN style=%d ride=%s ==" % [style, ride])
			var m2: GMObject = _start(style)
			if m2 == null:
				continue
			G.powerup = 1.0
			var r: GMObject = GM.instance_create(m2.x, m2.y - 8.0, GM.asset_get_index(ride))
			m2.y -= 40.0
			m2.vspeed = 1.0
			for i: int in 60:
				GM.tick()
			print("   mounted: yoshi=%s ride_alive=%s" % [G.yoshi, is_instance_valid(r) and not r._destroyed])
			ok(G.yoshi != 0.0, "style %d ride %s：骑上了（G.yoshi=%s）" % [style, ride, G.yoshi])
			_play()
			print("   end: ", _alive_msg())
			ok(GM.room == A.rm_guardabot_play, "style %d ride %s：还在关卡里" % [style, ride])
	print("player tests: %d checks, %d failed" % [_checks, _fails])
	await get_tree().create_timer(0.3).timeout
	get_tree().quit(1 if _fails > 0 else 0)
