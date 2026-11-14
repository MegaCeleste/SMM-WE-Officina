extends Node

var output_dir: String = ""
var paths: Array[String] = []

func capture(label: String) -> void:
	for i: int in 3:
		GM._phase_draw()
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	var err: Error = get_viewport().get_texture().get_image().save_png(output_dir.path_join(label + ".png"))
	print("SHOT ", label, " result=", err)

func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	if args.is_empty() or not args[0].is_absolute_path():
		get_tree().quit(2)
		return
	output_dir = args[0]
	DirAccess.make_dir_recursive_absolute(output_dir)
	GM.game_start(A.rm_logo)
	GM.instance_find(A.obj_persistent, 0).alarm[4] = -1.0
	G.idioma = 4.0
	GM.directory_create(G.directorio)
	var source: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	for i: int in range(11):
		var path: String = GM._fix_path(G.directorio + "preview_%02d.swe" % i)
		if FileAccess.file_exists(path):
			printerr("Refusing to overwrite ", path)
			get_tree().quit(1)
			return
		DirAccess.copy_absolute(source, path)
		paths.append(path)
	GM.room_goto(A.rm_guardabot)
	GM.tick()
	for i: int in range(40):
		GM.tick()
	GM.instance_find(A.obj_persistent, 0).done = 1.0
	await capture("eleven")
	var scroll = GM.instance_find(A.obj_scrollbar2, 0)
	scroll.button_y = scroll.bar_height
	GM.tick()
	await capture("eleven_scrolled")
	for i: int in [9, 10]:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(paths[i]))
	GM.room_restart()
	GM.tick()
	for i: int in range(40):
		GM.tick()
	GM.instance_find(A.obj_persistent, 0).done = 1.0
	await capture("nine")
	for path: String in paths:
		if FileAccess.file_exists(path):
			DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
	GM._reset_for_test()
	get_tree().quit()
