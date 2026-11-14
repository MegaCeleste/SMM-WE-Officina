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
	var p = GM.instance_find(A.obj_persistent, 0)
	p.alarm[4] = -1.0
	var src: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	GM.directory_create(G.directorio)
	DirAccess.copy_absolute(src, GM._fix_path(G.directorio + "pause_test.swe"))
	G.levelguardabot = "pause_test.swe"
	G.nm_play = 0.0
	GM.room_goto(A.rm_guardabot_play)
	GM.tick()
	for i: int in range(400):
		if GM.instance_exists(A.obj_mario):
			break
		GM.tick()
	var mario: GMObject = GM.instance_find(A.obj_mario, 0)
	check(mario != null, "level and Mario active before pause")
	if mario == null:
		get_tree().quit(1)
		return
	var menu = GM.instance_create(239.0, 0.0, A.obj_menu_pausa)
	check(not mario._active, "pause deactivates Mario")
	check(p._active, "persistent object remains active")
	check(GM.instance_number(A.obj_pausa_button) == 3, "pause creates three buttons")
	menu._gm_draw()
	menu._user_0()
	check(mario._active, "resume reactivates Mario")
	check(not GM.instance_exists(A.obj_menu_pausa), "resume destroys pause menu")
	check(not GM.instance_exists(A.obj_pausa_button), "resume removes pause buttons")
	DirAccess.remove_absolute(ProjectSettings.globalize_path(GM._fix_path(G.directorio + "pause_test.swe")))
	print("pause tests: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)
