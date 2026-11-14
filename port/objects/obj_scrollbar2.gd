extends GMObject

var button_y: float = 0.0
var scroll_amount: float = 0.0
var bar_height: float = 0.0
var active: float = 0.0


# from objects/obj_scrollbar2/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	button_y = 0.0
	scroll_amount = 6.0
	bar_height = 150.0
	active = 0.0


# from objects/obj_scrollbar2/Step_0.gml
func _step() -> void:
	G.scroll_perc = (button_y / bar_height)
	if GM.instance_number(A.obj_gb_button) > 6 and (not GM.instance_exists(A.obj_gb_level)):
		if active == 0.0:
			if GM.mouse_wheel_up():
				if GM.mouse_x < x:
					button_y -= scroll_amount
			elif GM.mouse_wheel_down():
				if GM.mouse_x < x:
					button_y += scroll_amount
		elif active == 1.0:
			button_y = (GM.mouse_y - y)
	button_y = clampf(button_y, 0.0, bar_height)


# from objects/obj_scrollbar2/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	GM.draw_sprite(A.spr_scrollbutton, 0.0, x, (y + button_y))


# from objects/obj_scrollbar2/Mouse_4.gml
func _mouse_4() -> void:
	if active == 0.0 and GM.instance_number(A.obj_gb_button) > 6 and (not GM.instance_exists(A.obj_gb_level)):
		active = 1.0


# from objects/obj_scrollbar2/Mouse_56.gml
func _mouse_56() -> void:
	if active == 1.0:
		active = 0.0
