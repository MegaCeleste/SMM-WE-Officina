# from objects/obj_veggiecoin（第 5 批移植，已核对）
extends GMObject

var sprite_wings: float = 0.0


# from objects/obj_veggiecoin/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB_coin_dark
				"ghost":
					sprite_index = A.spr_SMB_coin_night
				"underground":
					sprite_index = A.spr_SMB_coin_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_coin_night
					else:
						sprite_index = A.spr_SMB_coin
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB3_coin_dark
				"ghost":
					sprite_index = A.spr_SMB3_coin_night
				"underground":
					sprite_index = A.spr_SMB3_coin_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_coin_night
					else:
						sprite_index = A.spr_SMB3_coin
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_index = A.spr_coin
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_coin
			sprite_wings = A.spr_wings_items
	G.coins += 1.0
	image_speed = 0.3
	vspeed = -4.0
	gravity = 0.2
	GM.audio_stop_sound(Scr.scr_snd_coin(self))
	GM.audio_play_sound(Scr.scr_snd_coin(self), 0.0, false)


# from objects/obj_veggiecoin/Step_0.gml
func _step() -> void:
	if y > (ystart - 20.0) and vspeed > 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(x, (ystart - 20.0), A.obj_score)):
			inst.event_user(0)
			inst.visible = false
		GM.other = _o
		if G.apariencia != 0.0:
			GM.instance_create(x, (ystart - 20.0), A.obj_sparkles_coin)
		instance_destroy()
