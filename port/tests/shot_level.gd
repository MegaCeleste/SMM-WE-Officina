extends Node
## 人眼检查用：真实渲染器下载入样本关卡，按右走一段，在若干帧存截图。
## 运行：godot --path port res://tests/shot_level.tscn -- <输出目录>
## （不带 --headless；要先跑过 test_level 把样本复制到关卡目录）

var _n: int = 0
var _out: String = ""
var _started: bool = false


func _ready() -> void:
	var a: PackedStringArray = OS.get_cmdline_user_args()
	_out = a[0] if a.size() > 0 else "user://"
	GM.random_set_seed(1)
	GM.game_start(A.rm_logo)
	GM.instance_find(A.obj_persistent, 0).alarm[4] = -1.0
	G.levelguardabot = "3.5.1level1.swe"
	G.nm_play = 0.0
	GM.room_goto(A.rm_guardabot_play)


func _physics_process(_d: float) -> void:
	_n += 1
	if _n == 300:
		GM.keyboard_key_press(int(G.derecha))
	if _n == 420:
		GM.keyboard_key_release(int(G.derecha))
	if _n in [120, 290, 360, 440]:
		await RenderingServer.frame_post_draw
		get_viewport().get_texture().get_image().save_png(_out.path_join("level_%04d.png" % _n))
	if _n > 450:
		get_tree().quit()
