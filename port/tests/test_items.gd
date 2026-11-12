extends Node
## 第 5 批：方块、道具、收集物、可拿起物件的冒烟测试。
## 运行：godot --headless --path port res://tests/test_items.tscn [-- 画风编号…] 2>&1 | tee log
## 每种画风载入一次样本关卡；对 OBJS 里的每个 object：把 Mario 放回起点，在他前方生成一个实例，
## 走过去（按住拿取键）、跳、松开，再等一会儿。每轮先打印 "== RUN style=… obj=… =="，
## 之后到下一行 "== RUN" 之前出现的 "SCRIPT ERROR" 属于这一轮（tools/triage_player_log.py 汇总）。
## 判据：没有 SCRIPT ERROR、还在关卡里。另有几项针对性检查（吃道具、金币、弹簧）。
## 这是冒烟测试，不验证动作和原版一致。

const OBJS: Array[String] = [
	# Blocks
	"obj_pblock", "obj_anti_pblock", "obj_rockparent", "obj_block_ice", "obj_block_rock", "obj_icecoin",
	"obj_noteblock", "obj_musicblock", "obj_noteblock_s", "obj_onoffblock", "obj_onoffplatform",
	"obj_onoffplatform_blue", "obj_onoffplatform_d", "obj_nube", "obj_pipebase", "obj_ground_slope",
	"obj_slopes", "obj_tile_trigger", "obj_block_gold", "obj_flipblock_anim", "obj_block_coinchain",
	# Power ups
	"obj_1up", "obj_SMB2_mushroom", "obj_cap", "obj_fireflower", "obj_frogsuit", "obj_hammersuit",
	"obj_hen_mushroom", "obj_megamushroom", "obj_pballon", "obj_penguin_suit", "obj_propellershroom",
	"obj_star", "obj_superarcon", "obj_superflower",
	# Collectables
	"obj_coin10", "obj_coin30", "obj_coin50", "obj_coin_pow", "obj_coin_pow_big", "obj_coinchain",
	"obj_coinchange", "obj_pink_coin", "obj_veggiecoin", "obj_multiveggiecoin", "obj_key", "obj_key_appear",
	"obj_key_fallow", "obj_icon_dead", "obj_egg", "obj_egg_blue", "obj_egg_red", "obj_egg_hatch",
	"obj_frozenmario", "obj_parcarry", "obj_boomerang", "obj_wrench", "obj_cannonball", "obj_cannonball_red",
	"obj_bobomb_hold", "obj_powerupsprout_note",
	# 发射物、特效
	"obj_fireball", "obj_fireball_b", "obj_hammer", "obj_hammer_b", "obj_superball", "obj_superball_trail",
	"obj_plantfire", "obj_invincibility", "obj_bonus_trail", "obj_shell_trail", "obj_espina",
	"obj_galoomba_hold_b", "obj_galoomba_hold2", "obj_galoomba_hold2_b", "obj_snowball",
	"obj_sparkletrail", "obj_sparkles_coin", "obj_gold_explosion", "obj_smoke_cap", "obj_explosion",
	# obj_holdparent 系
	"obj_pswitch", "obj_pswitch_press", "obj_block_pow_hold", "obj_block_pow_active", "obj_spring",
	"obj_spring_land", "obj_shell_drybones", "obj_shell_drybones_held", "obj_shell_empty", "obj_spiny_empty",
	"obj_enemyfrozen", "obj_snow_ball", "obj_snow_ball_b", "obj_snow_ball_held", "obj_mechakoopa_held",
]

