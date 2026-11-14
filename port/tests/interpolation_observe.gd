extends "res://tests/play_enemies.gd"
## Interactive comparison; I toggles the experimental actor/camera interpolation.

var _observed_player: GMObject = null
var _interpolation_on: bool = true
var _camera_smoothing_on: bool = true


func _ready() -> void:
	GM.interpolation_auto = false
	super._ready()
	Engine.max_fps = 0
	_set_title()


func _place() -> void:
	if "--empty" in OS.get_cmdline_user_args():
		return
	super._place()
	# Moving items make it possible to compare their interpolation alongside enemies.
	for px: float in [320.0, 1088.0, 1856.0]:
		var mushroom: GMObject = GM.instance_create(px, GROUND_Y - 16.0, A.obj_mushroom)
		mushroom.hspeed = -1.0
		var coin = GM.instance_create(px + 48.0, GROUND_Y - 88.0, A.obj_coin)
		coin.wings = 1.0


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not _placed:
		return
	if not is_instance_valid(_observed_player) or not GM.instance_exists(_observed_player):
		_observed_player = GM.instance_find(A.obj_mario, 0)
		if _observed_player != null:
			# Keep scanout synchronized while comparing camera/actor motion.
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			GM.prototype_interpolate_actor(_observed_player if _interpolation_on else null)


func _unhandled_key_input(event: InputEvent) -> void:
	var key: InputEventKey = event as InputEventKey
	if key != null and key.pressed and not key.echo and key.keycode == KEY_I:
		_interpolation_on = not _interpolation_on
		GM.prototype_interpolate_actor(_observed_player if _interpolation_on and is_instance_valid(_observed_player) else null)
		_set_title()
		return
	if key != null and key.pressed and not key.echo and key.keycode == KEY_C:
		_camera_smoothing_on = not _camera_smoothing_on
		GM.interpolation_camera_smoothing = _camera_smoothing_on
		GM._presentation_camera_history.clear()
		_set_title()
		return
	super._unhandled_key_input(event)


func _set_title() -> void:
	DisplayServer.window_set_title("OpenWE - interpolation %s (I), camera smoothing %s (C)" % ["ON" if _interpolation_on else "OFF", "ON" if _camera_smoothing_on else "OFF"])
