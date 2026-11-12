extends Node
## 第 6 批试玩关卡（调试用，非原版）：一条平地，上面按间距摆好某个小批的敌人。
## 运行：godot --path port res://tests/play_enemies.tscn [-- 小批 [画风]]
##   小批：land（默认）……；画风：0 SMB1、1 SMB3、2 SMW（默认）、3 NSMBU
##   截图模式：-- 小批 画风 shot <输出目录>，镜头移过各敌人并存 PNG，然后退出
## Esc 退出，F5 重新开始。键位是原版默认值：A/D 左右，W/S 上下，↑ 跳，↓ 旋转跳，← 跑/拿，回车 暂停。
##
## 做法同 tests/play_items.gd：样本关卡改成平地，走原版载入链路；敌人的 _res 第 9 批才移植，
## 所以开场结束后在运行时 instance_create（不设 wings/paracaidas，即普通变体）。

const LEVEL_W: int = 3200
const GROUND_Y: float = 384.0  ## 地面顶边
const START_X: float = 160.0  ## 第一件物件的 x
const STEP: float = 128.0  ## 敌人间距

## 小批名 → object 列表，取自 test_enemies.gd
const TestEnemies = preload("res://tests/test_enemies.gd")

var _style: int = 2
var _group: String = "land"
var _level: String = ""
var _placed: bool = false
var _shot_dir: String = ""
var _shot_n: int = 0
var _sections: Array = []  ## [[名字, 起点 x], …]，截图模式用


func _ready() -> void:
	var a: PackedStringArray = OS.get_cmdline_user_args()
	if a.size() > 0:
		_group = a[0]
	if a.size() > 1:
		_style = clampi(int(a[1]), 0, 3)
	if a.size() > 3 and a[2] == "shot":
		_shot_dir = a[3]
	GM.game_start(A.rm_logo)
	# 启动链的定时器（rm_logo 240 步后进 rm_intro）在这里不该走
	GM.instance_find(A.obj_persistent, 0).alarm[4] = -1.0
	_level = _make_level()
	_start()


func _start() -> void:
	_placed = false
	G.levelguardabot = _level
	G.nm_play = 0.0
	GM.room_goto(A.rm_guardabot_play)


## 样本关卡改成一条平地，签名后写进关卡目录（签名方式同 tests/test_player.gd）
func _make_level() -> String:
	var src: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	var raw: PackedByteArray = FileAccess.get_file_as_bytes(src)
	while not raw.is_empty() and raw[raw.size() - 1] == 0:
		raw.resize(raw.size() - 1)
	var s: String = raw.get_string_from_utf8()
	var data: Dictionary = JSON.parse_string(Marshalls.base64_to_utf8(s.substr(0, s.length() - 40)))
	var main: Dictionary = data["S0"]
	var cfg: Dictionary = main["S1"][0]
	cfg["gamestyle"] = _style
	cfg["gametheme"] = "ground"
	cfg["size"] = LEVEL_W
	cfg["start_y"] = int(GROUND_Y)
	cfg["goal_x"] = LEVEL_W - 160
	cfg["goal_y"] = int(GROUND_Y)
	cfg["wl"] = 448  # 水位放到房间外
	cfg["wl_limit"] = 448
	cfg["wl_speed"] = 0
	cfg["timer"] = 999
	# 地面：起点地面（obj_ground2）到 x=112，终点地面（obj_ground3）从 goal_x 起；中间铺 3 行地面块
	var ground: Array = []
	var gx: int = 112
	while gx < LEVEL_W - 160:
		for gy: int in [int(GROUND_Y), int(GROUND_Y) + 16, int(GROUND_Y) + 32]:
			ground.append({"xx": gx, "yy": gy, "i": 0})
		gx += 16
	main["S2"] = ground
	for k: String in ["S3", "S4", "S5", "S6", "S7", "S8"]:
		main[k] = []
	var b64: String = Marshalls.utf8_to_base64(JSON.stringify(data))
	var mac: String = Crypto.new().hmac_digest(HashingContext.HASH_SHA1, String(G.drez).to_utf8_buffer(), b64.to_utf8_buffer()).hex_encode()
	var fname: String = "b6_enemies_style%d.swe" % _style
	GM.directory_create(G.directorio)
	var f: FileAccess = FileAccess.open(GM._fix_path(G.directorio + fname), FileAccess.WRITE)
	f.store_string(b64 + mac)
	f.store_8(0)
	f.close()
	return fname


func _physics_process(_d: float) -> void:
	if not _placed:
		var m: GMObject = GM.instance_find(A.obj_mario, 0)
		if m != null and m._active and GM.room == A.rm_guardabot_play:
			_place()
			_placed = true
	elif _shot_dir != "":
		_shot_step()


func _place() -> void:
	_sections = []
	var x: float = START_X
	var names: Array = TestEnemies.GROUPS[_group]
	for n: String in names:
		if n.ends_with("_dead") or n.begins_with("obj_splash") or n == "obj_paracaidas_go" or n == "obj_smoke_goomba":
			continue  # 死亡/特效 object 不单独摆
		_sections.append([n, x])
		GM.instance_create(x, GROUND_Y - 16.0, GM.asset_get_index(n))
		x += STEP
	print("play_enemies: %s style %d, 摆放到 x=%d" % [_group, _style, int(x)])


## 截图模式：每个区段把 Mario 放过去，等 60 帧存一张图
func _shot_step() -> void:
	_shot_n += 1
	var per: int = 90
	var idx: int = _shot_n / per
	if idx >= _sections.size() * 2:
		get_tree().quit()
		return
	var m: GMObject = GM.instance_find(A.obj_mario, 0)
	var sec: Array = _sections[idx / 2]
	var sx: float = float(sec[1]) + (0.0 if idx % 2 == 0 else 192.0)
	if _shot_n % per == 1 and m != null:
		m.x = sx
		m.y = GROUND_Y - 32.0
		m.hspeed = 0.0
		m.vspeed = 0.0
	if _shot_n % per == 60:
		await RenderingServer.frame_post_draw
		var path: String = _shot_dir.path_join("enemies_s%d_%02d_%s.png" % [_style, idx, sec[0]])
		get_viewport().get_texture().get_image().save_png(path)
		print("shot ", path)


func _unhandled_key_input(e: InputEvent) -> void:
	var k: InputEventKey = e as InputEventKey
	if k == null or not k.pressed or k.echo:
		return
	if k.keycode == KEY_ESCAPE:
		get_tree().quit()
	elif k.keycode == KEY_F5:
		_start()
