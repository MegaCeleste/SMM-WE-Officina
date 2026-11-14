extends "res://tests/play_enemies.gd"
## Real renderer frame pacing sample; run with -- land <style>.

var _frame_times: Array[float] = []
var _last_frame_us: int = 0
var _warmup: int = 120
var _first_tick: int = 0


func _process(_delta: float) -> void:
	if not _placed:
		return
	var now: int = Time.get_ticks_usec()
	if _warmup > 0:
		_warmup -= 1
		_last_frame_us = now
		_first_tick = GM.tick_count
		return
	_frame_times.append(float(now - _last_frame_us) / 1000.0)
	_last_frame_us = now
	if _frame_times.size() < 360:
		return
	_frame_times.sort()
	var total: float = 0.0
	for ms: float in _frame_times:
		total += ms
	print("RENDER_BENCH renderer=%s style=%d frames=%d ticks=%d mean_ms=%.3f p95_ms=%.3f p99_ms=%.3f max_ms=%.3f" % [RenderingServer.get_video_adapter_name(), _style, _frame_times.size(), GM.tick_count - _first_tick, total / _frame_times.size(), _frame_times[int(_frame_times.size() * 0.95)], _frame_times[int(_frame_times.size() * 0.99)], _frame_times.back()])
	get_tree().quit()
