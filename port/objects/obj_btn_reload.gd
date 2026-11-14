extends GMObject

var can_press: float = 0.0

# from objects/obj_btn_reload/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	can_press = 1.0

# from objects/obj_btn_reload/Alarm_0.gml
func _alarm_0() -> void:
	can_press = 1.0

# from objects/obj_btn_reload/Mouse_4.gml
func _mouse_4() -> void:
	var guardabot = GM.instance_find(A.obj_guardabot, 0)
	if not GM.instance_exists(A.obj_settings_panel) and not GM.instance_exists(A.obj_edit_menu) and G.cursor == 0.0 and can_press == 1.0 and G.press_load == 0.0 and not GM.instance_exists(A.obj_gb_level) and guardabot.active == 1.0:
		GM.room_restart()
