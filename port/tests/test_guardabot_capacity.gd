extends Node

func _ready() -> void:
	GM.auto_tick = false
	GM.game_start(A.rm_logo)
	GM.directory_create(G.directorio)
	var paths: Array[String] = []
	for i: int in range(90):
		var path: String = GM._fix_path(G.directorio + "capacity_%02d.swe" % i)
		if FileAccess.file_exists(path):
			printerr("Refusing to overwrite ", path)
			get_tree().quit(1)
			return
		var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
		if file == null:
			printerr("Could not create ", path)
			get_tree().quit(1)
			return
		file.close()
		paths.append(path)
	var guard = GM.instance_create(0.0, 0.0, A.obj_guardabot)
	var ok: bool = guard.my_list.size() == 90 and guard.cantidad == "90" and guard.can_x == 306.0 and GM.instance_number(A.obj_gb_button) == 90
	print("guardabot capacity: ", guard.my_list.size(), " files, ", GM.instance_number(A.obj_gb_button), " cards, ", "passed" if ok else "FAILED")
	for path: String in paths:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
	get_tree().quit(0 if ok else 1)
