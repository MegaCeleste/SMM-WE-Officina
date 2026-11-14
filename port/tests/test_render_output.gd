extends Node
## Real-renderer check for half-pixel detail through the application surface.


func _ready() -> void:
	GM.auto_tick = false
	GM.surface_resize(GM.application_surface, 768.0, 432.0)
	GM.display_set_gui_size(384.0, 216.0)
	for i: int in 4:
		GM._begin_world_draw()
		GM.draw_set_color(GM.c_white)
		GM.draw_rectangle(0.5, 0.0, 1.0, 1.0, false)
		GM._begin_gui_draw()
		GM.draw_surface_stretched(GM.application_surface, 0.0, 0.0, 384.0, 216.0)
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	var image: Image = get_viewport().get_texture().get_image()
	var left: Color = image.get_pixel(0, 0)
	var next: Color = image.get_pixel(1, 0)
	var passed: bool = image.get_size() == Vector2i(768, 432) and left.r < 0.1 and next.r > 0.9
	print("OUTPUT_DETAIL size=%s left=%s next=%s pass=%s" % [image.get_size(), left, next, passed])
	get_tree().quit(0 if passed else 1)
