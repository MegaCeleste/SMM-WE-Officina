extends "res://tests/test_player.gd"
## Compare fixed-tick game state with and without presentation interpolation.

var _test_style: int = 2


func _run_case(enabled: bool) -> Array:
	var player: GMObject = _start(_test_style)
	if player == null:
		return []
	var mover_type: int = GM.register_object("t_interpolation_mover_%s" % enabled, preload("res://tests/objs/t_interpolation_mover.gd"))
	var mover: GMObject = GM.instance_create(player.x + 32.0, player.y - 32.0, mover_type)
	mover.sprite_index = A.spr_coin
	mover.hspeed = 0.5
	if enabled:
		GM.prototype_interpolate_actor(player)
	GM.keyboard_key_press(int(G.derecha))
	for i: int in 60:
		GM.tick()
	GM.keyboard_key_release(int(G.derecha))
	var result: Array = [player.x, player.y, player.hspeed, player.vspeed, mover.x, mover.y, G.coins, GM.score, GM.tick_count, GM.camera_get_view_x(0), GM.camera_get_view_y(0)]
	if enabled:
		ok(GM.prototype_draw_count == 60, "player Draw occurs exactly once per tick")
		ok(not GM._prototype_default_offsets.is_empty(), "moving default sprite gets an interpolation item")
		ok(not GM._prototype_layer_offsets.is_empty(), "background layers use the presentation path")
		GM.prototype_interpolate_actor(null)
	return result


func _rigid_policy_for(obj: int) -> bool:
	var cls: GMClass = GM._class_of(obj)
	var instance: GMObject = cls.gd.new() as GMObject
	instance._cls = cls
	instance._isa = cls.is_a
	instance.object_index = obj
	var result: bool = GM._rigid_actor_draw(instance)
	instance.free()
	return result


