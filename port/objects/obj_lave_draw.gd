extends GMObject

var num_tile_ancho: float = 0.0
var num_tile_alto: float = 0.0
var num_ancho: float = 0.0
var num_alto: float = 0.0
var i: float = 0.0


# from objects/obj_lave_draw/Create_0.gml
func _create() -> void:
	image_speed = 0.1
	if G.apariencia == 0.0:
		if G.modo_noche == 1.0 and G.bg_level == "forest":
			sprite_index = A.spr_SMB_lava_purple
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB_lava
		elif G.modo_noche == 1.0 and G.bg_level == "mountain":
			sprite_index = A.spr_SMB_lava
	elif G.apariencia == 1.0:
		if G.modo_noche == 1.0 and G.bg_level == "forest":
			sprite_index = A.spr_SMB3_lava_purple
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB3_lava
		elif G.modo_noche == 1.0 and G.bg_level == "mountain":
			sprite_index = A.spr_SMB3_lava
	elif G.apariencia == 2.0:
		if G.modo_noche == 1.0 and G.bg_level == "forest":
			sprite_index = A.spr_lava_purple
		elif G.bg_level == "castle":
			sprite_index = A.spr_lava
		elif G.modo_noche == 1.0 and G.bg_level == "mountain":
			sprite_index = A.spr_lava


# from objects/obj_lave_draw/Step_0.gml
func _step() -> void:
	if G.apariencia == 0.0:
		if G.modo_noche == 1.0 and G.bg_level == "forest":
			sprite_index = A.spr_SMB_lava_purple
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB_lava
		elif G.modo_noche == 1.0 and G.bg_level == "mountain":
			sprite_index = A.spr_SMB_lava
	elif G.apariencia == 1.0:
		if G.modo_noche == 1.0 and G.bg_level == "forest":
			sprite_index = A.spr_SMB3_lava_purple
		elif G.bg_level == "castle":
			sprite_index = A.spr_SMB3_lava
		elif G.modo_noche == 1.0 and G.bg_level == "mountain":
			sprite_index = A.spr_SMB3_lava
	elif G.apariencia == 2.0:
		if G.modo_noche == 1.0 and G.bg_level == "forest":
			sprite_index = A.spr_lava_purple
		elif G.bg_level == "castle":
			sprite_index = A.spr_lava
		elif G.modo_noche == 1.0 and G.bg_level == "mountain":
			sprite_index = A.spr_lava
	if GM.instance_exists(A.obj_levelmanager):
		if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
			image_speed = 0.0
			image_index = 0.0
			image_alpha = 0.4
		else:
			image_speed = 0.1
			image_alpha = 1.0


# from objects/obj_lave_draw/Draw_0.gml
func _gm_draw() -> void:
	num_tile_ancho = 16.0
	num_tile_alto = 16.0
	num_ancho = ceilf((GM.room_width / num_tile_ancho))
	num_alto = ceilf((GM.room_height / num_tile_alto))
	i = 0.0
	while i < num_ancho:
		GM.draw_sprite_ext(sprite_index, image_index, (i * num_tile_ancho), (GM.room_height - 16.0), 1.0, 1.0, 0.0, GM.c_white, image_alpha)
		i += 1.0
