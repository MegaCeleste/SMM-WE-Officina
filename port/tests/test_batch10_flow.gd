extends Node

var checks: int = 0
var failures: int = 0
var sample_paths: Array[String] = []

func check(condition: bool, message: String) -> void:
	checks += 1
	if not condition:
		failures += 1
		printerr("FAIL: ", message)

func ticks(count: int) -> void:
	for i: int in count:
		GM.tick()

func until_active(object_id: int, limit: int = 400) -> Variant:
	for i: int in limit:
		var inst: GMObject = GM.instance_find(object_id, 0)
		if inst != null:
			return inst
		GM.tick()
	return null

func click(inst: GMObject) -> void:
	var px: float = (inst.bbox_left + inst.bbox_right) / 2.0
	var py: float = (inst.bbox_top + inst.bbox_bottom) / 2.0
	GM.mouse_override = Vector2((px - GM.camera_get_view_x(0)) * GM.VIEW_W / GM.camera_get_view_width(0), (py - GM.camera_get_view_y(0)) * GM.VIEW_H / GM.camera_get_view_height(0))
	var event: InputEventMouseButton = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.pressed = true
	GM._input(event)
	GM.tick()
	event.pressed = false
	GM._input(event)
	GM.tick()

func _ready() -> void:
	GM.auto_tick = false
	if FileAccess.file_exists("user://settings.cfg"):
		printerr("Refusing to use an existing settings directory")
		get_tree().quit(1)
		return
	GM.game_start(A.rm_logo)
	var persistent = GM.instance_find(A.obj_persistent, 0)
	persistent.alarm[4] = -1.0
	GM.directory_create(G.directorio)
	var source: String = ProjectSettings.globalize_path("res://").path_join("../docs/samples/3.5.1level1.swe")
	for i: int in range(11):
		var path: String = GM._fix_path(G.directorio + "flow_%02d.swe" % i)
		if FileAccess.file_exists(path):
			printerr("Refusing to overwrite ", path)
			get_tree().quit(1)
			return
		DirAccess.copy_absolute(source, path)
		sample_paths.append(path)
	G.my1 = 0.0
	var guest = GM.instance_create(149.0, 138.0, A.obj_btn_invitado)
	guest._mouse_4()
	var entry = GM.instance_find(A.obj_iname, 0)
	check(entry != null, "guest name input opened")
	if entry == null:
		finish()
		return
	GM.keyboard_string = "Flow User"
	entry._step()
	GM.instance_find(A.obj_bl2, 0)._mouse_4()
	GM.tick()
	check(GM.room == A.rm_title, "guest enters title")
	var prompt = until_active(A.obj_title_oprime)
	check(prompt != null, "title prompt appears")
	if prompt == null:
		finish()
		return
	click(prompt)
	var play: Variant = null
	for candidate in GM.with_list(A.obj_play_screen):
		if candidate.object_index == A.obj_play_screen:
			play = candidate
			break
	check(play != null and GM.instance_exists(A.obj_editor_screen), "title opens play and editor options")
	if play == null:
		finish()
		return
	click(play)
	ticks(25)
	var home = GM.instance_find(A.obj_button_home, 0)
	check(home != null and home.image_index == 3.0, "play opens local courses option")
	if home == null:
		finish()
		return
	click(home)
	ticks(30)
	check(GM.room == A.rm_guardabot, "local course list opens")
	var guard = until_active(A.obj_guardabot)
	check(guard != null and guard.my_list.size() == 11 and guard.cantidad == "11" and guard.can_x == 306.0, "eleven courses and two-digit alignment")
	check(GM.instance_number(A.obj_gb_button) == 11, "eleven course cards created")
	var card = GM.instance_find(A.obj_gb_button, 0)
	if card == null:
		finish()
		return
	var initial_y: float = card.y
	var scroll = GM.instance_find(A.obj_scrollbar2, 0)
	if scroll != null:
		GM.mouse_override = Vector2(100.0, 100.0)
		var wheel: InputEventMouseButton = InputEventMouseButton.new()
		wheel.button_index = MOUSE_BUTTON_WHEEL_DOWN
		wheel.pressed = true
		GM._input(wheel)
		GM.tick()
		check(scroll.button_y > 0.0, "mouse wheel scrolls the local list")
		scroll.button_y = scroll.bar_height
		ticks(2)
		check(card.y < initial_y, "scrollbar moves course cards")
		scroll.button_y = 0.0
		ticks(2)
	for i: int in [9, 10]:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(sample_paths[i]))
	GM.room_restart()
	GM.tick()
	guard = until_active(A.obj_guardabot)
	check(guard != null and guard.my_list.size() == 9 and guard.cantidad == "9" and guard.can_x == 310.0, "nine courses and single-digit alignment")
	for i: int in [9, 10]:
		DirAccess.copy_absolute(source, sample_paths[i])
	GM.room_restart()
	GM.tick()
	guard = until_active(A.obj_guardabot)
	card = GM.instance_find(A.obj_gb_button, 0)
	check(guard != null and guard.my_list.size() == 11 and card != null, "refresh discovers new local files")
	if card == null:
		finish()
		return
	click(card)
	var detail = GM.instance_find(A.obj_gb_level, 0)
	check(detail != null and G.levelguardabot == card.texto, "selecting card opens its details")
	if detail == null:
		finish()
		return
	ticks(18)
	var start = GM.instance_find(A.obj_bt_gb_play, 0)
	check(start != null and start.press == 1.0, "play button becomes available")
	if start == null:
		finish()
		return
	click(start)
	ticks(10)
	check(GM.room == A.rm_guardabot_play, "course enters play room")
	var mario = until_active(A.obj_mario)
	check(mario != null, "course creates active Mario")
	if mario == null:
		finish()
		return
	var manager = GM.instance_find(A.obj_levelmanager, 0)
	check(manager != null and manager.canpause == 1.0, "game permits pause")
	if manager != null:
		manager._keypress_13()
	var pause = GM.instance_find(A.obj_menu_pausa, 0)
	check(pause != null, "pause opens in course")
	if pause == null:
		finish()
		return
	ticks(16)
	var quit_button: Variant = null
	for candidate in GM.with_list(A.obj_pausa_button):
		if candidate.type == 2.0:
			quit_button = candidate
	check(quit_button != null, "pause has leave button")
	if quit_button != null:
		click(quit_button)
		ticks(10)
	check(GM.room == A.rm_guardabot, "leaving course returns to local list")
	guard = until_active(A.obj_guardabot)
	check(guard != null and guard.my_list.size() == 11, "local list is rebuilt on return")
	card = GM.instance_find(A.obj_gb_button, 0)
	if card != null:
		var selected_path: String = GM._fix_path(G.directorio + card.texto)
		click(card)
		ticks(18)
		var delete_button = GM.instance_find(A.obj_bt_gb_delete, 0)
		check(delete_button != null, "course detail exposes delete")
		if delete_button != null:
			click(delete_button)
			ticks(10)
			check(not FileAccess.file_exists(selected_path), "delete removes the selected test course")
			guard = until_active(A.obj_guardabot)
			check(guard != null and guard.my_list.size() == 10, "list refreshes after delete")
	var menu = until_active(A.obj_menu_editor_ext)
	if menu != null:
		ticks(31)
		click(menu)
	var return_button: Variant = null
	for candidate in GM.with_list(A.obj_settings_button):
		if candidate.object_index == A.obj_settings_button and candidate.image_index == 3.0:
			return_button = candidate
	check(return_button != null, "list menu exposes return to title")
	if return_button != null:
		click(return_button)
		check(GM.room == A.rm_title, "return button enters title")
	finish()

func finish() -> void:
	for path: String in sample_paths:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
	if FileAccess.file_exists("user://settings.cfg"):
		DirAccess.remove_absolute(ProjectSettings.globalize_path("user://settings.cfg"))
	print("batch10 flow: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)
