extends GMObject

var soplete: Array = []
var soplete_num: float = 0.0
var direct_t: float = 0.0
var rotacion: float = 0.0
var invisible: float = 0.0
var sound: float = 0.0
var i = null


# from objects/obj_soplete_invert_global/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			GM.aset(soplete, 0, A.spr_SMB_soplete_start)
			GM.aset(soplete, 1, A.spr_SMB_soplete)
		1.0:
			GM.aset(soplete, 0, A.spr_SMB3_soplete_start)
			GM.aset(soplete, 1, A.spr_SMB3_soplete)
		2.0:
			GM.aset(soplete, 0, A.spr_soplete_start)
			GM.aset(soplete, 1, A.spr_soplete)
		3.0:
			GM.aset(soplete, 0, A.spr_NSMBU_soplete_start)
			GM.aset(soplete, 1, A.spr_NSMBU_soplete)
	soplete_num = 0.0
	direct_t = 0.0
	rotacion = 0.0
	invisible = 1.0
	sound = 0.0
	alarm[0] = 130.0


# from objects/obj_soplete_invert_global/Alarm_0.gml
func _alarm_0() -> void:
	sprite_index = soplete[0]
	soplete_num = 0.0
	image_speed = 0.3
	invisible = 0.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_soplete_invert):
		if Scr.outside_view(inst) <= 0.5:  # GML: !outside_view()
			self.sound = 1.0
	GM.other = _o
	if GM.instance_exists(A.obj_soplete) and sound == 1.0:  # ORIG-BUG: 这里检查的是 obj_soplete 而不是 obj_soplete_invert，照搬
		GM.audio_stop_sound(Scr.scr_snd_soplete(self))
		GM.audio_play_sound(Scr.scr_snd_soplete(self), 0.0, false)
	sound = 0.0


# from objects/obj_soplete_invert_global/Alarm_1.gml
func _alarm_1() -> void:
	sprite_index = soplete[0]
	soplete_num = 0.0
	image_speed = 0.0
	image_index = 3.0
	alarm[2] = 2.0


# from objects/obj_soplete_invert_global/Alarm_2.gml
func _alarm_2() -> void:
	if image_index == 1.0:
		image_index = 0.0
		invisible = 1.0
		alarm[0] = 168.0
	elif image_index > 1.0:
		image_index -= 1.0
		alarm[2] = 4.0


# from objects/obj_soplete_invert_global/Other_7.gml
func _animation_end() -> void:
	if sprite_index == soplete[0]:
		sprite_index = soplete[1]
		soplete_num = 1.0
		if G.apariencia == 3.0:
			image_speed = 0.5
		else:
			image_speed = 0.2
		alarm[1] = 120.0
