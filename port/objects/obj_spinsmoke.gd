extends "res://objects/obj_smoke.gd"

var starx: float = 0.0
var stary: float = 0.0
var starstop: float = 0.0


# from objects/obj_spinsmoke/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_smokespin
		image_speed = 0.25
	else:
		GM.audio_play_sound(A.snd_spinstomp, 0.0, false)
		image_speed = 0.3
	starx = 0.0
	stary = 0.0
	starstop = 0.0
	alarm[0] = 1.0
	alarm[1] = 16.0


# from objects/obj_spinsmoke/Alarm_0.gml
func _alarm_0() -> void:
	starx += 2.0
	stary += 1.0
	if starstop == 0.0:
		alarm[0] = 1.0


# from objects/obj_spinsmoke/Alarm_1.gml
func _alarm_1() -> void:
	starstop = 1.0


# from objects/obj_spinsmoke/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, -1.0, GM.gm_round(x), GM.gm_round(y))
	if starstop == 0.0:
		GM.draw_sprite(A.spr_star_explosion, 0.0, ((GM.gm_round(x) + starx) + 8.0), ((GM.gm_round(y) + stary) + 8.0))
		GM.draw_sprite(A.spr_star_explosion, 0.0, ((GM.gm_round(x) + starx) + 8.0), ((GM.gm_round(y) - stary) + 8.0))
		GM.draw_sprite(A.spr_star_explosion, 0.0, ((GM.gm_round(x) - starx) + 8.0), ((GM.gm_round(y) + stary) + 8.0))
		GM.draw_sprite(A.spr_star_explosion, 0.0, ((GM.gm_round(x) - starx) + 8.0), ((GM.gm_round(y) - stary) + 8.0))
