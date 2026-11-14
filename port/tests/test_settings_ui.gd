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
	if FileAccess.file_exists("user://settings.cfg"):
		printerr("Refusing to overwrite existing settings in test user directory")
		get_tree().quit(1)
		return
	GM.game_start(A.rm_logo)
	var p = GM.instance_find(A.obj_persistent, 0)
	G.idioma = 0.0
	GM.instance_create(0.0, 0.0, A.obj_cursor)
	var panel = GM.instance_create(0.0, 0.0, A.obj_settings_panel)
	check(GM.instance_number(A.obj_selecting_player) == 5, "five player choices")
	check(GM.instance_number(A.obj_window_select) == 5, "five window choices")
	var language = GM.instance_find(A.obj_button_settings_idioma, 0)
	language._mouse_4()
	check(G.idioma == 1.0, "language button changes language")
	var slider = GM.instance_find(A.obj_st_slider, 0)
	slider.value_ = 0.42
	slider._user_0()
	check(G.audiomaster == 0.42, "volume slider changes master volume")
	var player = GM.with_list(A.obj_selecting_player)[1]
	player._mouse_4()
	check(G.jugador == 1.0, "player selector changes player")
	var custom = GM.instance_find(A.obj_settings_custom, 0)
	custom._mouse_4()
	check(G.keymod == 1.0 and GM.instance_number(A.obj_settings_controls) == 7, "key configuration opens")
	var control = GM.instance_find(A.obj_settings_controls, 0)
	control._mouse_4()
	var dialog = GM.instance_find(A.obj_titlemenu_key, 0)
	check(dialog != null, "key capture opens")
	if dialog != null:
		dialog.ready_v = 1.0
		GM.keyboard_key = 75
		dialog._keypress_1()
		check(G.arriba == 75.0, "key capture changes up key")
	var close_keys = GM.instance_find(A.obj_button_settings_close2, 0)
	if close_keys != null:
		close_keys._mouse_4()
	check(G.keymod == 0.0 and GM.instance_exists(A.obj_settings_custom), "key configuration closes")
	var close = GM.instance_find(A.obj_button_settings_close, 0)
	if close != null:
		close._mouse_4()
	check(not GM.instance_exists(A.obj_settings_panel), "settings panel closes")
	check(FileAccess.file_exists("user://settings.cfg"), "closing settings saves changes")
	check(p != null and panel != null, "settings created with persistent object")
	DirAccess.remove_absolute(ProjectSettings.globalize_path("user://settings.cfg"))
	print("settings UI tests: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)
