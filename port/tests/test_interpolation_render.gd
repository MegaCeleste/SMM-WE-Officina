extends "res://tests/test_player.gd"
## Compare the recorded game image at a tick boundary with the prototype on/off.


func _capture() -> Image:
	for i: int in 3:
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	return get_viewport().get_texture().get_image()


func _check_fixed_ui(player: GMObject) -> void:
	var manager: GMObject = GM.instance_find(A.obj_levelmanager, 0)
	var persistent: GMObject = GM.instance_find(A.obj_persistent, 0)
	var cursor: GMObject = GM.instance_create(0.0, 0.0, A.obj_cursor)
	var button: GMObject = GM.instance_create(0.0, 0.0, A.obj_creator_jugar_editar)
	button.sprite_index = A.spr_creator_create
	GM.mouse_override = Vector2(80.25, 90.5)
	for inst: GMObject in GM.instances:
		inst.visible = inst in [manager, persistent, cursor, button]
	for layer: int in GM._layers.keys():
		GM.layer_set_visible(layer, false)
	GM._phase_draw()
	ok(GM._prototype_default_camera_fixed.count(true) == 3, "HUD, playtest button and cursor use camera compensation")
	# Compare the same recorded Draw commands at two display-camera positions.
	GM._prototype_valid = true
	GM._prototype_camera_prev = GM._prototype_camera_draw
	GM._prototype_camera_curr = GM._prototype_camera_draw
	var baseline: Image = await _capture()
	var shifted: Vector2 = GM._prototype_camera_draw + Vector2(-2.75, 1.5)
	GM._prototype_camera_prev = shifted
	GM._prototype_camera_curr = shifted
	var moved: Image = await _capture()
	ok(GM._prototype_display_camera.is_equal_approx(shifted) and player == GM.prototype_actor, "the displayed camera moved during the UI comparison")
	ok(baseline.get_data() == moved.get_data(), "playtest UI stays pixel-identical as the display camera moves")
	print("interpolation UI: %d checks, %d failed" % [_checks, _fails])


func _capture_shadow_samples(sprite: int, enabled: bool) -> Image:
	GM._ordered_world = enabled
	GM._begin_world_draw()
	GM.draw_set_color(GM.c_white)
	GM.draw_rectangle(0.0, 0.0, GM.VIEW_W, GM.VIEW_H, false)
	if enabled:
		GM._begin_sprite_shadow_pass()
	GM._draw_sprite_shadows = enabled
	GM.draw_sprite(sprite, 0.0, 40.0, 40.0)
	GM.draw_sprite_ext(sprite, 0.0, 100.0, 40.0, -1.0, 1.0, 90.0, GM.c_white, 1.0)
	GM.draw_sprite_part_ext(sprite, 0.0, 2.0, 2.0, 3.0, 2.0, 160.0, 40.0, 2.0, 1.0, GM.c_white, 0.5)
	GM.draw_sprite_stretched(sprite, 0.0, 210.0, 40.0, 16.0, 16.0)
	# Draw the right tile first and the left tile last, as can happen when placing terrain.
	GM.draw_sprite_part(sprite, 0.0, 2.0, 2.0, 4.0, 3.0, 268.0, 40.0)
	GM.draw_sprite_part(sprite, 0.0, 2.0, 2.0, 4.0, 3.0, 264.0, 40.0)
	GM._draw_sprite_shadows = false
	await RenderingServer.frame_post_draw
	return GM._app_vp.get_texture().get_image()


func _sample_view(image: Image, position: Vector2) -> Color:
	var pixel: Vector2i = Vector2i(position * Vector2(image.get_size()) / Vector2(GM.VIEW_W, GM.VIEW_H))
	return image.get_pixelv(pixel)


func _check_sprite_shadows() -> void:
	var start_checks: int = _checks
	var start_fails: int = _fails
	ok(GM._gameplay_sprite_shadows_enabled(), "local gameplay enables sprite shadows")
	G.shadows = 0.0
	ok(not GM._gameplay_sprite_shadows_enabled(), "the setting disables gameplay sprite shadows")
	G.shadows = 1.0
	ok(GM.classes[A.obj_mario].casts_sprite_shadow and GM.classes[A.obj_ground].casts_sprite_shadow, "Mario and terrain cast shadows")
	ok(not GM.classes[A.obj_levelmanager].casts_sprite_shadow and not GM.classes[A.obj_menu_pausa].casts_sprite_shadow, "HUD and pause menu are excluded")
	GM.camera_set_view_pos(0, 0.0, 0.0)
	GM.camera_set_view_size(0, GM.VIEW_W, GM.VIEW_H)
	var texture: Image = Image.create_empty(8, 8, false, Image.FORMAT_RGBA8)
	texture.fill_rect(Rect2i(2, 2, 4, 3), Color.RED)
	var sprite: int = GM._add_dynamic_sprite(texture, 0.0, 0.0)
	var off: Image = await _capture_shadow_samples(sprite, false)
	var on: Image = await _capture_shadow_samples(sprite, true)
	for sample: Vector2 in [Vector2(46.5, 45.5), Vector2(106.5, 47.5), Vector2(223.5, 51.5)]:
		ok(_sample_view(off, sample) == Color.WHITE and absf(_sample_view(on, sample).r - 0.70) < 0.02, "opaque sprite casts a 30%% shadow at %s" % sample)
	var crop_shadow: Vector2 = Vector2(167.5, 43.5)
	ok(_sample_view(off, crop_shadow) == Color.WHITE and absf(_sample_view(on, crop_shadow).r - 0.85) < 0.02, "cropped sprite shadow respects sprite opacity")
	ok(_sample_view(on, Vector2(43.5, 43.5)) == Color.RED and _sample_view(on, Vector2(41.5, 41.5)) == Color.WHITE, "sprite keeps its colors and transparent outline")
	ok(_sample_view(on, Vector2(268.5, 42.5)) == Color.RED, "a later tile's shadow cannot darken the adjacent tile")
	ok(absf(_sample_view(on, Vector2(273.5, 43.5)).r - 0.70) < 0.02, "joined tiles still cast a visible shadow along the external edge")
	GM.sprite_delete(sprite)
	print("sprite shadows: %d checks, %d failed" % [_checks - start_checks, _fails - start_fails])


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
	await _check_fixed_ui(player)
	GM.prototype_interpolate_actor(null)
	await _check_sprite_shadows()
	get_tree().quit(0 if different == 0 and _fails == 0 else 1)
