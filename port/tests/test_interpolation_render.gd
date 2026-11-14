extends "res://tests/test_player.gd"
## Compare the recorded game image at a tick boundary with the prototype on/off.


func _capture() -> Image:
	for i: int in 3:
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	return get_viewport().get_texture().get_image()


func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	var style: int = clampi(int(args[0]), 0, 3) if not args.is_empty() else 2
	var player: GMObject = _start(style)
	if player == null:
		printerr("INTERPOLATION_IMAGE no player")
		get_tree().quit(1)
		return
	# Draw GUI advances the transition fade; remove it from this comparison.
	var persistent = GM.instance_find(A.obj_persistent, 0)
	persistent.done = 1.0
	var overlay_type: int = GM.register_object("t_interpolation_overlay", preload("res://tests/objs/t_interpolation_overlay.gd"))
	GM.instance_create_depth(player.x, player.y, player.depth - 1.0, overlay_type)
	GM._phase_draw()
	var baseline: Image = await _capture()
	GM.prototype_interpolate_actor(player)
	GM._phase_draw()
	# Compare the exact tick position, without an intermediate-frame translation.
	GM._prototype_valid = false
	var experiment: Image = await _capture()
	var different: int = 0
	var max_delta: float = 0.0
	var significant: int = 0
	for y: int in baseline.get_height():
		for x: int in baseline.get_width():
			var a: Color = baseline.get_pixel(x, y)
			var b: Color = experiment.get_pixel(x, y)
			if a != b:
				different += 1
			var delta: float = maxf(maxf(absf(a.r - b.r), absf(a.g - b.g)), maxf(absf(a.b - b.b), absf(a.a - b.a)))
			max_delta = maxf(max_delta, delta)
			if delta > 0.02:
				significant += 1
	var sx: int = int((player.x - GM.camera_get_view_x(0)) * 2.0)
	var sy: int = int((player.y - GM.camera_get_view_y(0) - 6.0) * 2.0)
	print("INTERPOLATION_IMAGE style=%d differing_pixels=%d significant=%d max_delta=%.3f player=%s,%s depth=%.1f overlap=%s/%s" % [style, different, significant, max_delta, sx, sy, player.depth, baseline.get_pixel(sx, sy), experiment.get_pixel(sx, sy)])
	GM.prototype_interpolate_actor(null)
	get_tree().quit(0 if different == 0 else 1)
