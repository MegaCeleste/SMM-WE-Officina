extends "res://objects/obj_bowser_fire.gd"


# from objects/obj_NSMBU_bowser_fire_up/Create_0.gml
func _create() -> void:
	image_speed = 0.5
	direct = -1.0
	decender = 0.0
	gravity = 0.0


# from objects/obj_NSMBU_bowser_fire_up/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_smokespin
	instance_destroy()


# from objects/obj_NSMBU_bowser_fire_up/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, direction, GM.c_white, 1.0)
