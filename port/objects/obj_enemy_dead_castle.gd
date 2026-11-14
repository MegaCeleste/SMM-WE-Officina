extends GMObject

var direct: float = 0.0
var modo_lava: float = 0.0


# from objects/obj_enemy_dead_castle/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	gravity = 0.0
	direct = 1.0
	modo_lava = 0.0


# from objects/obj_enemy_dead_castle/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
		if G.apariencia != 0.0:
			GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_lava)
		modo_lava = 1.0
	if not GM.instance_exists(A.obj_deadmario):
		if modo_lava == 1.0 and gravity != 0.0:
			gravity = 0.1
			if vspeed > 1.0:
				vspeed = 1.0
		elif modo_lava == 0.0 and gravity != 0.0:
			gravity = 0.2
			if vspeed > 2.0:
				vspeed = 2.0
	if y > GM.room_height or (vspeed > 0.0 and GM.instance_exists(A.obj_lava_water) and (y - 32.0) > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_enemy_dead_castle/Alarm_0.gml
func _alarm_0() -> void:
	if sprite_index != A.spr_SMB_thwomp and sprite_index != A.spr_rocky_idle and sprite_index != A.spr_rocky_idle2 and sprite_index != A.spr_rocky_throw and sprite_index != A.spr_SMB_thwomp_h and sprite_index != A.spr_SMB3_thwomp and sprite_index != A.spr_SMB3_thwomp_h and sprite_index != A.spr_thwomp and sprite_index != A.spr_thwomp_h and sprite_index != A.spr_NSMBU_thwomp and sprite_index != A.spr_NSMBU_thwomp_h and sprite_index != A.spr_grrrol_old and sprite_index != A.spr_spiny_wings and sprite_index != A.spr_bulletbill_red and sprite_index != A.spr_billbanzai_red and sprite_index != A.spr_billbanzai_red_i and sprite_index != A.spr_NSMBU_banzaibill and sprite_index != A.spr_SMB3_banzaibill and sprite_index != A.spr_SMB_banzaibill and sprite_index != A.spr_SMB3_bulletbill_red and sprite_index != A.spr_SMB3_bulletbill and sprite_index != A.spr_SMB_bulletbill and sprite_index != A.spr_SMB_bulletbill_red and sprite_index != A.spr_SMB_cannonball and sprite_index != A.spr_SMB3_cannonball and sprite_index != A.spr_cannonball and sprite_index != A.spr_NSMBU_cannonball:
		if G.apariencia == 3.0:
			image_speed = 1.0
			GM.audio_stop_sound(A.snd_NSMBU_bowser_castle1)
			GM.audio_play_sound(A.snd_NSMBU_bowser_castle1, 0.0, false)
		else:
			image_speed = 0.25


# from objects/obj_enemy_dead_castle/Alarm_1.gml
func _alarm_1() -> void:
	gravity = 0.1
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB_bowser_dead)
			GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB_bowser_dead)
			GM.audio_play_sound(A.snd_SMB_bowser_dead, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_enemy_fall_castle)
			GM.audio_play_sound(A.snd_enemy_fall_castle, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_bowser_castle2)
			GM.audio_play_sound(A.snd_NSMBU_bowser_castle2, 0.0, false)


# from objects/obj_enemy_dead_castle/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, direct, 1.0, image_angle, GM.c_white, 1.0)
