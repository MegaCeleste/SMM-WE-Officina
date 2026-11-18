extends Node
## 第 9 批：真实 rm_editor 的新建、摆放、试玩切换、保存、重载。

var _checks: int = 0
var _fails: int = 0


func ok(value: bool, message: String) -> void:
	_checks += 1
	if not value:
		_fails += 1
		printerr("FAIL ", message)


func ticks(count: int) -> void:
	for i: int in count:
		GM.tick()


func first(obj: int) -> Variant:
	return GM.instance_find(obj, 0)


func live_including_inactive(obj: int) -> bool:
	return GM.instances.any(func(inst: GMObject) -> bool: return not inst._destroyed and inst.object_index == obj)


func click_at(px: float, py: float) -> void:
	GM.mouse_override = Vector2((px - GM.camera_get_view_x(0)) * GM.VIEW_W / GM.camera_get_view_width(0), (py - GM.camera_get_view_y(0)) * GM.VIEW_H / GM.camera_get_view_height(0))
	var button: InputEventMouseButton = InputEventMouseButton.new()
	button.button_index = MOUSE_BUTTON_LEFT
	button.pressed = true
	GM._input(button)
	GM.tick()
	button.pressed = false
	GM._input(button)
	GM.tick()


func test_save() -> void:
	# Populate every source section, including dedicated pipe/cannon/platform/door records.
	GM.instance_create(304.0, 352.0, A.obj_tuberia_res)
	GM.instance_create(352.0, 352.0, A.obj_cannon_res)
	GM.instance_create(432.0, 320.0, A.obj_semisolid_platform1)
	GM.instance_create(528.0, 352.0, A.obj_door_res)
	GM.instance_create(192.0, 352.0, A.obj_decoracion_1)
	# Actual save dialog and Alarm 0 path; fixed names only inside test user data.
	var button = GM.instance_create(213.0, 62.0, A.obj_button_save_load)
	button._mouse_4()
	ok(GM.instance_exists(A.obj_window_alert), "save opens in-game text fields")
	var input = first(A.obj_input)
	var desc = first(A.obj_input_desc)
	input.new_texto = "batch9-editor"
	input.can_write = 0.0
	desc.new_texto = "Editor roundtrip"
	desc.can_write = 0.0
	G.desc = desc.new_texto
	G.etiqueta1 = 0.0
	G.etiqueta2 = 1.0
	GM.directory_create(G.directorio)
	GM.file_delete(G.directorio + "batch9-editor.swe")
	first(A.obj_button_notification_aceptar)._mouse_4()
	ticks(20)
	ok(GM.file_exists(G.directorio + "batch9-editor.swe"), "save dialog writes swe file")
	ok(not GM.instance_exists(A.obj_window_alert), "successful save closes dialog")
	var raw: PackedByteArray = FileAccess.get_file_as_bytes(GM._fix_path(G.directorio + "batch9-editor.swe"))
	ok(not raw.is_empty() and raw[-1] == 0, "saved file ends with a null byte")
	var data: Variant = GM.swe_load_json(G.directorio + "batch9-editor.swe", G.drez)
	ok(data is Dictionary, "saved HMAC and JSON are accepted by loader")
	if data is Dictionary:
		ok(data.has("MAIN") and data.has("SUB1"), "source top-level keys")
		ok(data["MAIN"].size() == 8, "all eight source sections")
		ok(data["MAIN"]["AJUSTES"][0]["description"] == "Editor roundtrip", "description saved")
		ok(data["MAIN"]["NIVEL"].any(func(row: Dictionary) -> bool: return row["object"] == "obj_goomba_res"), "placed enemy saved")
		for section: String in ["SUELO", "DECORACION", "TUBERIAS", "CANNON", "PLATAFORMAS", "PUERTAS"]:
			ok(not data["MAIN"][section].is_empty(), section + " has source records")
		ok(data["MAIN"]["TUBERIAS"][0].has("t_direct_t") and data["MAIN"]["CANNON"][0].has("down") and data["MAIN"]["PLATAFORMAS"][0].has("width") and data["MAIN"]["PUERTAS"][0].has("door_x"), "dedicated section field names follow source")
	# Save changes preserves the source structure and updated coordinates.
	first(A.obj_goomba_res).x += 16.0
	GM.instance_create(198.0, GM.camera_get_view_y(0), A.obj_panel_save_load)
	ticks(15)
	var changes = first(A.obj_button_save_changes)
	changes._mouse_4()
	ticks(20)
	data = GM.swe_load_json(G.directorio + "batch9-editor.swe", G.drez)
	ok(data is Dictionary and data["MAIN"]["NIVEL"].any(func(row: Dictionary) -> bool: return row["object"] == "obj_goomba_res" and row["x_pos"] == 272.0), "save changes updates placed object")
	ok(data is Dictionary and not data["MAIN"]["PLATAFORMAS"].is_empty() and not data["MAIN"]["PUERTAS"].is_empty(), "overwrite retains offscreen resources through activation and alarm chain")
	G.last_level = "batch9-editor.swe"
	GM.room_goto(A.rm_editor)
	GM.tick()
	ticks(100)
	ok(GM.instance_exists(A.obj_goomba_res), "editor automatically reloads saved object")
	if first(A.obj_goomba_res) != null:
		ok(first(A.obj_goomba_res).x == 272.0, "reloaded object has saved coordinate")
	ok(not GM.instance_exists(A.obj_load_level), "room-start loader completes")
	ok(GM.room == A.rm_editor and first(A.obj_levelmanager).editor == 1.0, "reload remains in editor")
	# Exercise dedicated resource conversion after reloading, including offscreen instances.
	var play = first(A.obj_creator_jugar_editar)
	play._user_2()
	ticks(90)
	for obj: int in [A.obj_tuberia, A.obj_cannon, A.obj_modelsizable, A.obj_door]:
		ok(live_including_inactive(obj), "saved resource becomes runtime " + GM.object_get_name(obj))
	play._user_2()
	ticks(100)
	ok(first(A.obj_levelmanager).editor == 1.0, "dedicated resources return to editor")
	ok(not live_including_inactive(A.obj_modelsizable) and live_including_inactive(A.obj_semisolid_platform1), "return removes runtime platform and retains editable platform")


