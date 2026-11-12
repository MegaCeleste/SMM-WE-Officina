# from objects/obj_quicksand（第 7 批移植，已核对）
extends GMObject


# from objects/obj_quicksand/Create_0.gml
func _create() -> void:
	image_speed = 0.15


# from objects/obj_quicksand/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	other.stompstyle = 0.0
	if other.jumpnow != 1.0 and GM.keyboard_check_pressed(GM.vk_shift):
		GM.audio_play_sound(A.snd_jump, 0.0, false)
		other.vspeed = -3.85
		other.jumpnow = 1.0
		GM.keyboard_clear(GM.vk_shift)
	if other.vspeed > 0.5:
		other.vspeed = 0.5
