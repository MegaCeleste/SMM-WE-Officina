# from objects/obj_autoscroll（第 7 批移植，已核对）
extends GMObject

var follow_y: float = 0.0  ## obj_load_guardabot 也写它（原版本 object 里没人读）
var candie: float = 0.0
var velocidad: float = 0.0  ## obj_load_guardabot 写入；门、水管、obj_levelmanager 等读它
var wallleft: float = 0.0  # PORT: 原版只在 Step 里赋值（0/1），没有 variable_instance_exists 查询，按数值声明
var wallright: float = 0.0  # PORT: 同 wallleft


# from objects/obj_autoscroll/Create_0.gml
func _create() -> void:
	follow_y = 0.0
	candie = 1.0
	velocidad = 0.6
	alarm[0] = 6.0


# from objects/obj_autoscroll/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario) and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).barrier == 0.0:
		if collision_rectangle((GM.instance_find(A.obj_mario, 0).bbox_left - 1.0), (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_solid, true, false) != null or collision_rectangle((GM.instance_find(A.obj_mario, 0).bbox_left - 1.0), (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null or collision_rectangle((GM.instance_find(A.obj_mario, 0).bbox_left - 1.0), (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null or collision_rectangle((GM.instance_find(A.obj_mario, 0).bbox_left - 1.0), (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_onewaygate_right, true, false) != null:
			wallleft = 1.0
		else:
			wallleft = 0.0
		if collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_right, (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), (GM.instance_find(A.obj_mario, 0).bbox_right + 1.0), (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_solid, true, false) != null or collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_right, (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), (GM.instance_find(A.obj_mario, 0).bbox_right + 1.0), (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null or collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_right, (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), (GM.instance_find(A.obj_mario, 0).bbox_right + 1.0), (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null or collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_right, (GM.instance_find(A.obj_mario, 0).bbox_top + 4.0), (GM.instance_find(A.obj_mario, 0).bbox_right + 1.0), (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), A.obj_onewaygate_left, true, false) != null:
			wallright = 1.0
		else:
			wallright = 0.0
		if GM.instance_find(A.obj_mario, 0).x <= (GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0):
			if wallright > 0.5 and candie == 1.0:  # GML: wallright && candie == 1
				GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_deadmario)
				for inst in GM.with_list(A.obj_mario):
					inst.instance_destroy()
				return
			else:
				for inst in GM.with_list(A.obj_mario):  # GML: obj_mario.x = (camera_get_view_x(view_get_camera(0)) + 8)
					inst.x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0)
				if GM.instance_find(A.obj_mario, 0).hspeed < 0.0:
					for inst in GM.with_list(A.obj_mario):  # GML: obj_mario.hspeed = 0
						inst.hspeed = 0.0
		if GM.instance_find(A.obj_mario, 0).x >= ((GM.camera_get_view_x(GM.view_get_camera(0))) + GM.camera_get_view_width(GM.view_get_camera(0)) - 8.0):
			if wallleft > 0.5 and candie == 1.0:  # GML: wallleft && candie == 1
				GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_deadmario)
				for inst in GM.with_list(A.obj_mario):
					inst.instance_destroy()
				return
			else:
				for inst in GM.with_list(A.obj_mario):  # GML: obj_mario.x = ((camera_get_view_x(view_get_camera(0))) + camera_get_view_width(view_get_camera(0)) - 8)
					inst.x = ((GM.camera_get_view_x(GM.view_get_camera(0))) + GM.camera_get_view_width(GM.view_get_camera(0)) - 8.0)
				if GM.instance_find(A.obj_mario, 0).hspeed > 0.0:
					for inst in GM.with_list(A.obj_mario):  # GML: obj_mario.hspeed = 0
						inst.hspeed = 0.0
		if GM.instance_find(A.obj_mario, 0).y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 248.0) and candie == 1.0:
			GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_deadmario)
			for inst in GM.with_list(A.obj_mario):
				inst.instance_destroy()
			return
	elif GM.instance_exists(A.obj_deadmario):
		speed = 0.0


# from objects/obj_autoscroll/Alarm_0.gml
func _alarm_0() -> void:
	hspeed = velocidad