## 道具在原版里按画风换成别的对象（scripts/scr_edit_to_play 里各 _res 的 switch global.apariencia），
## 不在表里的画风原版不会生成该对象，测试跳过。表外的对象四种画风都跑。
const STYLES: Dictionary = {
	"obj_cap": [1, 2], "obj_megamushroom": [0], "obj_propellershroom": [3], "obj_superflower": [0],
	"obj_hen_mushroom": [0], "obj_hammersuit": [1], "obj_pballon": [2], "obj_penguin_suit": [3],
	"obj_frogsuit": [1], "obj_superarcon": [3],
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


func _count(obj: int) -> int:
	var n: int = 0
	for inst: GMObject in GM.instances:
		if not inst._destroyed and inst._isa[obj] != 0:
			n += 1
	return n


## 把样本关卡的画风改掉，重新签名，写到关卡目录（同 test_player.gd）
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
	var fname: String = "t5_style%d.swe" % style
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


## 走过去（按住拿取键）、跳、松手扔出去
func _play() -> void:
	GM.keyboard_key_press(int(G.lanzar_agarrar))
	_hold(G.derecha, 40)
	_hold(G.saltar, 15)
	_ticks(30)
	GM.keyboard_key_release(int(G.lanzar_agarrar))
	_ticks(20)
	_hold(G.izquierda, 20)
	_ticks(60)


func _alive_msg() -> String:
	var m: GMObject = _find(A.obj_mario)
	if m == null:
		return "mario=none dead=%s" % (_find(A.obj_deadmario) != null)
	var lm: GMObject = null
	for q: GMObject in GM.instances:
		if q.object_index == A.obj_levelmanager and not q._destroyed:
			lm = q
	return "mario=%s pos=(%s,%s) powerup=%s levelmanager=%s" % [GM.object_get_name(m.object_index), m.x, m.y, G.powerup, "none" if lm == null else ("active" if lm._active else "INACTIVE")]


## 关卡状态复位：Mario 回起点、小个子；必要时重新载入
func _reset(style: int) -> GMObject:
	var m: GMObject = _find(A.obj_mario)
	if m == null or GM.room != A.rm_guardabot_play:
		m = _start(style)
		if m == null:
			return null
	# 变身/受伤时 obj_mario_transform2 会停掉全部实例（原版行为），等它结束再开始下一轮
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


## 生成后让对象落在 Mario 前方 24px、地面高度
func _spawn(m: GMObject, name: String) -> GMObject:
	return GM.instance_create(m.x + 24.0, m.y - 8.0, GM.asset_get_index(name))


func _ready() -> void:
	GM.auto_tick = false
	var styles: Array[int] = []
	for a: String in OS.get_cmdline_user_args():
		styles.append(int(a))
	if styles.is_empty():
		styles = [0, 1, 2, 3]
	for style: int in styles:
		var m: GMObject = _start(style)
		ok(m != null, "style %d：载入后有 obj_mario" % style)
		if m == null:
			continue
		for name: String in OBJS:
			if STYLES.has(name) and not (STYLES[name] as Array).has(style):
				continue
			print("== RUN style=%d obj=%s ==" % [style, name])
			m = _reset(style)
			if m == null:
				ok(false, "style %d obj %s：重新载入失败" % [style, name])
				continue
			var idx: int = GM.asset_get_index(name)
			ok(idx >= 0, "%s 有编号" % name)
			var inst: GMObject = _spawn(m, name)
			_play()
			print("   end: ", _alive_msg(), " inst_alive=", is_instance_valid(inst) and not inst._destroyed)
			ok(GM.room == A.rm_guardabot_play, "style %d obj %s：还在关卡里" % [style, name])
			# 清掉本轮留下的实例，免得影响下一轮
			for o: GMObject in GM.with_list(idx):
				GM.instance_destroy(o)
		_targeted(style)
	print("item tests: %d checks, %d failed" % [_checks, _fails])
	await get_tree().create_timer(0.3).timeout
	get_tree().quit(1 if _fails > 0 else 0)


## 针对性检查：吃到道具后 powerup 变了、星星给无敌、金币加了数
func _targeted(style: int) -> void:
	for name: String in ["obj_fireflower", "obj_star", "obj_coin10"]:
		print("== RUN style=%d targeted=%s ==" % [style, name])
		var m: GMObject = _reset(style)
		if m == null:
			continue
		var pw0: float = G.powerup
		G.coins = 0.0  # 满 100 会进位成 1UP，先清零
		var coins0: float = G.coins
		var inst: GMObject = GM.instance_create(m.x, m.y - 4.0, GM.asset_get_index(name))
		_ticks(40)
		var gone: bool = not is_instance_valid(inst) or inst._destroyed
		print("   %s: gone=%s powerup %s→%s coins %s→%s invincibility=%d" % [name, gone, pw0, G.powerup, coins0, G.coins, _count(A.obj_invincibility)])
		ok(gone, "style %d：%s 和 Mario 重叠后被吃掉" % [style, name])
		match name:
			"obj_fireflower":
				ok(G.powerup != pw0, "style %d：吃火花后 powerup 变了（%s）" % [style, G.powerup])
			"obj_coin10":
				ok(G.coins > coins0, "style %d：吃 10 金币后金币数增加（%s → %s）" % [style, coins0, G.coins])
