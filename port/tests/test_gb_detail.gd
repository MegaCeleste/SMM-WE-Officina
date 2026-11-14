extends Node

var checks: int = 0
var failures: int = 0

func check(value: bool, message: String) -> void:
	checks += 1
	if not value:
		failures += 1
		printerr("FAIL: ", message)

func _ready() -> void:
	GM.auto_tick = false
	GM.game_start(A.rm_logo)
	var src: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	GM.directory_create(G.directorio)
	var target: String = GM._fix_path(G.directorio + "gb_detail_test.swe")
	DirAccess.copy_absolute(src, target)
	G.levelguardabot = "gb_detail_test.swe"
	var detail = GM.instance_create(0.0, 0.0, A.obj_gb_level)
	check(detail != null and not detail._destroyed, "sample detail opens")
	check(G.apariencia == 2.0, "sample style is read")
	check(detail.entorno == "castle", "sample environment is read")
	check(GM.instance_exists(A.obj_bt_gb_play), "play button exists")
	check(GM.instance_exists(A.obj_bt_gb_edit), "edit button exists")
	check(GM.instance_exists(A.obj_bt_gb_delete), "delete button exists")
	if detail != null and not detail._destroyed:
		detail._gm_draw()
		detail.instance_destroy()
	check(not GM.instance_exists(A.obj_bt_gb_play), "closing detail removes buttons")
	DirAccess.remove_absolute(ProjectSettings.globalize_path(target))
	print("guardabot detail tests: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)
