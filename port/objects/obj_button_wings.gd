extends GMObject

var s_sprite: float = 0.0
var s_index: float = 0.0
var id_object = null
var s_contorno = null
var powerup: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0


# from objects/obj_button_wings/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			s_sprite = A.spr_window_button_SMB
		1.0:
			s_sprite = A.spr_window_button_SMB3
		2.0:
			s_sprite = A.spr_window_button_SMW
		3.0:
			s_sprite = A.spr_window_button_NSMBU
	image_speed = 0.0
	s_index = 0.0
	id_object = A.obj_lighting
	s_contorno = 0.0
	powerup = 1.0
	effect_hover = 0.0
	anim = 0.0


# from objects/obj_button_wings/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_sprite(s_sprite, s_index, x, y)
	GM.draw_sprite(A.spr_window_button_add, s_contorno, x, y)
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 0.0)


# from objects/obj_button_wings/Mouse_4.gml
func _mouse_4() -> void:
	if s_index == 0.0:
		if not GM.veq(id_object, A.obj_lighting) and GM.instance_exists(id_object):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(id_object):
				inst.event_user(3)
			GM.other = _o
	elif s_index == 1.0:
		if not GM.veq(id_object, A.obj_lighting) and GM.instance_exists(id_object):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(id_object):
				inst.event_user(4)
			GM.other = _o
	elif s_index == 2.0:
		if not GM.veq(id_object, A.obj_lighting) and GM.instance_exists(id_object):
			for inst in GM.with_list(id_object):
				if inst.paracaidas == 0.0:
					GM.audio_play_sound(A.snd_add_paracaidas, 0.0, false)
					inst.paracaidas = 1.0
				else:
					GM.audio_play_sound(A.snd_remove_wings, 0.0, false)
					GM.instance_create((inst.x + inst.para_x), (inst.y - inst.para_y), A.obj_paracaidas_dead)
					inst.paracaidas = 0.0
	elif s_index == 3.0:
		if not GM.veq(id_object, A.obj_lighting) and GM.instance_exists(id_object):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(id_object):
				inst.event_user(5)
			GM.other = _o
	for inst in GM.with_list(A.obj_ventana):
		inst.can_anim2 = 1.0


# from objects/obj_button_wings/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_miniwindow_desplazarse)
		GM.audio_play_sound(A.snd_miniwindow_desplazarse, 0.0, false)
	effect_hover = 1.0


# from objects/obj_button_wings/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
