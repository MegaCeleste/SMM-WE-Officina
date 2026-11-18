extends "res://tests/test_player.gd"

var checks: int = 0
var failures: int = 0


func check(condition: bool, description: String) -> void:
	checks += 1
	if not condition:
		failures += 1
		printerr("FAIL: ", description)


func _ready() -> void:
	GM.auto_tick = false
	GM.game_start(A.rm_logo)
	var persistent = GM.instance_find(A.obj_persistent, 0)
	persistent.done = 1.0
	GM.display_set_gui_size(G.gw * (persistent.filter + 1.0), G.gh * (persistent.filter + 1.0))

	var online: GMObject = GM.instance_create(123.0, 138.0, A.obj_btn_iniciar)
	var pending: int = GM._pending_room
	online.call(&"_mouse_4")
	check(GM._pending_room == pending and GM.room != A.rm_course_world, "online button stays in the offline flow")
	GM.instance_destroy(online)
	var course = GM.instance_create(0.0, 0.0, A.obj_button_home)
	for frame: float in [1.0, 2.0]:
		course.image_index = frame
		course.press = 1.0
		course._mouse_4()
		check(course.press == 1.0 and not GM.instance_exists(A.obj_iname_control2), "online course entry remains inert")
	GM.instance_destroy(course)

	var coin: GMObject = GM.instance_create(184.0, 100.0, A.obj_coin)
	var lighting = GM.instance_create(0.0, 0.0, A.obj_lighting)
	var lighting_surface: int = lighting.surf
	check(GM.surface_exists(lighting_surface) and GM.surface_get_width(lighting_surface) == 384.0, "lighting owns a view-sized surface")
	lighting._step()
	check(GM._surface_target == null and GM.gpu_get_blendmode() == GM.bm_normal, "lighting restores target and blend state")
	if not GM._headless():
		_begin_background()
		lighting._gm_draw()
		var lit: Image = await _capture(persistent)
		check(_sample(lit, 192, 108).r > 0.75, "coin reduces darkness by 80 percent")
		check(_sample(lit, 40, 108).r < 0.02, "area without light stays black")
	GM.instance_destroy(lighting)
	check(not GM.surface_exists(lighting_surface), "destroying lighting frees its surface")
	GM.instance_destroy(coin)

	var opening = GM.instance_create(0.0, 0.0, A.obj_curtainin)
	var opening_surface: int = opening.surf
	check(opening.alarm[0] == 15.0, "opening waits 15 ticks")
	opening._step()
	check(opening.x == 192.0 and opening.y == 108.0 and opening.scale == 0.0, "opening starts at the view centre")
	if not GM._headless():
		_begin_background()
		opening._gm_draw()
		var closed: Image = await _capture(persistent)
		check(_sample(closed, 192, 108).r < 0.02, "zero-radius curtain is fully closed")
	opening._alarm_0()
	for i: int in 10:
		opening._step()
	check(opening.scale == 60.0, "opening grows by six pixels per tick")
	if not GM._headless():
		_begin_background()
		opening._gm_draw()
		GM._apply_world_transform(Vector2(24.0, 0.0))
		var opened: Image = await _capture(persistent)
		check(_sample(opened, 192, 108).r > 0.98, "curtain aperture shows the original world colour")
		check(_sample(opened, 5, 108).r < 0.02 and _sample(opened, 380, 108).r < 0.02, "curtain covers both edges with a presentation camera offset")
	for i: int in 41:
		opening._step()
	check(not GM.instance_exists(A.obj_curtainin) and not GM.surface_exists(opening_surface), "opening destroys itself and releases its surface")

	var closing = GM.instance_create(192.4, 108.4, A.obj_curtainout)
	closing.target = float(A.rm_intro)
	var closing_surface: int = closing.surf
	var closing_snapshot: int = closing.back
	for i: int in 48:
		closing._step()
	check(closing.x == 192.0 and closing.y == 108.0 and closing.scale == 0.0, "closing rounds its origin and shrinks by 6.25 pixels per tick")
	check(not GM.instance_exists(A.obj_fadein), "fade-in waits for negative radius")
	closing._step()
	var fade = GM.instance_find(A.obj_fadein, 0)
	check(fade != null and fade.target == float(A.rm_intro), "closing hands its room target to fade-in")
	if fade != null:
		GM.sprite_delete(fade.back)
		GM.instance_destroy(fade)
	GM.instance_activate_all()
	GM.instance_destroy(closing)
	check(not GM.surface_exists(closing_surface) and not GM.sprite_exists(closing_snapshot), "closing releases its surface and snapshot")

	G.effect_star = 1.0
	var pow_block: GMObject = GM.instance_create(8.0, -34.0, A.obj_block_pow_active)
	check(persistent.shock_enabled == 1.0 and persistent.alarm[7] == 60.0, "POW activates the persistent shockwave")
	check(persistent.var_mouse_pos_x == 192.0 and persistent.var_mouse_pos_y == 108.0, "POW passes the source shader coordinates")
	if not GM._headless():
		persistent.var_time_var = 0.32
		_begin_background(true)
		var distorted: Image = await _capture(persistent)
		persistent._alarm_7()
		_begin_background(true)
		var plain: Image = await _capture(persistent)
		var changed: int = 0
		for y: int in 216:
			if _sample(distorted, 192, y) != _sample(plain, 192, y):
				changed += 1
		check(changed > 0, "shockwave refracts the application surface")
		check(_sample(plain, 5, 10) == _sample(distorted, 5, 10), "shockwave leaves pixels outside the ring intact")
		_begin_background(true)
		GM._begin_gui_draw()
		GM.shader_set(A.Shader3)
		GM.draw_surface_stretched(GM.application_surface, 0.0, 0.0, GM._gui_w, GM._gui_h)
		GM.shader_reset()
		var blurred: Image = await _frame_image()
		var grey: float = _sample(blurred, 192, 108).r
		check(grey > 0.1 and grey < 0.9, "Shader3 blends neighbouring source texels")
	persistent._alarm_7()
	check(persistent.shock_enabled == 0.0 and persistent.var_time_var == 0.0, "alarm clears shockwave state and time")
	GM.instance_destroy(pow_block)
	await _test_night_level()

	print("batch11 effects: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)


func _test_night_level() -> void:
	var mario: GMObject = _start(0)
	check(mario != null, "sample level starts")
	if mario == null:
		return
	G.bg_level = "ghost"
	G.modo_noche = 1.0
	GM.instance_find(A.obj_persistent, 0).set("done", 1.0)
	for i: int in 2:
		GM.tick()
	var lighting = GM.instance_find(A.obj_lighting, 0)
	check(lighting != null, "night ghost level creates lighting through End Step")
	if lighting == null:
		return
	var surf: int = lighting.surf
	if not GM._headless():
		var image: Image = await _frame_image()
		var args: PackedStringArray = OS.get_cmdline_user_args()
		if not args.is_empty():
			check(image.save_png(args[0]) == OK, "night level screenshot saved")
	G.modo_noche = 0.0
	GM.tick()
	check(not GM.instance_exists(A.obj_lighting) and not GM.surface_exists(surf), "day mode removes the level lighting and frees its surface")
	G.modo_noche = 1.0
	GM.tick()
	lighting = GM.instance_find(A.obj_lighting, 0)
	if lighting != null:
		surf = lighting.surf
		GM.room_goto(A.rm_course_world)
		GM.tick()
		check(GM.room == A.rm_course_world and not GM.instance_exists(A.obj_mario), "reserved online room has no gameplay")
		check(not GM.surface_exists(surf), "room change frees lighting")
	else:
		check(false, "returning to night mode restores lighting")


func _begin_background(stripes: bool = false) -> void:
	GM._begin_world_draw()
	GM.draw_set_alpha(1.0)
	GM.draw_set_colour(GM.c_white)
	if stripes:
		for x: int in range(0, 384, 8):
			GM.draw_rectangle(float(x), 0.0, float(x + 3), 215.0, false)
	else:
		GM.draw_rectangle(-64.0, 0.0, 447.0, 215.0, false)


func _capture(persistent: GMObject) -> Image:
	GM._begin_gui_draw()
	persistent.call(&"_gm_draw_gui")
	return await _frame_image()


func _frame_image() -> Image:
	for i: int in 2:
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	return get_viewport().get_texture().get_image()


func _sample(image: Image, x: int, y: int) -> Color:
	var rect: Rect2 = GM._output_rect
	return image.get_pixel(int(rect.position.x + float(x) / 384.0 * rect.size.x), int(rect.position.y + float(y) / 216.0 * rect.size.y))
