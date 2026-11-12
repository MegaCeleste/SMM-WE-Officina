extends "res://objects/obj_cinta_parent.gd"

var sprite: int = 0  ## sprite 编号
var sprite1: int = 0  ## sprite 编号
var sprite2: int = 0  ## sprite 编号
var sprite3: int = 0  ## sprite 编号
var size_x: float = 0.0
var velocidad: float = 0.0
var direct_t: float = 0.0
var stop: float = 0.0
var h: float = 0.0


# from objects/obj_cinta/Create_0.gml
func _create() -> void:
	sprite = 0
	if G.apariencia == 0.0:
		if G.bg_level == "castle":
			sprite1 = A.spr_SMB_cinta_left_dark
			sprite2 = A.spr_SMB_cinta_middle_dark
			sprite3 = A.spr_SMB_cinta_right_dark
		elif (G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0)):
			sprite1 = A.spr_SMB_cinta_left_night
			sprite2 = A.spr_SMB_cinta_middle_night
			sprite3 = A.spr_SMB_cinta_right_night
		else:
			sprite1 = A.spr_SMB_cinta_left
			sprite2 = A.spr_SMB_cinta_middle
			sprite3 = A.spr_SMB_cinta_right
	elif G.apariencia == 1.0:
		if G.bg_level == "castle":
			sprite1 = A.spr_SMB3_cinta_left_dark
			sprite2 = A.spr_SMB3_cinta_middle_dark
			sprite3 = A.spr_SMB3_cinta_right_dark
		elif (G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0)):
			sprite1 = A.spr_SMB3_cinta_left_night
			sprite2 = A.spr_SMB3_cinta_middle_night
			sprite3 = A.spr_SMB3_cinta_right_night
		else:
			sprite1 = A.spr_SMB3_cinta_left
			sprite2 = A.spr_SMB3_cinta_middle
			sprite3 = A.spr_SMB3_cinta_right
	elif G.apariencia == 2.0:
		sprite1 = A.spr_cinta_left
		sprite2 = A.spr_cinta_middle
		sprite3 = A.spr_cinta_right
	else:
		sprite1 = A.spr_NSMBU_cinta_left
		sprite2 = A.spr_NSMBU_cinta_middle
		sprite3 = A.spr_NSMBU_cinta_right
	size_x = 4.0
	velocidad = 0.0
	image_speed = 0.0
	direct_t = 0.0
	stop = 0.0


# from objects/obj_cinta/Step_0.gml
func _step() -> void:
	if not GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
		if velocidad == 0.0:
			if direct_t == 1.0:
				image_speed = -1.0
			else:
				image_speed = 1.0
		elif direct_t == 1.0:
			image_speed = -2.0
		else:
			image_speed = 2.0
	else:
		image_speed = 0.0


# from objects/obj_cinta/Draw_0.gml
func _gm_draw() -> void:
	h = 0.0
	while h < size_x:
		if h == 0.0:
			sprite = sprite1
		elif h == (size_x - 1.0):
			sprite = sprite3
		else:
			sprite = sprite2
		GM.draw_sprite(sprite, image_index, (x + (h * 16.0)), y)
		h += 1.0