func test_play() -> void:
	var button = first(A.obj_creator_jugar_editar)
	var palette: Array = GM.with_list(A.obj_card_item)
	ok(not palette.is_empty(), "editor creates item cards")
	palette.append_array([first(A.obj_card_block_sounds), first(A.obj_expand), first(A.obj_expand_paneles_top)])
	ok(palette.all(func(control: GMObject) -> bool: return control.visible), "palette starts visible")
	# Start play while the manually collapsed palette is sliding back in.
	var cursor = first(A.obj_cursor)
	cursor.anim_top = 34.0
	cursor.cont_panel_top = 2.0
	click_at(button.x + 10.0, button.y + 15.0)
	for frame: int in 10:
		if first(A.obj_levelmanager).editor == 0.0:
			break
		GM.tick()
	ok(first(A.obj_levelmanager).editor == 0.0, "click enters playtest")
	ok(palette.all(func(control: GMObject) -> bool: return not control.visible), "playtest hides the palette immediately")
	ticks(90)
	ok(first(A.obj_levelmanager).editor == 0.0, "play button enters gameplay")
	ok(GM.instance_exists(A.obj_mario), "play spawns Mario")
	ok(GM.instance_exists(A.obj_galoomba), "resource becomes runtime enemy")
	ok(cursor.anim_top == 34.0 and cursor.cont_panel_top == 3.0, "palette finishes closing during playtest")
	click_at(button.x + 10.0, button.y + 15.0)
	ticks(100)
	ok(first(A.obj_levelmanager).editor == 1.0, "play button returns to editor")
	ok(GM.instance_exists(A.obj_mario_editor), "editor Mario restored")
	ok(GM.instance_exists(A.obj_goomba_res), "editable resource restored")
	ok(palette.all(func(control: GMObject) -> bool: return control.visible), "returning to edit restores the palette")
	ok(cursor.anim_top == 0.0 and cursor.cont_panel_top == 0.0, "the revealed palette settles at its exact endpoint")


