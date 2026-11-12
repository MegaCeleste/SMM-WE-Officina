extends GMObject

var alpha: float = 0.0


# from objects/obj_fadeout/Create_0.gml
func _create() -> void:
	alpha = 1.0


# from objects/obj_fadeout/Step_2.gml
func _step_end() -> void:
	alpha -= 0.04
	if alpha < 0.0:
		instance_destroy()


# from objects/obj_fadeout/Draw_0.gml
func _gm_draw() -> void:
	pass  # 原版 Draw 事件是空文件：有 Draw 事件但什么都不画（所以不会走默认的 draw_self）
