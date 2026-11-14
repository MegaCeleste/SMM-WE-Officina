extends GMObject

var can_write: float = 0.0
var TX: float = 0.0
var TY: float = 0.0
var texto = null
var new_texto = null
var active: float = 0.0
var c_title: float = 0.0
var text_temp = null


# from objects/obj_input/Create_0.gml
func _create() -> void:
	can_write = 1.0
	TX = 344.0
	TY = 21.0
	texto = ""
	new_texto = ""
	GM.keyboard_string = ""
	image_speed = 0.0
	active = 0.0
	c_title = GM.make_colour_rgb(89.0, 15.0, 16.0)
	#
	# +            buff = string_replace_all(buff, "<", "")
	# +            buff = string_replace_all(buff, ">", "")
	# +            buff = string_replace_all(buff, ":", "")
	# +            buff = string_replace_all(buff, "\"", "")
	# +            buff = string_replace_all(buff, "/", "")
	# +            buff = string_replace_all(buff, "\\", "")
	# +            buff = string_replace_all(buff, "|", "")
	# +            buff = string_replace_all(buff, "?", "")
	# +            buff = string_replace_all(buff, "*", "")


# from objects/obj_input/Destroy_0.gml
func _destroy() -> void:
	GM.keyboard_string = ""


# from objects/obj_input/Step_0.gml
func _step() -> void:
	if GM.instance_find(A.obj_persistent, 0).modo_android == 0.0:
		if can_write == 1.0 and GM.instance_exists(A.obj_window_alert):
			if GM.string_width(GM.string_hash_to_newline((new_texto))) < (TX - 48.0) or GM.keyboard_check(GM.vk_backspace):
				var buff = GM.string_replace_all(GM.keyboard_string, "#", "")
				new_texto = buff
			else:
				GM.keyboard_string = new_texto
		if GM.mouse_check_button_pressed(GM.mb_left):
			if GM.mouse_x >= x and GM.mouse_x <= (x + TX) and GM.mouse_y >= y and GM.mouse_y <= (y + TY):
				var _with_target2 = A.obj_input_desc
				var _other1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target2):
					inst.can_write = 0.0
				GM.other = _other1
				can_write = 1.0
				GM.keyboard_string = new_texto
			else:
				can_write = 0.0
		var banned_chars = ["<", ">", ":", "\"", "/", "\\", "|", "?", "*", "ñ", "Ñ", "á", "à", "â", "ã", "å", "ā", "ä", "ç", "ć", "č", "é", "è", "ë", "ê", "ę", "ė", "ē", "í", "ï", "ì", "î", "į", "ī", "ó", "ò", "ö", "ô", "õ", "ø", "ú", "ü", "ù", "û", "ū"]
		var i = 0.0
		while i < GM.array_length(banned_chars):
			new_texto = GM.string_replace_all(new_texto, banned_chars[i], "")
			i += 1.0


# from objects/obj_input/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_title)
	GM.draw_text((x + 16.0), (y + 3.0), GM.string_hash_to_newline(new_texto))


# from objects/obj_input/Mouse_4.gml
func _mouse_4() -> void:
	pass  # Android native input is excluded; desktop uses the in-game text field.