func test_compat() -> void:
	var old_style: float = G.apariencia
	G.apariencia = 1.0
	var resource = GM.instance_create(320.0, 352.0, A.obj_SMB2_mushroom_res)
	var same_reference: GMObject = resource
	var uid: int = resource._uid
	resource.wings = 1.0
	resource.key = 1.0
	resource.visible = false
	resource.mask_index = A.spr_square
	resource._step_end()
	ok(same_reference == resource and resource._uid == uid, "instance_change keeps reference and creation order")
	ok(resource.object_index == A.obj_mushroom_res, "instance_change switches object type")
	ok(resource.wings == 1.0 and resource.key == 1.0 and resource.x == 320.0, "instance_change preserves instance variables")
	ok(resource.visible == GM.classes[A.obj_mushroom_res].visible and resource.mask_index == GM.classes[A.obj_mushroom_res].mask, "instance_change copies new object mask and visibility")
	ok(GM.instance_find(A.obj_mushroom_res, 0) == resource and not GM.instance_exists(A.obj_SMB2_mushroom_res), "instance_change updates object pools")
	var phase_snapshot: Array[GMObject] = [resource]
	resource.instance_change(A.obj_load_image, false)
	GM._run_list(phase_snapshot, &"_step_end")
	ok(not resource.has_method(&"_step_end"), "phase snapshot skips an event removed by instance_change")
	GM.instance_destroy(resource)
	G.apariencia = old_style
	var path: int = GM.path_add()
	GM.path_add_point(path, 0.0, 0.0, 100.0)
	GM.path_add_point(path, 30.0, 40.0, 100.0)
	ok(GM.path_get_length(path) == 50.0 and GM.path_get_x(path, 0.5) == 15.0 and GM.path_get_y(path, 0.5) == 20.0, "dynamic rail path length and interpolation")
	ok(GM._buffers.is_empty(), "save and HMAC scripts release buffers")


func _ready() -> void:
	GM.auto_tick = false
	GM._reset_for_test()
	GM.game_start(A.rm_logo)
	first(A.obj_persistent).alarm[4] = -1.0
	var args: PackedStringArray = OS.get_cmdline_user_args()
	if not args.is_empty():
		G.apariencia = float(clampi(int(args[0]), 0, 3))
	G.my1 = "editor-test"
	G.levelguardabot = ""
	GM.room_goto(A.rm_editor)
	GM.tick()
	ticks(100)
	ok(GM.room == A.rm_editor, "new level enters rm_editor")
	ok(GM.instance_exists(A.obj_editormanager), "editor manager exists")
	ok(first(A.obj_levelmanager) != null and first(A.obj_levelmanager).editor == 1.0, "editor mode active")
	ok(GM.instance_exists(A.obj_creation_preview), "resource preview exists")
	ok(not GM.instance_exists(A.obj_load_level), "new-level initialization completes")
	ok(first(A.obj_levelmanager).leveltime == 300.0, "new-level timer is 300")
	ok(GM.camera_get_view_y(0) == 216.0, "editor starts at room view y=216")
	ok(first(A.obj_mario_editor).y >= GM.camera_get_view_y(0) and first(A.obj_mario_editor).y < GM.camera_get_view_y(0) + GM.camera_get_view_height(0), "editor Mario starts inside the visible area")
	# Select a palette resource, then place through the global mouse event.
	G.select_resource = A.obj_goomba_res
	G.editor_activity = 1.0
	first(A.obj_editormanager).x = 192.0
	first(A.obj_editormanager).y = 324.0
	GM.camera_set_view_pos(0, 0.0, 216.0)
	# A floor beneath the test enemy keeps it alive during the play roundtrip.
	for px: int in range(128, 400, 16):
		GM.instance_create(float(px), 400.0, A.obj_ground)
	click_at(256.0, 384.0)
	ok(GM.instance_exists(A.obj_goomba_res), "mouse places resource")
	if GM.instance_exists(A.obj_goomba_res):
		test_play()
		test_save()
	var mac: String = Scr.sha1_string_utf8_hmac(null, "key", "The quick brown fox jumps over the lazy dog")
	ok(mac == "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9", "original HMAC script matches known vector")
	test_compat()
	print("editor tests: %d checks, %d failed" % [_checks, _fails])
	GM._reset_for_test()
	get_tree().quit(1 if _fails else 0)
