extends "res://tests/play_enemies.gd"
## Opt-in real game experiment. Uses Mario's actual custom Draw once per tick.

var _player: GMObject = null
var _start_tick: int = 0
var _start_x: float = 0.0
var _start_camera: float = 0.0
var _frames: int = 0
var _intermediate: int = 0
var _last_anchor: Vector2 = Vector2.ZERO
var _last_camera: Vector2 = Vector2.ZERO
var _samples: int = 0
var _discontinuities: int = 0


func _ready() -> void:
	GM.interpolation_auto = false
	GM.interpolation_profile = true
	super._ready()
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	Engine.max_fps = 240


func _place() -> void:
	# Keep the route clear so the same continuous movement is reproducible.
	pass


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not _placed:
		return
	if _player == null:
		_player = GM.instance_find(A.obj_mario, 0)
		if _player == null:
			return
		# The game's startup alarm can re-enable VSync after _ready.
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		GM.prototype_interpolate_actor(_player)
		_start_tick = GM.tick_count
		_start_x = _player.x
		_start_camera = GM.camera_get_view_x(0)
		GM.keyboard_key_press(int(G.derecha))
	else:
		if _samples > 0 and (GM._prototype_actor_prev != _last_anchor or GM._prototype_camera_prev != _last_camera):
			_discontinuities += 1
		_last_anchor = GM._prototype_actor_curr
		_last_camera = GM._prototype_camera_curr
		_samples += 1
	if GM.tick_count - _start_tick >= 240:
		GM.keyboard_key_release(int(G.derecha))
		var dx: float = _player.x - _start_x
		var camera_dx: float = GM.camera_get_view_x(0) - _start_camera
		var passed: bool = dx > 100.0 and camera_dx > 50.0 and GM.prototype_draw_count == 240 and _intermediate > 0 and _discontinuities == 0
		GM.prototype_tick_ms.sort()
		GM.prototype_draw_ms.sort()
		var tick_p95: float = GM.prototype_tick_ms[int(GM.prototype_tick_ms.size() * 0.95)]
		var draw_p95: float = GM.prototype_draw_ms[int(GM.prototype_draw_ms.size() * 0.95)]
		print("GAME_INTERPOLATION style=%d ticks=%d draw=%d frames=%d intermediate=%d discontinuities=%d actor_dx=%.2f camera_dx=%.2f tick_p95_ms=%.3f draw_p95_ms=%.3f pass=%s" % [_style, GM.tick_count - _start_tick, GM.prototype_draw_count, _frames, _intermediate, _discontinuities, dx, camera_dx, tick_p95, draw_p95, passed])
		GM.prototype_interpolate_actor(null)
		get_tree().quit(0 if passed else 1)


func _process(_delta: float) -> void:
	if _player == null:
		return
	_frames += 1
	var fraction: float = Engine.get_physics_interpolation_fraction()
	if fraction > 0.05 and fraction < 0.95:
		_intermediate += 1
