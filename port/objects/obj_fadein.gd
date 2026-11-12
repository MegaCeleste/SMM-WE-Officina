extends GMObject

var target: float = 0.0  # PORT: 由 obj_curtainout（空壳）在 instance_create 之后写入
var back: float = -1.0
var alpha: float = 0.0


# from objects/obj_fadein/Create_0.gml
func _create() -> void:
	target = -4.0
	back = Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, GM.room_width, GM.room_height, 0.0, 0.0)
	GM.instance_deactivate_all(true, self)
	GM.instance_activate_object(A.obj_persistent)
	alpha = 0.0


# from objects/obj_fadein/Step_2.gml
func _step_end() -> void:
	alpha += 0.04
	if alpha > 1.0:
		alpha = 1.0
		if GM.sprite_exists(int(back)):
			GM.sprite_delete(back)
		GM.instance_activate_all()
		GM.room_goto(int(target))


# from objects/obj_fadein/Draw_0.gml
func _gm_draw() -> void:
	if GM.sprite_exists(int(back)):
		GM.gpu_set_blendenable(0.0)
		GM.draw_sprite(int(back), 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))
		GM.gpu_set_blendenable(1.0)
