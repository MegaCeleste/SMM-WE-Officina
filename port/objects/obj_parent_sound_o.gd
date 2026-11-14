extends GMObject

var sprite: float = 0.0
var sonido: float = 0.0
var sonido2: float = 0.0
var sonido3: float = 0.0
var sonido4: float = 0.0
var object = null
var velocidad: float = 0.0
var can_active: float = 0.0
var my_object = null


# from objects/obj_parent_sound_o/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	sprite = A.spr_es_risas
	sonido = A.snd_es_risas
	sonido2 = A.snd_es_risas2
	sonido3 = A.snd_es_risas3
	sonido4 = A.snd_es_risas4
	object = A.obj_efecto_sonido
	velocidad = 0.45
	can_active = 0.0
	my_object = A.obj_lighting


# from objects/obj_parent_sound_o/Step_2.gml
func _step_end() -> void:
	if not place_meeting(x, y, A.obj_mario):
		can_active = 0.0


# from objects/obj_parent_sound_o/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if can_active == 0.0 and (GM.veq(my_object, A.obj_lighting) or (not GM.veq(my_object, A.obj_lighting) and (not GM.instance_exists(my_object)))):
		_user_0()


# from objects/obj_parent_sound_o/Collision_obj_player_goal_smb1.gml
func _collision_obj_player_goal_smb1(other: GMObject) -> void:
	if can_active == 0.0 and (GM.veq(my_object, A.obj_lighting) or (not GM.veq(my_object, A.obj_lighting) and (not GM.instance_exists(my_object)))):
		_user_0()


# from objects/obj_parent_sound_o/Collision_obj_player_goal_smb3.gml
func _collision_obj_player_goal_smb3(other: GMObject) -> void:
	if can_active == 0.0 and (GM.veq(my_object, A.obj_lighting) or (not GM.veq(my_object, A.obj_lighting) and (not GM.instance_exists(my_object)))):
		_user_0()


# from objects/obj_parent_sound_o/Collision_obj_player_goal_smw.gml
func _collision_obj_player_goal_smw(other: GMObject) -> void:
	if can_active == 0.0 and (GM.veq(my_object, A.obj_lighting) or (not GM.veq(my_object, A.obj_lighting) and (not GM.instance_exists(my_object)))):
		_user_0()


# from objects/obj_parent_sound_o/Other_10.gml
func _user_0() -> void:
	my_object = GM.instance_create(x, y, object)
	for inst in GM.with_list(my_object):
		inst.sprite_index = self.sprite
		inst.image_speed = self.velocidad
		inst.sonido = self.sonido
	can_active = 1.0
