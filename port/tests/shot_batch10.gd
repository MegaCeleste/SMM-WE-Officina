extends Node

var output_dir: String = ""

func capture(label: String) -> void:
	for i: int in 3:
		GM._phase_draw()
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	var result: Error = get_viewport().get_texture().get_image().save_png(output_dir.path_join(label + ".png"))
	print("SHOT ", label, " result=", result)

func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	if args.is_empty() or not args[0].is_absolute_path():
		get_tree().quit(2)
		return
	output_dir = args[0]
	DirAccess.make_dir_recursive_absolute(output_dir)
	GM.game_start(A.rm_logo)
	var p = GM.instance_find(A.obj_persistent, 0)
	p.alarm[4] = -1.0
	G.my1 = "Mario"
	G.idioma = 4.0
	GM.room_goto(A.rm_title)
	GM.tick()
	for i: int in range(40):
		GM.tick()
	await capture("title")
	var prompt = GM.instance_find(A.obj_title_oprime, 0)
	prompt._mouse_4()
	await capture("title_menu")
	GM.room_goto(A.rm_editor)
	GM.tick()
	for i: int in range(100):
		GM.tick()
	GM.instance_create(0.0, 0.0, A.obj_settings_panel)
	await capture("settings")
	var panel = GM.instance_find(A.obj_settings_panel, 0)
	panel.instance_destroy()
	GM.room_goto(A.rm_credito)
	GM.tick()
	for i: int in range(100):
		GM.tick()
	await capture("credits")
	GM._reset_for_test()
	get_tree().quit()