func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	if not args.is_empty():
		_test_style = clampi(int(args[0]), 0, 3)
	var baseline: Array = _run_case(false)
	var interpolated: Array = _run_case(true)
	ok(not baseline.is_empty() and baseline == interpolated, "interpolation preserves game state and tick count")
	GM.auto_tick = true
	GM._step_once()
	GM.auto_tick = false
	ok(GM.prototype_actor == _find(A.obj_mario), "normal tick selects the active Mario for interpolation")
	var manager = GM.instance_find(A.obj_levelmanager, 0)
	manager.editor = 1.0
	GM._update_interpolation_target()
	ok(GM.prototype_actor == null, "editor mode disables gameplay interpolation")
	manager.editor = 0.0
	var player = _find(A.obj_mario)
	player.x = 100.3
	G.apariencia = 2.0
	GM.prototype_interpolate_actor(player)
	GM._phase_draw()
	ok(is_equal_approx(GM._prototype_actor_curr.x, 100.3) and is_equal_approx(GM._prototype_actor_subpixel.x, 0.3), "Mario uses continuous position despite rounded sprite drawing")
	if player.object_index != A.obj_marioU:
		G.apariencia = 0.0
		player.state = 3.0
		GM._phase_draw()
		ok(GM._prototype_actor_subpixel == Vector2.ZERO, "unrounded swimming drawing needs no subpixel correction")
	GM.prototype_interpolate_actor(null)
	ok(_rigid_policy_for(A.obj_galoomba) and _rigid_policy_for(A.obj_mushroom) and _rigid_policy_for(A.obj_coin), "audited custom enemy, item and coin draws interpolate")
	ok(not _rigid_policy_for(A.obj_angrysun) and not _rigid_policy_for(A.obj_chain_chomp_free) and not _rigid_policy_for(A.obj_shell_held), "screen-anchored, chained and held drawings are excluded")
	var unsafe_type: int = GM.register_object("t_interpolation_unsafe_draw", preload("res://tests/objs/t_interpolation_unsafe_draw.gd"), A.obj_enemyparent)
	ok(not _rigid_policy_for(unsafe_type), "unknown descendant Draw is excluded despite enemy ancestry")
	G.apariencia = 2.0
	var enemy: GMObject = GM.instance_create(123.3, player.y - 16.0, A.obj_galoomba)
	enemy.xprevious = enemy.x - 0.75
	enemy.yprevious = enemy.y
	GM.prototype_interpolate_actor(player)
	GM._phase_draw()
	var index: int = GM._prototype_default_offsets.find(Vector2(-0.75, 0.0))
	ok(index >= 0 and is_equal_approx(GM._prototype_default_subpixels[index].x, enemy.x - GM.gm_round(enemy.x)), "custom enemy draw uses continuous subpixel position")
	var old_room_size: Vector2 = Vector2(GM.room_width, GM.room_height)
	GM.room_width = 1000.0
	GM.room_height = 1000.0
	GM.camera_set_view_pos(0, 0.0, 0.0)
	GM.camera_set_view_size(0, 384.0, 216.0)
	GM.camera_set_view_border(0, 192.0, 108.0)
	GM.camera_set_view_speed(0, -1.0, -1.0)
	GM.camera_set_view_target(0, A.obj_levelmanager)
	var boundary: Vector2 = GM._camera_follow_position(0, -100.0, -100.0)
	ok(boundary == Vector2.ZERO and GM.camera_get_view_x(0) == 0.0, "display camera respects room bounds without changing logical camera")
	GM.camera_set_view_pos(0, 100.0, 40.0)
	GM.camera_set_view_speed(0, 2.0, 3.0)
	var limited: Vector2 = GM._camera_follow_position(0, 500.0, 300.0)
	ok(limited == Vector2(102.0, 43.0) and GM.camera_get_view_x(0) == 100.0, "display camera respects camera speed limits")
	GM.camera_set_view_pos(0, 0.0, 0.0)
	GM.camera_set_view_speed(0, -1.0, -1.0)
	GM._camera_follow(0, 250.123456789, 200.0)
	ok(absf(GM.camera_get_view_x(0) - 58.123456789) < 0.0000000001, "logical camera keeps double-precision coordinates")
	GM.camera_set_view_pos(0, 0.0, 0.0)
	manager.x = 250.0
	manager.y = 200.0
	manager._presentation_round_bias = Vector2(0.3, 0.0)
	manager._presentation_round_tick = GM.tick_count
	GM._update_view_follow()
	ok(is_equal_approx(GM.camera_get_view_x(0), 58.0) and is_equal_approx(GM._presentation_camera_follow.x, 58.3), "camera rounds only logical state and keeps subpixel display position")
	GM._presentation_camera_history.clear()
	GM.interpolation_camera_smoothing = true
	GM._smooth_presentation_camera(Vector2(0.0, 0.0))
	GM._smooth_presentation_camera(Vector2(1.0, 0.0))
	var before_smooth: Vector2 = GM._smooth_presentation_camera(Vector2(3.0, 0.0))
	var after_smooth: Vector2 = GM._smooth_presentation_camera(Vector2(4.0, 0.0))
	ok(is_equal_approx(after_smooth.x - before_smooth.x, 4.0 / 3.0) and is_equal_approx(GM.camera_get_view_x(0), 58.0), "camera display smoothing reduces alternating steps without changing logical camera")
	ok(GM._smooth_presentation_camera(Vector2(100.0, 0.0)) == Vector2(100.0, 0.0) and GM._presentation_camera_snap, "camera display smoothing snaps on teleport")
	GM.room_width = old_room_size.x
	GM.room_height = old_room_size.y
	GM.prototype_interpolate_actor(null)
	GM.prototype_interpolate_actor(player)
	GM._mark_dead(player)
	GM._sweep()
	GM._update_interpolation_target()
	ok(GM.prototype_actor == null, "destroyed player does not retain interpolation target")
	GM.prototype_interpolate_actor(enemy)
	GM._switch_room(A.rm_logo)
	ok(GM.prototype_actor == null and not GM._prototype_valid, "room switch clears presentation history")
	print("interpolation logic style %d: %d checks, %d failed" % [_test_style, _checks, _fails])
	GM._reset_for_test()
	get_tree().quit(1 if _fails else 0)
