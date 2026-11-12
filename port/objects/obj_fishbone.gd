extends "res://objects/obj_deactenemyparent.gd"

var offset: float = 0.0
var offsetnext: float = 0.0


# from objects/obj_fishbone/Create_0.gml
func _create() -> void:
	# /A skeleton of a fish
	# How vulnerable is this enemy to various items?
	hardness = 1.0
	# How vulnerable is this enemy to Mario?
	stomp = 2.0
	# Facing direction
	direct = -1.0
	# Start moving towards Mario
	alarm[10] = 2.0
	# Animate
	image_speed = 0.15
	# Offset values
	offset = 0.0
	offsetnext = 0.0
	# Blink
	alarm[0] = 100.0
	# Start moving
	alarm[10] = 2.0


# from objects/obj_fishbone/Step_0.gml
func _step() -> void:
	# /Blurp logic
	# Update facing direction
	if hspeed > 0.0:
		direct = 1.0
	elif hspeed < 0.0:
		direct = -1.0
	# Wave
	if y > ystart:
		vspeed -= 0.0125
	elif y < ystart:
		vspeed += 0.0125


# from objects/obj_fishbone/Alarm_0.gml
func _alarm_0() -> void:
	# /Blink
	sprite_index = A.spr_fishbone
	alarm[1] = 30.0


# from objects/obj_fishbone/Alarm_1.gml
func _alarm_1() -> void:
	# /Open eyes
	sprite_index = A.spr_fishbone
	alarm[0] = 60.0 + GM.gm_round(GM.random(120.0))


# from objects/obj_fishbone/Alarm_10.gml
func _alarm_10() -> void:
	# /Start moving
	# Inherit event
	super._alarm_10()
	# Set the vertical speed
	vspeed = 0.25


# from objects/obj_fishbone/Other_0.gml
func _outside_room() -> void:
	# /Destroy
	instance_destroy()


# from objects/obj_fishbone/Other_14.gml
func _user_4() -> void:
	# /Turn at slopes
	if (hspeed > 0.0 and collision_point(bbox_right, bbox_bottom, A.obj_slopeparent, true, false) != null) or (hspeed < 0.0 and collision_point(bbox_left, bbox_bottom, A.obj_slopeparent, true, false) != null):
		hspeed = -hspeed


# from objects/obj_fishbone/Draw_0.gml
func _gm_draw() -> void:
	# /Draw Fishbone
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
