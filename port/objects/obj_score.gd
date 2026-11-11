extends GMObject

var fade: float = 0.0
var scale: float = 0.0


# from objects/obj_score/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_points
		1.0:
			sprite_index = A.spr_SMB_points
		2.0:
			sprite_index = A.spr_points
		3.0:
			sprite_index = A.spr_NSMBU_points
	image_speed = 0.0
	fade = 0.0
	scale = 1.0
	vspeed = -1.0
	friction = 0.0175


# from objects/obj_score/Step_0.gml
func _step() -> void:
	if vspeed == 0.0:
		fade += 0.05
		if fade > 1.0:
			instance_destroy()
	if y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0):
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0)


# from objects/obj_score/Other_10.gml
func _user_0() -> void:
	image_index = 1.0
	GM.score += 200.0


# from objects/obj_score/Other_11.gml
func _user_1() -> void:
	image_index = 2.0
	GM.score += 400.0


# from objects/obj_score/Other_12.gml
func _user_2() -> void:
	image_index = 3.0
	GM.score += 800.0


# from objects/obj_score/Other_13.gml
func _user_3() -> void:
	image_index = 4.0
	GM.score += 1000.0


# from objects/obj_score/Other_14.gml
func _user_4() -> void:
	image_index = 5.0
	GM.score += 2000.0


# from objects/obj_score/Other_15.gml
func _user_5() -> void:
	image_index = 6.0
	GM.score += 4000.0


# from objects/obj_score/Other_16.gml
func _user_6() -> void:
	image_index = 7.0
	GM.score += 8000.0


# from objects/obj_score/Other_17.gml
func _user_7() -> void:
	image_index = 8.0
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_1up_coins)
		GM.audio_play_sound(A.snd_NSMBU_1up_coins, 0.0, false)
	if GM.room != A.rm_editor and GM.room != A.rm_title and G.dsm == 1.0:
		if G.liveleves < 3.0:
			G.liveleves += 1.0


# from objects/obj_score/Other_18.gml
func _user_8() -> void:
	GM.score += 5000.0


# from objects/obj_score/Other_19.gml
func _user_9() -> void:
	GM.score += 10000.0


# from objects/obj_score/Other_20.gml
func _user_10() -> void:
	GM.score += 25000.0


# from objects/obj_score/Other_21.gml
func _user_11() -> void:
	GM.score += 40000.0


# from objects/obj_score/Other_22.gml
func _user_12() -> void:
	visible = false
	GM.score += 100.0


# from objects/obj_score/Draw_0.gml
func _gm_draw() -> void:
	if y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0):
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), scale, scale, 0.0, GM.c_white, 1.0)
		if fade > 0.0:
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, 0.0, GM.c_white, fade)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round((GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0)), scale, scale, 0.0, GM.c_white, 1.0)
		if fade > 0.0:
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round((GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0)), 1.0, 1.0, 0.0, GM.c_white, fade)
