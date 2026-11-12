# from objects/obj_megamushroom（第 5 批移植，已核对）
extends "res://objects/obj_powerupparent.gd"

var t_mario: String = ""
var jump: float = 0.0


# from objects/obj_megamushroom/Create_0.gml
func _create() -> void:
	swimming = 0.0
	t_mario = ""
	jump = 0.0
	wings = 0.0
	wings_anim = 0.0
	direct = -1.0
	paracaidas = 0.0
	progresivo = 0.0
	sprite_wings = A.spr_SMB_wings_32x32
	alarm[10] = 4.0


# from objects/obj_megamushroom/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
			if hspeed > 1.0:
				hspeed -= 0.08
				if hspeed <= 1.0:
					hspeed = 1.0
			elif hspeed < -1.0:
				hspeed += 0.08
				if hspeed >= -1.0:
					hspeed = -1.0
		elif hspeed > 1.1:
			hspeed -= 0.08
			if hspeed <= 1.1:
				hspeed = 1.1
		elif hspeed < -1.1:
			hspeed += 0.08
			if hspeed >= -1.1:
				hspeed = -1.1


# from objects/obj_megamushroom/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	if paracaidas == 0.0:
		hspeed = (1.0 - (0.5 * swimming))
