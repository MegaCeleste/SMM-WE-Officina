extends "res://objects/obj_parent_sound_o.gd"

var can_active2: float = 0.0


# from objects/obj_n64_or/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	can_active = 1.0
	can_active2 = 1.0
	my_object = A.obj_lighting
	visible = false


# from objects/obj_n64_or/Step_2.gml
func _step_end() -> void:
	return


# from objects/obj_n64_or/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if G.ef_repeat == 0.0 and G.n64_music == 0.0 and (not GM.audio_is_playing(A.snd_n64)) and (GM.veq(my_object, A.obj_lighting) or (not GM.veq(my_object, A.obj_lighting) and (not GM.instance_exists(my_object)))) and GM.instance_number(A.obj_efecto_musica) < 1:
		_user_0()


# from objects/obj_n64_or/Collision_obj_player_goal_smb1.gml
func _collision_obj_player_goal_smb1(other: GMObject) -> void:
	# / @description Inserisci qui la descrizione
	# Puoi scrivere il tuo codice in questo editor
	pass


# from objects/obj_n64_or/Collision_obj_player_goal_smb3.gml
func _collision_obj_player_goal_smb3(other: GMObject) -> void:
	# / @description Inserisci qui la descrizione
	# Puoi scrivere il tuo codice in questo editor
	pass


# from objects/obj_n64_or/Collision_obj_player_goal_smw.gml
func _collision_obj_player_goal_smw(other: GMObject) -> void:
	# / @description Inserisci qui la descrizione
	# Puoi scrivere il tuo codice in questo editor
	pass


# from objects/obj_n64_or/Other_10.gml
func _user_0() -> void:
	my_object = GM.instance_create(x, y, A.obj_efecto_musica)
	my_object.sprite_index = A.spr_N64
	can_active = 1.0
	G.n64_music = 1.0
	G.ef_repeat = 1.0
