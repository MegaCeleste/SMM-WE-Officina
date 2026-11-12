# from objects/obj_propellershroom（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var block_out: float = 0.0
var y_start: float = 0.0
var dist: float = 0.0


# from objects/obj_propellershroom/Create_0.gml
func _create() -> void:
	block_out = 0.0
	y_start = y
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	swimming = 0.0
	paracaidas = 0.0
	progresivo = 0.0
	dist = 0.0
	sprite_wings = A.spr_NSMBU_wings_items
	image_speed = 0.5
	alarm[10] = 1.0


# from objects/obj_propellershroom/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0 and paracaidas == 0.0:
		match dist:
			0.0:
				if y > (y_start + 48.0):
					if vspeed < -0.5:
						vspeed = -0.5
					else:
						vspeed -= 0.015
				elif vspeed < 0.0:
					dist = 1.0
			1.0:
				if y < (y_start + 48.0):
					if vspeed > 0.5:
						vspeed = 0.5
					else:
						vspeed += 0.015
				elif vspeed > 0.0:
					dist = 2.0
			2.0:
				if y > (y_start + 80.0):
					if vspeed < -0.5:
						vspeed = -0.5
					else:
						vspeed -= 0.015
				elif vspeed < 0.0:
					dist = 3.0
			3.0:
				if y < (y_start + 48.0):
					if vspeed > 0.5:
						vspeed = 0.5
					else:
						vspeed += 0.015
				elif vspeed > 0.0:
					dist = 4.0
			4.0:
				if y > (y_start + 64.0):
					if vspeed < -0.5:
						vspeed = -0.5
					else:
						vspeed -= 0.015
				elif vspeed < 0.0:
					dist = 5.0
			5.0:
				image_speed = 1.0
				if vspeed < -2.0:
					vspeed = -2.0
				else:
					vspeed -= 0.15
	if Scr.outside_view(self) == 1.0 and dist == 5.0:  # outside_view() 返回值只有 1/0
		instance_destroy()


# from objects/obj_propellershroom/Alarm_10.gml
func _alarm_10() -> void:
	if block_out == 1.0:
		vspeed = -1.0
		block_out = 0.0
		alarm[10] = 60.0
	elif wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	else:
		y_start = y
		vspeed = 1.0
		hspeed = 0.5
