extends Node
## Headless checks for native rendering size, letterboxing and pointer mapping.


func _ready() -> void:
	GM.auto_tick = false
	GM.surface_resize(GM.application_surface, 768.0, 432.0)
	var original: Vector2i = get_tree().root.size
	var failed: int = 0
	for entry: Array in [
		[Vector2i(1920, 1080), Rect2(0, 0, 1920, 1080)],
		[Vector2i(1280, 1024), Rect2(0, 152, 1280, 720)],
		[Vector2i(1024, 600), Rect2(0, 12, 1024, 576)],
	]:
		get_tree().root.size = entry[0]
		GM._refresh_output_layout()
		var rect: Rect2 = entry[1]
		var pass_case: bool = GM._output_rect == rect and Vector2(GM._app_vp.size) == rect.size
		pass_case = pass_case and GM._output_to_view(rect.position).is_equal_approx(Vector2.ZERO)
		pass_case = pass_case and GM._output_to_view(rect.end).is_equal_approx(Vector2(GM.VIEW_W, GM.VIEW_H))
		pass_case = pass_case and GM.surface_get_width(GM.application_surface) == 768.0 and GM.surface_get_height(GM.application_surface) == 432.0
		if not pass_case:
			failed += 1
			printerr("FAIL output layout window=%s expected=%s actual=%s world=%s" % [entry[0], rect, GM._output_rect, GM._app_vp.size])
	var mobile_size: Vector2 = Vector2(2400, 1080)
	GM._output_rect = GM._get_output_rect(mobile_size, true)
	if GM._output_rect != Rect2(Vector2.ZERO, mobile_size) or not GM._output_to_view(mobile_size / 2.0).is_equal_approx(Vector2(GM.VIEW_W, GM.VIEW_H) / 2.0):
		failed += 1
		printerr("FAIL Android wide screen output or touch mapping")
	get_tree().root.size = original
	GM._refresh_output_layout()
	print("output layout: 4 sizes, %d failed" % failed)
	get_tree().quit(1 if failed else 0)
