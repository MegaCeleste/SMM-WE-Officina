extends Node
## 第 9 批试玩入口：真实 rm_editor。参数 -- [画风 0..3] [关卡文件名]。


func _ready() -> void:
	GM.game_start(A.rm_logo)
	GM.instance_find(A.obj_persistent, 0).alarm[4] = -1.0
	var args: PackedStringArray = OS.get_cmdline_user_args()
	G.apariencia = float(clampi(int(args[0]), 0, 3)) if not args.is_empty() else 2.0
	G.last_level = args[1] if args.size() > 1 else ""
	G.levelguardabot = G.last_level
	GM.room_goto(A.rm_editor)
