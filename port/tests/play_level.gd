extends Node
## 试玩入口（调试用，非原版）：跳过 logo/intro/菜单，直接载入一个关卡文件进入游玩。
## 运行：godot --path port res://tests/play_level.tscn [-- 关卡文件路径]
## 不给路径时用 docs/samples/3.5.1level1.swe。Esc 退出，F5 重新载入关卡。
## 键位是原版默认值：A/D 左右，W/S 上下，↑ 跳，↓ 旋转跳，← 跑/拿，回车 暂停。

var _level: String = ""


func _ready() -> void:
	var a: PackedStringArray = OS.get_cmdline_user_args()
	var src: String = a[0] if a.size() > 0 else ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	GM.game_start(A.rm_logo)
	# 启动链的定时器（rm_logo 240 步后进 rm_intro）在这里不该走
	GM.instance_find(A.obj_persistent, 0).alarm[4] = -1.0
	GM.directory_create(G.directorio)
	_level = src.get_file()
	if DirAccess.copy_absolute(src, GM._fix_path(G.directorio + _level)) != OK:
		push_error("play_level: 复制关卡文件失败 " + src)
	_start()


func _start() -> void:
	G.levelguardabot = _level
	G.nm_play = 0.0
	GM.room_goto(A.rm_guardabot_play)


func _unhandled_key_input(e: InputEvent) -> void:
	var k: InputEventKey = e as InputEventKey
	if k == null or not k.pressed or k.echo:
		return
	if k.keycode == KEY_ESCAPE:
		get_tree().quit()
	elif k.keycode == KEY_F5:
		_start()
