extends GMObject

var press: float = 0.0


# from objects/obj_bt_gb_close/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	press = 0.0
	alarm[0] = 15.0


# from objects/obj_bt_gb_close/Alarm_0.gml
func _alarm_0() -> void:
	press = 1.0


# from objects/obj_bt_gb_close/Mouse_4.gml
func _mouse_4() -> void:
	if press == 1.0 and GM.instance_find(A.obj_guardabot, 0).get("active") == 1.0:
		GM.audio_play_sound(A.snd_item_deselect, 0.0, false)
		G.condiciones = 0.0
		G.condiciones_type = 0.0
		G.condiciones_object = 0.0
		G.condiciones_count = 0.0
		for inst in GM.with_list(A.obj_gb_level):
			inst.instance_destroy()
