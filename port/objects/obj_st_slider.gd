extends GMObject

var value_: float = 0.0
var max_value_: float = 0.0
var selected_: float = 0.0
var index: float = 0.0
var c_letters: float = 0.0


# from objects/obj_st_slider/Create_0.gml
func _create() -> void:
	value_ = G.audiomaster
	max_value_ = 1.0
	selected_ = 0.0
	index = 0.0
	image_speed = 0.0
	image_index = 0.0
	c_letters = GM.make_colour_rgb(89.0, 15.0, 16.0)


# from objects/obj_st_slider/Step_0.gml
func _step() -> void:
	var button_x
	var button_y
	var button_radius
	if GM.mouse_check_button_pressed(GM.mb_left):
		button_x = (x + (sprite_width * value_))
		button_y = y
		button_radius = (GM.sprite_get_width(A.spr_st_slider) / 2.0)
		if GM.point_in_circle(GM.mouse_x, GM.mouse_y, button_x, button_y, button_radius):
			selected_ = 1.0
			index = 1.0
	if not GM.mouse_check_button(GM.mb_left):
		selected_ = 0.0
		index = 0.0
	if selected_ > 0.5:
		value_ = clampf(((GM.mouse_x - x) / sprite_width), 0.0, max_value_)
		_user_0()


# from objects/obj_st_slider/Other_10.gml
func _user_0() -> void:
	GM.audio_master_gain(value_)
	G.audiomaster = value_


# from objects/obj_st_slider/Draw_0.gml
func _gm_draw() -> void:
	var porcentaje
	draw_self()
	GM.draw_sprite_part(sprite_index, 1.0, 0.0, 0.0, (sprite_width * value_), sprite_height, x, (y - GM.sprite_get_yoffset(sprite_index)))
	GM.draw_sprite(A.spr_st_slider, index, (x + (sprite_width * value_)), (y + 1.0))
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_letters)
	porcentaje = GM.gm_round((value_ * 100.0))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 324.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 140.0), GM.string_hash_to_newline((GM.string(porcentaje) + "%")))
