extends GMObject

var right: float = 0.0
var left: float = 0.0
var stagetwo: float = 0.0
var goal: float = 0.0  # PORT: 原版在 Create 里没赋值，由 scr_sidefade 在 instance_create 之后写入（room 编号）


# from objects/obj_sidefade/Create_0.gml
func _create() -> void:
	right = 0.0
	left = 0.0
	stagetwo = 0.0


# from objects/obj_sidefade/Draw_0.gml
func _gm_draw() -> void:
	var x1: float
	var x2: float
	var y1: float
	var y2: float
	GM.draw_set_color(GM.c_black)
	x1 = (GM.camera_get_view_x(GM.view_get_camera(0)) + left)
	x2 = (GM.camera_get_view_x(GM.view_get_camera(0)) + right)
	y1 = GM.camera_get_view_y(GM.view_get_camera(0))
	y2 = (GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0)))  # ORIG-BUG: y2 用的是 camera_get_view_x（应为 _y）
	right += 15.0
	left += (15.0 * stagetwo)
	GM.draw_rectangle(x1, y1, x2, y2, false)
	# ORIG-BUG: "+ 50" 写在 view_get_camera(0) 的括号外面，变成 camera_get_view_width(相机号 + 50)
	# UNSURE: GMS 里 camera_get_view_width(无效相机号) 的返回值不明；这里照字面写，GM._cam_w[50] 会越界。全工程没有任何地方调用 scr_sidefade，该 object 实际不会被创建
	if right > GM.camera_get_view_width(GM.view_get_camera(0) + 50) and stagetwo <= 0.5:  # GML: !stagetwo
		stagetwo = 1.0
		GM.room_goto(int(goal))
	if left > GM.camera_get_view_width(GM.view_get_camera(0) + 50):
		instance_destroy()
