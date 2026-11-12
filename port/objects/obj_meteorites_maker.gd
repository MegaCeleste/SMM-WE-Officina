extends GMObject


# from objects/obj_meteorites_maker/Create_0.gml
func _create() -> void:
	alarm[0] = 80.0  # random(90)+300//random(60)+100


# from objects/obj_meteorites_maker/Destroy_0.gml
func _destroy() -> void:
	GM.audio_stop_sound(A.snd_NSMBU_erupcion)
	GM.audio_stop_sound(A.snd_NSMBU_volcanic_rocks)


# from objects/obj_meteorites_maker/Alarm_0.gml
func _alarm_0() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_erupcion, 0.0, false)
	Scr.init_shake(self, 2.0)
	alarm[1] = 100.0


# from objects/obj_meteorites_maker/Alarm_1.gml
func _alarm_1() -> void:
	# / @description Generate rain
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[2] = 30.0


# from objects/obj_meteorites_maker/Alarm_2.gml
func _alarm_2() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[3] = 38.0


# from objects/obj_meteorites_maker/Alarm_3.gml
func _alarm_3() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 108.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[4] = 45.0


# from objects/obj_meteorites_maker/Alarm_4.gml
func _alarm_4() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[5] = 49.0


# from objects/obj_meteorites_maker/Alarm_5.gml
func _alarm_5() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites_big)  # 960)
	alarm[6] = 54.0


# from objects/obj_meteorites_maker/Alarm_6.gml
func _alarm_6() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[7] = 58.0


# from objects/obj_meteorites_maker/Alarm_7.gml
func _alarm_7() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[8] = 62.0


# from objects/obj_meteorites_maker/Alarm_8.gml
func _alarm_8() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 108.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[9] = 66.0


# from objects/obj_meteorites_maker/Alarm_9.gml
func _alarm_9() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites)  # 960)
	alarm[10] = 70.0


# from objects/obj_meteorites_maker/Alarm_10.gml
func _alarm_10() -> void:
	if G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_volcanic_rocks, 0.0, false)
	GM.instance_create(Scr.__view_get(self, Scr.e__VW.XView, 0.0) + GM.random(Scr.__view_get(self, Scr.e__VW.WView, 0.0) + 54.0), Scr.__view_get(self, Scr.e__VW.YView, 0.0) - 16.0, A.obj_meteorites_big)  # 960)
	alarm[0] = 500.0


# from objects/obj_meteorites_maker/Other_5.gml
func _room_end() -> void:
	# / @description Insert description here
	# You can write your code in this editor
	pass
