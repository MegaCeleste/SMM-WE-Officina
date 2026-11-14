extends GMObject

var v_speed: float = 0.0
var effect_hover: float = 0.0
var anim: float = 0.0
var sprite_object: float = 0.0
var index_object = null
var id_object = null
var value: float = 0.0
var transform: float = 0.0


# from objects/obj_window_button/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	v_speed = 0.2
	effect_hover = 0.0
	anim = 0.0
	if GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0:
		sprite_object = A.spr_cards_sounds
	else:
		match G.apariencia:
			0.0:
				sprite_object = A.spr_cards_SMB
			1.0:
				sprite_object = A.spr_cards_SMB3
			2.0:
				sprite_object = A.spr_cards_SMW
			3.0:
				sprite_object = A.spr_cards_NSMBU
	index_object = 0.0
	id_object = A.obj_lighting
	value = 0.0
	transform = 0.0


# from objects/obj_window_button/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_sprite(sprite_object, index_object, (x + 1.0), (y - 5.0))
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 0.0)


# from objects/obj_window_button/Mouse_4.gml
func _mouse_4() -> void:
	if transform != 4.0:
		GM.audio_play_sound(A.snd_cambio_objecto, 0.0, false)
	if image_index == 0.0:
		if not GM.veq(id_object, A.obj_lighting) and GM.instance_exists(id_object):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(id_object):
				inst.transform = self.transform
				inst.event_user(1)
			GM.other = _o
	for inst in GM.with_list(A.obj_ventana):
		inst.can_anim2 = 1.0


# from objects/obj_window_button/Mouse_10.gml
func _mouse_10() -> void:
	if effect_hover == 0.0:
		GM.audio_stop_sound(A.snd_miniwindow_desplazarse)
		GM.audio_play_sound(A.snd_miniwindow_desplazarse, 0.0, false)
	effect_hover = 1.0


# from objects/obj_window_button/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
