extends GMObject

var place: float = 0.0
var xx = null
var yy = null


# from objects/obj_creation_preview/Create_0.gml
func _create() -> void:
	place = 0.0
	image_speed = 0.0
	image_index = 0.0
	xx = x
	yy = y


# from objects/obj_creation_preview/Step_1.gml
func _step_begin() -> void:
	if GM.instance_exists(A.obj_cursor) and GM.instance_find(A.obj_cursor, 0).move == 1.0:
		x = (GM.mouse_x + xx)
		y = (GM.mouse_y + yy)
	else:
		x = (floorf((GM.mouse_x / 16.0)) * 16.0)
		y = (floorf((GM.mouse_y / 16.0)) * 16.0)
	move_snap(16.0, 16.0)
	if G.select_resource != A.obj_resource_empty:
		sprite_index = Scr.scr_resources_get_sprite(self, G.select_resource)
	else:
		sprite_index = A.spr_cursor_square
	visible = false
	if place_meeting(x, y, A.obj_parent_resource) and (not place_meeting(x, y, A.obj_parent_sounds)) and GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 0.0:
		place = 1.0
	else:
		place = 0.0


# from objects/obj_creation_preview/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, 0.0, (GM.mouse_x + xx), (GM.mouse_y + yy))
