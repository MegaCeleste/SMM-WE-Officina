extends "res://tests/test_editor.gd"
## Real renderer screenshots: editor, palette, save dialog, and all resource cards.

var _out: String = ""
var _shots: int = 0


func capture(name: String) -> void:
	for frame: int in 3:
		GM._phase_draw()
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	var img: Image = get_viewport().get_texture().get_image()
	ok(img.save_png(_out.path_join(name + ".png")) == OK, name + " screenshot")
	_shots += 1
	print("SHOT ", name)


func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	if args.is_empty() or not args[0].is_absolute_path():
		get_tree().quit(2)
		return
	_out = args[0]
	DirAccess.make_dir_recursive_absolute(_out)
	var table: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://tables/objects.json"))["objects"]
	var names: Array[String] = []
	for name: String in table:
		if table[name]["folder"] in ["Objects/Editor Res Objects", "Objects/Editor Res Sounds Effects"] or name == "obj_link_res":
			names.append(name)
	names.sort()
	for style: int in 4:
		GM._reset_for_test()
		GM.game_start(A.rm_logo)
		first(A.obj_persistent).alarm[4] = -1.0
		G.apariencia = float(style)
		G.last_level = ""
		G.levelguardabot = ""
		GM.room_goto(A.rm_editor)
		GM.tick()
		ticks(100)
		await capture("s%d_editor" % style)
		first(A.obj_expand)._mouse_4()
		ticks(20)
		await capture("s%d_palette" % style)
		for inst: GMObject in GM.with_list(A.obj_panel_expand):
			inst.instance_destroy()
		first(A.obj_editormanager).expand_open = 0.0
		GM.instance_create(GM.camera_get_view_x(0), GM.camera_get_view_y(0), A.obj_window_alert)
		first(A.obj_input).new_texto = "Editor preview"
		first(A.obj_input_desc).new_texto = "New course"
		await capture("s%d_save" % style)
		for inst: GMObject in GM.with_list(A.obj_window_alert):
			inst.instance_destroy()
		var baseline: Array[GMObject] = []
		baseline.assign(GM.instances)
		for inst: GMObject in baseline:
			if inst.object_index != A.obj_persistent:
				inst.visible = false
		GM.camera_set_view_target(0, null)
		GM.camera_set_view_pos(0, 0.0, 0.0)
		G.instance_deactivate = 0.0
		for page: int in int(ceilf(float(names.size()) / 32.0)):
			for inst: GMObject in GM.instances.duplicate():
				if not baseline.has(inst) and not inst._destroyed:
					GM.instance_destroy(inst)
			GM._sweep()
			for cell: int in 32:
				var index: int = page * 32 + cell
				if index >= names.size():
					break
				var px: float = 24.0 + float(cell % 8) * 48.0
				var py: float = 24.0 + float(cell / 8) * 48.0
				var obj: GMObject = GM.instance_create(px, py, GM.asset_get_index(names[index]))
				if obj._destroyed:
					continue  # The original rail objects destroy themselves in Create.
				GM.other = obj
				if obj.has_method("_step_begin"):
					obj.call("_step_begin")
				if obj.has_method("_step_end"):
					obj.call("_step_end")
				GM.other = null
			await capture("s%d_resources_%02d" % [style, page])
	print("editor shots: %d images, %d checks, %d failed" % [_shots, _checks, _fails])
	GM._reset_for_test()
	get_tree().quit(1 if _fails else 0)
