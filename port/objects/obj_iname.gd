extends GMObject

var write: float = 0.0
var TX: float = 0.0
var TY: float = 0.0
var texto: String = ""
var new_texto: String = ""

# from objects/obj_iname/Create_0.gml
func _create() -> void:
	write = 1.0
	TX = 132.0
	TY = 20.0
	texto = ""
	new_texto = ""
	GM.keyboard_string = ""
	image_speed = 0.0
	image_index = 0.0

# from objects/obj_iname/Destroy_0.gml
func _destroy() -> void:
	GM.keyboard_string = ""

# from objects/obj_iname/Step_0.gml
func _step() -> void:
	image_index = write
	if write == 1.0:
		if GM.string_width(GM.string_hash_to_newline(new_texto)) < TX or GM.keyboard_check(GM.vk_backspace):
			new_texto = GM.string_replace_all(GM.keyboard_string, "#", "")
		else:
			GM.keyboard_string = new_texto
	if GM.mouse_check_button_pressed(GM.mb_left):
		if GM.mouse_x >= x and GM.mouse_x <= x + TX and GM.mouse_y >= y and GM.mouse_y <= y + TY:
			for inst in GM.with_list(A.obj_lp):
				inst.write = 0.0
			write = 1.0
			GM.keyboard_string = new_texto
		else:
			write = 0.0
	if GM.keyboard_check(GM.vk_return):
		write = 0.0

# from objects/obj_iname/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_black)
	var new_string: String = new_texto
	if GM.string_width(GM.string_hash_to_newline(new_texto)) > 100.0:
		new_string = GM.string_copy(new_texto, 0.0, 20.0) + "..."
	GM.draw_text(x + 20.0, y + 2.0, GM.string_hash_to_newline(new_string))

# Mouse_4 and Other_63 handle Android input, which is outside the port's scope.
