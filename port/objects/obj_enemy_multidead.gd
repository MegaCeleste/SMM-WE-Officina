extends GMObject

var count: float = 0.0
var spd: float = 0.0
var direct: float = 0.0
var imdead = null


# from objects/obj_enemy_multidead/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	alarm[0] = 3.0
	count = 0.0
	spd = -4.0
	direct = -1.0


# from objects/obj_enemy_multidead/Alarm_0.gml
func _alarm_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.sprite_index = sprite_index
	imdead.direct = direct
	imdead.vspeed = spd
	count -= 1.0
	if count > 0.0:
		alarm[0] = 3.0
	else:
		instance_destroy()


# from objects/obj_enemy_multidead/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, 1.0)
