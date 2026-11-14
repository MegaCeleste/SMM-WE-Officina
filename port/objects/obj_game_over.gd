extends GMObject

# from objects/obj_game_over/Create_0.gml
func _create() -> void:
	GM.audio_play_sound(A.snd_gameover, 0.0, false)
	# Android touch controls are outside the port's scope.
	image_speed = 0.4
	alarm[0] = 360.0

# from objects/obj_game_over/Alarm_0.gml
func _alarm_0() -> void:
	pass

# from objects/obj_game_over/Other_7.gml
func _animation_end() -> void:
	image_speed = 0.0
	image_index = 18.0
