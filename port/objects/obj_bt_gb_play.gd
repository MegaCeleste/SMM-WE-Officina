extends GMObject

var c_button: float = 0.0
var icon: float = 0.0
var text = null
var posy: float = 0.0
var press: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_bt_gb_play/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	c_button = GM.make_colour_rgb(29.0, 42.0, 67.0)
	icon = 0.0
	text = Scr.scr_language(self, 11.0)
	posy = 2.0
	press = 0.0
	alarm[0] = 15.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_bt_gb_play/Alarm_0.gml
func _alarm_0() -> void:
	press = 1.0


# from objects/obj_bt_gb_play/Alarm_1.gml
func _alarm_1() -> void:
	G.level_g = 1.0
	GM.room_goto(A.rm_guardabot_play)


# from objects/obj_bt_gb_play/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_button)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((x + (sprite_width / 2.0)), (y + posy), GM.string_hash_to_newline((text)))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_sprite(A.spr_gb_btn_icons, icon, x, y)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 1.0)


# from objects/obj_bt_gb_play/Mouse_4.gml
func _mouse_4() -> void:
	if G.levelguardabot != "" and press == 1.0 and image_index == 0.0 and GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
		image_index = 1.0
		c_button = GM.make_colour_rgb(253.0, 203.0, 0.0)
		GM.audio_stop_sound(A.snd_guardabot)
		GM.audio_play_sound(A.snd_inventory, 0.0, false)
		alarm[1] = 6.0


# from objects/obj_bt_gb_play/Mouse_10.gml
func _mouse_10() -> void:
	if GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_bt_gb_play/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
