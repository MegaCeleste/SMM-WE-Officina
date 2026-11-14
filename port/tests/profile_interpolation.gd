extends "res://tests/play_enemies.gd"
## Wall-clock probe: real rendering and VSync, no fixed FPS or image readback.


func _place() -> void:
	pass


func _ready() -> void:
	super._ready()
	while not _placed:
		await get_tree().physics_frame
	var player: GMObject = GM.instance_find(A.obj_mario, 0)
	if player == null:
		get_tree().quit(1)
		return
	GM.interpolation_auto = true
	GM.interpolation_profile = true
	var unlocked: bool = "--unlocked" in OS.get_cmdline_user_args()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(1536, 864))
	await get_tree().process_frame
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED if unlocked else DisplayServer.VSYNC_ENABLED)
	Engine.max_fps = 120 if unlocked else 0
	GM._update_interpolation_target()
	GM.prototype_tick_ms.clear()
	GM.prototype_draw_ms.clear()
	GM.prototype_present_ms.clear()
	GM.keyboard_key_press(int(G.derecha))
	await get_tree().create_timer(1.0).timeout
	var times: Array[float] = []
	var physical: Dictionary = {}
	var shown: Dictionary = {}
	var fractions: Dictionary = {}
	var samples: Array[String] = []
	var slow: Array[String] = []
	var start_tick: int = GM.tick_count
	var previous: int = Time.get_ticks_usec()
	var until: int = previous + 3_000_000
	while Time.get_ticks_usec() < until:
		await RenderingServer.frame_post_draw
		var now: int = Time.get_ticks_usec()
		var frame_ms: float = float(now - previous) / 1000.0
		times.append(frame_ms)
		previous = now
		if frame_ms > 25.0:
			slow.append("%.2fms x=%.1f cam=%.1f tick=%.2fms draw=%.2fms" % [frame_ms, player.x, GM.camera_get_view_x(0), GM.prototype_tick_ms.back() if not GM.prototype_tick_ms.is_empty() else 0.0, GM.prototype_draw_ms.back() if not GM.prototype_draw_ms.is_empty() else 0.0])
		physical[snappedf(player.x, 0.001)] = true
		shown[snappedf(GM._prototype_display_actor.x, 0.001)] = true
		fractions[snappedf(Engine.get_physics_interpolation_fraction(), 0.05)] = true
		if samples.size() < 48 and GM.camera_get_view_x(0) > 0.0:
			samples.append("%.3f,%.3f,%.3f,%.3f,%.3f,%s,%.2f" % [float(now - (until - 3_000_000)) / 1000.0, player.x, GM._prototype_display_actor.x, GM.camera_get_view_x(0), GM._prototype_display_camera.x, GM.sprites[player.sprite_index].name, player.image_index])
	GM.keyboard_key_release(int(G.derecha))
	times.sort()
	var total: float = 0.0
	for ms: float in times:
		total += ms
	var screen: int = DisplayServer.window_get_current_screen()
	print("INTERPOLATION_PACING screen=%d display_hz=%.1f vsync=%d window_mode=%d window=%s viewport=%s world=%s renderer=%s frames=%d ticks=%d mean_ms=%.3f p95_ms=%.3f p99_ms=%.3f physical_positions=%d shown_positions=%d fractions=%d" % [screen, DisplayServer.screen_get_refresh_rate(screen), DisplayServer.window_get_vsync_mode(), DisplayServer.window_get_mode(), DisplayServer.window_get_size(), get_viewport().get_visible_rect().size, GM._app_vp.size, RenderingServer.get_video_adapter_name(), times.size(), GM.tick_count - start_tick, total / times.size(), times[int((times.size() - 1) * 0.95)], times[int((times.size() - 1) * 0.99)], physical.size(), shown.size(), fractions.size()])
	print("POSITION_TRACE ms,player,shown,logical_camera,shown_camera,sprite,image_index\n" + "\n".join(samples))
	GM.prototype_tick_ms.sort()
	GM.prototype_draw_ms.sort()
	GM.prototype_present_ms.sort()
	print("INTERPOLATION_COST tick_p99=%.3f draw_p99=%.3f present_p99=%.3f slow_frames=%d\n%s" % [GM.prototype_tick_ms[int((GM.prototype_tick_ms.size() - 1) * 0.99)], GM.prototype_draw_ms[int((GM.prototype_draw_ms.size() - 1) * 0.99)], GM.prototype_present_ms[int((GM.prototype_present_ms.size() - 1) * 0.99)], slow.size(), "\n".join(slow)])
	GM.prototype_interpolate_actor(null)
	get_tree().quit()
