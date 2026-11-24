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
	var latin_font: FontFile = GM._fonts[G.font_google]["latin_font"]
	check(latin_font != null and latin_font.multichannel_signed_distance_field and latin_font.has_char(65), "imported Mario Maker font supplies Latin glyphs")
	G.my1 = 0.0
	var guest = GM.instance_create(149.0, 138.0, A.obj_btn_invitado)
	guest._mouse_4()
	check(GM.instance_exists(A.obj_iname_control), "guest opens name dialog")
	check(not GM.instance_exists(A.obj_btn_invitado), "dialog deactivates background")
	check(GM.instance_exists(A.obj_iname) and GM.instance_exists(A.obj_bl2), "dialog creates input and confirm")
	var entry = GM.instance_find(A.obj_iname, 0)
	GM.keyboard_string = "测试#玩家"
	entry._step()
	check(entry.new_texto == "测试玩家", "input removes hash characters")
	entry._create_touch_input()
	var touch_input: LineEdit = entry._touch_input
	check(touch_input.virtual_keyboard_enabled and touch_input.text == "测试玩家", "touch field uses the virtual keyboard and existing name")
	check(GM._output_to_view(touch_input.position).is_equal_approx(Vector2(entry.x, entry.y)), "touch field aligns with the drawn field")
	touch_input.text = "手机#玩家"
	touch_input.text_changed.emit(touch_input.text)
	check(touch_input.text == "手机玩家" and entry.new_texto == "手机玩家", "touch field passes sanitized Unicode text to the game")
	var button = GM.instance_find(A.obj_bl2, 0)
	button._mouse_4()
	check(G.my1 == "手机玩家", "confirmation sets author name")
	check(FileAccess.file_exists("user://settings.cfg"), "confirmation saves settings")
	check(p != null, "persistent instance remains")
	GM.tick()
	check(GM.room == A.rm_title, "confirmation enters title room")
	check(not touch_input.visible, "room transition hides the touch field")
	for i: int in range(35):
		GM.tick()
	check(GM.instance_exists(A.obj_title_controller), "title controller exists")
	check(GM.instance_exists(A.obj_title_oprime), "title prompt exists")
	G.apariencia = 2.0
	G.modo_noche = 0.0
	G.bg_level = "underwater"
	Scr.scr_create_bg_anim(p)
	var animator = GM.instance_find(A.obj_bganimator, 0)
	check(animator != null and animator.anibg.size() == 4, "background animation has four frames")
	if animator != null:
		animator._alarm_0()
		check(animator.alarm[0] == 10.0, "background animator schedules next frame")
	var prompt = GM.instance_find(A.obj_title_oprime, 0)
	if prompt != null:
		prompt._mouse_4()
	check(GM.instance_exists(A.obj_play_screen) and GM.instance_exists(A.obj_editor_screen), "title offers play and editor")
	var editor = GM.instance_find(A.obj_editor_screen, 0)
	if editor != null:
		editor._mouse_4()
		for i: int in range(160):
			GM.tick()
			if GM.room == A.rm_editor:
				break
	check(GM.room == A.rm_editor, "title editor button enters editor")
	DirAccess.remove_absolute(ProjectSettings.globalize_path("user://settings.cfg"))
	print("guest tests: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)
