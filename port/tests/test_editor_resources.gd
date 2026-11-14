extends "res://tests/test_editor.gd"
## Create/Step/Draw smoke coverage for every editor resource in all four styles.


func _ready() -> void:
	GM.auto_tick = false
	var table: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://tables/objects.json"))["objects"]
	var names: Array[String] = []
	for name: String in table:
		if table[name]["folder"] in ["Objects/Editor Res Objects", "Objects/Editor Res Sounds Effects"] or name == "obj_link_res":
			names.append(name)
	names.sort()
	for style: int in 4:
		GM._reset_for_test()
		GM.random_set_seed(9)
		GM.game_start(A.rm_logo)
		first(A.obj_persistent).alarm[4] = -1.0
		G.apariencia = float(style)
		G.last_level = ""
		G.levelguardabot = ""
		GM.room_goto(A.rm_editor)
		GM.tick()
		ticks(100)
		first(A.obj_editormanager).x = 192.0
		first(A.obj_editormanager).y = 324.0
		GM.camera_set_view_pos(0, 0.0, 216.0)
		G.instance_deactivate = 0.0
		for name: String in names:
			print("RESOURCE ", style, " ", name)
			var uid: int = GM._next_uid
			var obj: GMObject = GM.instance_create(256.0, 320.0, GM.asset_get_index(name))
			ok(obj != null, "%s/%d created" % [name, style])
			ticks(3)
			ok(GM.room == A.rm_editor, "%s/%d stays in editor" % [name, style])
			for inst: GMObject in GM.instances.duplicate():
				if inst._uid >= uid and not inst._destroyed:
					GM.instance_destroy(inst)
			GM._sweep()
		print("RESOURCE STYLE COMPLETE ", style)
	GM._reset_for_test()
	print("editor resource tests: %d checks, %d failed" % [_checks, _fails])
	get_tree().quit(1 if _fails else 0)
