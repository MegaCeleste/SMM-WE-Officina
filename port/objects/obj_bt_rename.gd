extends GMObject

var c_button: float = 0.0
var text: String = ""
var effect_hover: float = 0.0
var anim: float = 0.0
var posy: float = 0.0
var rot: float = 0.0
var press: float = 0.0
var c_disabled: float = 0.0
var disabled: float = 0.0


# from objects/obj_bt_rename/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 2.0
	c_button = GM.make_colour_rgb(25.0, 42.0, 67.0)
	text = "Nombre"
	effect_hover = 0.0
	anim = 0.0
	posy = 6.0
	rot = 0.0
	press = 1.0
	c_disabled = GM.make_colour_rgb(110.0, 119.0, 126.0)
	disabled = 1.0


# from objects/obj_bt_rename/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_disabled)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((x + (sprite_width / 2.0)), (y + posy), GM.string_hash_to_newline((text)))
	GM.draw_set_halign(GM.fa_left)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)


# from objects/obj_bt_rename/Mouse_4.gml
func _mouse_4() -> void:
	if disabled == 0.0:
		if G.levelguardabot != "" and press == 1.0 and image_index == 0.0 and GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
			GM.audio_play_sound(A.snd_aceptar, 0.0, false)
			GM.instance_create_depth((GM.camera_get_view_x(GM.view_get_camera(0)) + 112.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 12.0), -22.0, A.obj_rename_control)


# from objects/obj_bt_rename/Mouse_10.gml
func _mouse_10() -> void:
	if disabled == 0.0:
		if GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
			if effect_hover == 0.0:
				GM.audio_stop_sound(A.snd_panel_right_move)
				GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
			effect_hover = 1.0


# from objects/obj_bt_rename/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
