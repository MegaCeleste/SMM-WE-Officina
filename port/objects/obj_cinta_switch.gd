extends "res://objects/obj_cinta_parent.gd"

var sprite: int = 0  ## sprite 编号
var sprite1: int = 0  ## sprite 编号
var sprite2: int = 0  ## sprite 编号
var sprite3: int = 0  ## sprite 编号
var size_x: float = 0.0
var velocidad: float = 0.0
var direct_t: float = 0.0
var h: float = 0.0


# from objects/obj_cinta_switch/Create_0.gml
func _create() -> void:
	sprite = 0
	if G.apariencia == 0.0:
		sprite1 = A.spr_SMB_cinta_off_left
		sprite2 = A.spr_SMB_cinta_off_middle
		sprite3 = A.spr_SMB_cinta_off_right
	elif G.apariencia == 1.0:
		sprite1 = A.spr_SMB3_cinta_off_left
		sprite2 = A.spr_SMB3_cinta_off_middle
		sprite3 = A.spr_SMB3_cinta_off_right
	elif G.apariencia == 2.0:
		sprite1 = A.spr_cinta_off_left
		sprite2 = A.spr_cinta_off_middle
		sprite3 = A.spr_cinta_off_right
	else:
		sprite1 = A.spr_SMB_cinta_off_left
		sprite2 = A.spr_SMB_cinta_off_middle
		sprite3 = A.spr_SMB_cinta_off_right
	size_x = 4.0
	velocidad = 0.0
	image_speed = 0.0
	direct_t = 0.0


# from objects/obj_cinta_switch/Step_0.gml
func _step() -> void:
	if not GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
		if G.onoffblock == 0.0:
			if G.apariencia == 0.0:
				sprite1 = A.spr_SMB_cinta_on_left
				sprite2 = A.spr_SMB_cinta_on_middle
				sprite3 = A.spr_SMB_cinta_on_right
			elif G.apariencia == 1.0:
				sprite1 = A.spr_SMB3_cinta_on_left
				sprite2 = A.spr_SMB3_cinta_on_middle
				sprite3 = A.spr_SMB3_cinta_on_right
			elif G.apariencia == 3.0:
				sprite1 = A.spr_NSMBU_cinta_left
				sprite2 = A.spr_NSMBU_cinta_middle
				sprite3 = A.spr_NSMBU_cinta_right
			else:
				sprite1 = A.spr_cinta_on_left
				sprite2 = A.spr_cinta_on_middle
				sprite3 = A.spr_cinta_on_right
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
			if G.apariencia == 0.0:
				sprite1 = A.spr_SMB_cinta_off_left
				sprite2 = A.spr_SMB_cinta_off_middle
				sprite3 = A.spr_SMB_cinta_off_right
			elif G.apariencia == 1.0:
				sprite1 = A.spr_SMB3_cinta_off_left
				sprite2 = A.spr_SMB3_cinta_off_middle
				sprite3 = A.spr_SMB3_cinta_off_right
			elif G.apariencia == 3.0:
				sprite1 = A.spr_NSMBU_cinta_left
				sprite2 = A.spr_NSMBU_cinta_middle
				sprite3 = A.spr_NSMBU_cinta_right
			else:
				sprite1 = A.spr_cinta_off_left
				sprite2 = A.spr_cinta_off_middle
				sprite3 = A.spr_cinta_off_right
			if velocidad == 0.0:
				if direct_t == 1.0:
					image_speed = 1.0
				else:
					image_speed = -1.0
			elif direct_t == 1.0:
				image_speed = 2.0
			else:
				image_speed = -2.0
	else:
		image_speed = 0.0


# from objects/obj_cinta_switch/Draw_0.gml
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
