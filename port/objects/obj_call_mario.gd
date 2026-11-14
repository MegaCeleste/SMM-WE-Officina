extends GMObject

var cal_x: float = 0.0
var cal_y: float = 0.0
var press: float = 0.0


# from objects/obj_call_mario/Create_0.gml
func _create() -> void:
	cal_x = 0.0
	cal_y = 0.0
	press = 0.0
	alarm[0] = 8.0
	alarm[1] = 15.0
	visible = false


# from objects/obj_call_mario/Alarm_0.gml
func _alarm_0() -> void:
	press = 1.0


# from objects/obj_call_mario/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()


# from objects/obj_call_mario/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_exists(A.obj_mario_editor) and (press == 1.0):
		GM.audio_stop_sound(A.snd_trayectoria)
		GM.audio_play_sound(A.snd_trayectoria, 0.0, false)
		cal_x = (GM.instance_find(A.obj_creation_preview, 0).x - GM.camera_get_view_x(GM.view_get_camera(0)))
		cal_y = ((GM.instance_find(A.obj_creation_preview, 0).y - 16.0) - GM.camera_get_view_y(GM.view_get_camera(0)))
		var _with_target2 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + cal_x), (GM.camera_get_view_y(GM.view_get_camera(0)) + cal_y), A.obj_silbido)
		var _other1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target2):
			inst.follow_x = self.cal_x
			inst.follow_y = self.cal_y
		GM.other = _other1
		var _with_target4 = A.obj_mario_editor
		var _other3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target4):
			inst.follow = 1.0
			inst.follow_x = self.cal_x
			inst.follow_y = self.cal_y
		GM.other = _other3
		instance_destroy()
