extends Node2D
## Isolated experiment: recorded commands, two independently transformed items,
## and an interpolated camera. This does not change the game's draw path.

var _world: RID
var _background: RID
var _actor: RID
var _previous_actor: float = 0.0
var _actor_x: float = 0.0
var _previous_camera: float = 0.0
var _camera_x: float = 0.0
var _ticks: int = 0
var _frames: int = 0
var _intermediate: int = 0


func _ready() -> void:
	GM.auto_tick = false
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	Engine.max_fps = 240
	_world = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(_world, get_canvas_item())
	_background = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(_background, _world)
	_actor = RenderingServer.canvas_item_create()
	RenderingServer.canvas_item_set_parent(_actor, _world)
	for i: int in 20:
		RenderingServer.canvas_item_add_rect(_background, Rect2(float(i * 80), 100.0, 20.0, 120.0), Color.DIM_GRAY)
	RenderingServer.canvas_item_add_rect(_actor, Rect2(0.0, 120.0, 20.0, 20.0), Color.WHITE)


func _physics_process(_delta: float) -> void:
	_previous_actor = _actor_x
	_previous_camera = _camera_x
	_actor_x += 2.0
	_camera_x += 1.0
	_ticks += 1
	if _ticks >= 240:
		print("INTERPOLATION_PROTOTYPE ticks=%d frames=%d intermediate=%d" % [_ticks, _frames, _intermediate])
		get_tree().quit(0 if _intermediate > 0 else 1)


func _process(_delta: float) -> void:
	var fraction: float = Engine.get_physics_interpolation_fraction()
	var actor: float = lerpf(_previous_actor, _actor_x, fraction)
	var camera: float = lerpf(_previous_camera, _camera_x, fraction)
	RenderingServer.canvas_item_set_transform(_world, Transform2D(0.0, Vector2(-camera, 0.0)))
	RenderingServer.canvas_item_set_transform(_actor, Transform2D(0.0, Vector2(actor, 0.0)))
	_frames += 1
	if fraction > 0.05 and fraction < 0.95 and _ticks > 1:
		_intermediate += 1


func _exit_tree() -> void:
	RenderingServer.free_rid(_actor)
	RenderingServer.free_rid(_background)
	RenderingServer.free_rid(_world)
