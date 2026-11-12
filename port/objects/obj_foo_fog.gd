extends GMObject

var angle: float = 0.0
var scale: float = 0.0
var alpha: float = 0.0
var player = null
var player2 = null


# from objects/obj_foo_fog/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_foo_fog
	angle = 0.0
	scale = 0.0
	alpha = 1.0


# from objects/obj_foo_fog/Step_0.gml
func _step() -> void:
	friction = 0.005
	player = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_mario, true, false)
	player2 = collision_rectangle((bbox_left - 8.0), (bbox_top - 8.0), (bbox_right + 8.0), (bbox_bottom + 8.0), A.obj_marioU, true, false)
	if player != null and player.stompstyle > 0.0:
		alpha -= 0.05
		if alpha < 0.05:
			instance_destroy()
	elif G.apariencia == 3.0 and player2 != null and (player2.helice_fly == 1.0 or player2.helice_fly == 4.0):
		alpha -= 0.5
		if alpha < 0.5:
			instance_destroy()
	else:
		alpha -= 0.0025
		if alpha < 0.0025:
			instance_destroy()
	angle -= (1.0 * hspeed)
	scale += 0.02
	if scale > 1.0:
		scale = 1.0


# from objects/obj_foo_fog/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), scale, scale, angle, GM.c_white, alpha)
