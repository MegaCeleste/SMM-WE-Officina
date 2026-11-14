extends GMObject

var effect_hover: float = 0.0
var press: float = 0.0
var mensaje = null
var codigo = null

# from objects/obj_bl2/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	effect_hover = 0.0
	press = 0.0

# from objects/obj_bl2/Mouse_10.gml
func _mouse_10() -> void:
	if image_index == 0.0:
		image_alpha = 0.9

# from objects/obj_bl2/Mouse_11.gml
func _mouse_11() -> void:
	image_alpha = 1.0

# from objects/obj_bl2/Mouse_4.gml
func _mouse_4() -> void:
	var name_input = GM.instance_find(A.obj_iname, 0)
	if name_input != null and name_input.new_texto != "" and name_input.new_texto != " " and not GM.instance_exists(A.obj_toast) and press == 0.0:
		GM.audio_play_sound(A.snd_aceptar, 0.0, false)
		image_index = 1.0
		G.my1 = name_input.new_texto
		press = 1.0
		mensaje = ""
		codigo = ""
		var previous_other: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(7)
		GM.other = previous_other
		GM.room_goto(A.rm_title)
	else:
		GM.audio_play_sound(A.snd_wrong, 0.0, false)
