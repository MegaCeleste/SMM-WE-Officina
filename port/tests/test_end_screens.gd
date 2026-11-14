extends Node

var checks: int = 0
var failures: int = 0

func check(value: bool, message: String) -> void:
	checks += 1
	if not value:
		failures += 1
		printerr("FAIL: ", message)

func _ready() -> void:
	GM.auto_tick = false
	GM.game_start(A.rm_logo)
	var p = GM.instance_find(A.obj_persistent, 0)
	p.alarm[4] = -1.0
	GM.room_goto(A.rm_gameover)
	GM.tick()
	for i: int in range(40):
		GM.tick()
	var gameover = GM.instance_find(A.obj_game_over, 0)
	check(gameover != null, "game over object exists")
	if gameover != null:
		gameover._animation_end()
		check(gameover.image_speed == 0.0 and gameover.image_index == 18.0, "game over animation stops on frame 18")
	GM.room_goto(A.rm_credito)
	GM.tick()
	for i: int in range(40):
		GM.tick()
	var credits = GM.instance_find(A.cre_control, 0)
	check(credits != null, "credits controller exists")
	check(GM.instance_exists(A.obj_ccred), "credits back button exists")
	if credits != null:
		credits._gm_draw()
		credits.ready_v = 3.0
		credits.alpha = 0.0
		credits._step()
		GM.tick()
		check(GM.room == A.rm_title, "credits finish at title")
	var stale_target: GMObject = GMObject.new()
	GM.camera_set_view_target(0, stale_target)
	stale_target.free()
	GM._update_view_follow()
	check(true, "freed camera target does not interrupt drawing")
	GM.camera_set_view_target(0, null)
	print("end screen tests: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)
