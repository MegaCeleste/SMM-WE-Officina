extends GMObject

var can_anim: float = 0.0
var can_anim2: float = 0.0
var anim: float = 0.0


# from objects/obj_ventana_water/Create_0.gml
func _create() -> void:
	can_anim = 1.0
	can_anim2 = 0.0
	anim = 0.6
	GM.audio_play_sound(A.snd_open_windows, 0.0, false)


# from objects/obj_ventana_water/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_button_speed_water):
		for inst in GM.with_list(A.obj_button_speed_water):
			inst.instance_destroy()


# from objects/obj_ventana_water/Step_2.gml
func _step_end() -> void:
	if can_anim == 1.0:
		if anim < 1.0:
			anim += 0.08
		else:
			_user_0()
			anim = 1.0
			can_anim = 0.0
		image_xscale = anim
		image_yscale = anim
	if can_anim2 == 1.0:
		if GM.instance_exists(A.obj_button_speed_water):
			for inst in GM.with_list(A.obj_button_speed_water):
				inst.instance_destroy()
		if anim > 0.6:
			anim -= 0.15
		else:
			instance_destroy()
		image_xscale = anim
		image_yscale = anim


# from objects/obj_ventana_water/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - 90.0), (y - 37.0), A.obj_button_speed_water)):
		inst.image_index = 0.0
		inst.v_speed = 0.2
	for inst in GM.with_list(GM.instance_create((x - 65.0), (y - 37.0), A.obj_button_speed_water)):
		inst.image_index = 1.0
		inst.v_speed = 0.5
	for inst in GM.with_list(GM.instance_create((x - 40.0), (y - 37.0), A.obj_button_speed_water)):
		inst.image_index = 2.0
		inst.v_speed = 0.8
