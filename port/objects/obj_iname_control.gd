extends GMObject

var size_x: float = 0.0
var size_y: float = 0.0
var index: float = 0.0
var texto = null
var c_color: float = 0.0
var back: int = -1

# from objects/obj_iname_control/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	size_x = 10.0
	size_y = 12.0
	index = 0.0
	texto = Scr.scr_language(self, 17.0)
	c_color = GM.make_color_rgb(16.0, 175.0, 244.0)
	var p = GM.instance_find(A.obj_persistent, 0)
	var sx: float = p.s
	back = int(Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, G.gw * sx, G.gh * sx, false, false))
	GM.instance_deactivate_all(true, self)
	GM.instance_activate_object(A.obj_persistent)
	GM.instance_activate_object(A.obj_cursor)
	GM.instance_create(x + 14.0, y + 94.0, A.obj_iname)
	GM.instance_create(x + 122.0, y + 94.0, A.obj_bl2)
	GM.instance_create(x + 138.0, y + 6.0, A.obj_iname_close)

# from objects/obj_iname_control/Destroy_0.gml
func _destroy() -> void:
	# obj_bl is referenced by the source but is absent from the project resources.
	for obj: int in [A.obj_iname, A.obj_bl2, A.obj_iname_close, A.obj_lun, A.obj_lp, A.obj_create_account]:
		for inst in GM.with_list(obj):
			inst.instance_destroy()
	GM.instance_activate_all()
	if GM.sprite_exists(back):
		GM.sprite_delete(back)

# from objects/obj_iname_control/Draw_0.gml
func _gm_draw() -> void:
	var vx: float = GM.camera_get_view_x(GM.view_get_camera(0))
	var vy: float = GM.camera_get_view_y(GM.view_get_camera(0))
	if GM.sprite_exists(back):
		GM.gpu_set_blendenable(0.0)
		GM.draw_sprite_ext(back, 0.0, vx, vy, 0.5, 0.5, 0.0, GM.c_white, 1.0)
		GM.gpu_set_blendenable(1.0)
	GM.draw_sprite_ext(A.spr_expand_bg, 1.0, vx, vy, GM.camera_get_view_width(GM.view_get_camera(0)) / 16.0, GM.camera_get_view_height(GM.view_get_camera(0)) / 16.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, 0.0, vx, vy, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text(x + 80.0, y + 22.0, GM.string_hash_to_newline(texto))
	if GM.instance_exists(A.obj_create_account):
		var account = GM.instance_find(A.obj_create_account, 0)
		GM.draw_text_ext_transformed_colour(x + 80.0, y + 142.5, account.textos, 32.0, 128.0, 1.0, 1.0, image_angle, c_color, c_color, c_color, c_color, account.yes)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_left)
