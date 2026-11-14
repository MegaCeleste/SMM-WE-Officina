extends GMObject

var can_write: float = 0.0
var TX: float = 0.0
var TY: float = 0.0
var texto = null
var new_texto = null
var active: float = 0.0
var wrap: float = 0.0
var c_title: float = 0.0
var text_temp = null


# from objects/obj_input_desc/Create_0.gml
func _create() -> void:
	can_write = 1.0
	TX = 344.0
	TY = 21.0
	texto = ""
	new_texto = ""
	active = 0.0
	GM.keyboard_string = ""
	image_speed = 0.0
	wrap = 0.0
	c_title = GM.make_colour_rgb(89.0, 15.0, 16.0)


# from objects/obj_input_desc/Destroy_0.gml
func _destroy() -> void:
	GM.keyboard_string = ""


# from objects/obj_input_desc/Step_0.gml
func _step() -> void:
	var buff
	if GM.instance_find(A.obj_persistent, 0).modo_android == 0.0:
		if can_write == 1.0 and GM.instance_exists(A.obj_window_alert):
			if GM.string_length(GM.string_hash_to_newline(new_texto)) <= 91.0 or GM.keyboard_check(GM.vk_backspace):
				buff = GM.string_replace_all(GM.keyboard_string, "#", "")
				new_texto = buff
			else:
				GM.keyboard_string = new_texto
		if GM.mouse_check_button_pressed(GM.mb_left):
			if GM.mouse_x >= x and GM.mouse_x <= (x + (TX - 26.0)) and GM.mouse_y >= y and GM.mouse_y <= (y + TY):
				var _with_target2 = A.obj_input
				var _other1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(_with_target2):
					inst.can_write = 0.0
				GM.other = _other1
				can_write = 1.0
				GM.keyboard_string = new_texto
			else:
				can_write = 0.0
		if GM.string_length(GM.string_hash_to_newline(new_texto)) == 48.0 and wrap == 0.0:
			GM.keyboard_string += "\n"
			wrap = 1.0
		elif GM.string_length(GM.string_hash_to_newline(new_texto)) == 48.0 and wrap == 1.0:
			wrap = 0.0
	G.desc = new_texto


# from objects/obj_input_desc/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_title)
	GM.draw_text((x + 32.0), (y + 3.0), GM.string_hash_to_newline(new_texto))
	GM.draw_text((x + 320.0), (y + 20.0), GM.string(GM.string_hash_to_newline(GM.string_length(new_texto))) + GM.string("/92"))


# from objects/obj_input_desc/Mouse_4.gml
func _mouse_4() -> void:
	pass  # Android native input is excluded; desktop uses the in-game field.
