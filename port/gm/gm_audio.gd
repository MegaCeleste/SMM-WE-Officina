extends "res://gm/gm_draw.gd"
## 兼容层第 3 层：音频。sound 资源编号 < FIRST_HANDLE，播放实例的句柄 >= FIRST_HANDLE，
## 所有 audio_* 函数两种编号都接受（与 GMS 一样）。

const FIRST_HANDLE: int = 100000

var _audio_root: Node = null
var _streams: Dictionary = {}  ## [sound, loop] → AudioStream
var _players: Dictionary = {}  ## 句柄 → AudioStreamPlayer
var _handle_sound: Dictionary = {}  ## 句柄 → sound 编号
var _handle_gain: Dictionary = {}  ## 句柄 → 增益（线性）
var _asset_gain: Dictionary = {}  ## sound 编号 → 增益（线性），默认取表里的 volume
var _asset_pitch: Dictionary = {}
var _next_handle: int = FIRST_HANDLE
var _master_gain: float = 1.0


func _init_audio() -> void:
	_audio_root = Node.new()
	_audio_root.name = "GMAudio"
	add_child(_audio_root)


func _stream_for(snd: int, loop: bool) -> AudioStream:
	var key: int = snd * 2 + (1 if loop else 0)
	if _streams.has(key):
		return _streams[key]
	var path: String = "res://" + String(sound_defs[snd][1])
	var st: AudioStream = null
	if ResourceLoader.exists(path):
		st = load(path) as AudioStream
	if st == null:
		push_warning("GM.audio: 找不到音频 %s" % path)
		_streams[key] = null
		return null
	if loop:
		st = st.duplicate() as AudioStream
		if st is AudioStreamOggVorbis:
			(st as AudioStreamOggVorbis).loop = true
		elif st is AudioStreamMP3:
			(st as AudioStreamMP3).loop = true
		elif st is AudioStreamWAV:
			var w: AudioStreamWAV = st
			w.loop_mode = AudioStreamWAV.LOOP_FORWARD
			w.loop_begin = 0
			var bytes_per_frame: int = (2 if w.format == AudioStreamWAV.FORMAT_16_BITS else 1) * (2 if w.stereo else 1)
			w.loop_end = w.data.size() / bytes_per_frame
	_streams[key] = st
	return st


func _handles_of(id: int) -> Array:
	if id >= FIRST_HANDLE:
		return [id] if _players.has(id) else []
	var out: Array = []
	for h: int in _handle_sound:
		if _handle_sound[h] == id:
			out.append(h)
	return out


func _apply_volume(h: int) -> void:
	var p: AudioStreamPlayer = _players[h]
	var snd: int = _handle_sound[h]
	var g: float = float(_handle_gain[h]) * float(_asset_gain.get(snd, sound_defs[snd][2])) * _master_gain
	p.volume_db = linear_to_db(maxf(g, 0.00001))


func _on_player_finished(h: int) -> void:
	if _players.has(h):
		(_players[h] as AudioStreamPlayer).queue_free()
		_players.erase(h)
		_handle_sound.erase(h)
		_handle_gain.erase(h)


func audio_play_sound(snd: int, _priority: float, loop: Variant) -> int:
	if snd < 0 or snd >= sound_defs.size():
		return -1
	var st: AudioStream = _stream_for(snd, bool(loop))
	var h: int = _next_handle
	_next_handle += 1
	if st == null:
		return h
	var p: AudioStreamPlayer = AudioStreamPlayer.new()
	p.stream = st
	p.pitch_scale = float(_asset_pitch.get(snd, 1.0))
	_audio_root.add_child(p)
	_players[h] = p
	_handle_sound[h] = snd
	_handle_gain[h] = 1.0
	_apply_volume(h)
	p.finished.connect(_on_player_finished.bind(h))
	p.play()
	return h


func audio_stop_sound(id: int) -> void:
	for h: int in _handles_of(id):
		var p: AudioStreamPlayer = _players[h]
		p.stop()
		_on_player_finished(h)


func audio_stop_all() -> void:
	for h: int in _players.keys():
		(_players[h] as AudioStreamPlayer).stop()
		_on_player_finished(h)


## 暂停中的声音也算在播放（与 GMS 一致）
func audio_is_playing(id: int) -> bool:
	return not _handles_of(id).is_empty()


func audio_is_paused(id: int) -> bool:
	for h: int in _handles_of(id):
		if (_players[h] as AudioStreamPlayer).stream_paused:
			return true
	return false


func audio_pause_sound(id: int) -> void:
	for h: int in _handles_of(id):
		(_players[h] as AudioStreamPlayer).stream_paused = true


func audio_resume_sound(id: int) -> void:
	for h: int in _handles_of(id):
		(_players[h] as AudioStreamPlayer).stream_paused = false


func audio_sound_pitch(id: int, pitch: float) -> void:
	if id < FIRST_HANDLE:
		_asset_pitch[id] = pitch
	for h: int in _handles_of(id):
		(_players[h] as AudioStreamPlayer).pitch_scale = maxf(pitch, 0.01)


## time_ms 的渐变没有实现，直接跳到目标音量（原版 3 处调用，移植到时再看是否需要渐变）
func audio_sound_gain(id: int, gain: float, _time_ms: float) -> void:
	if id < FIRST_HANDLE:
		_asset_gain[id] = gain
	else:
		_handle_gain[id] = gain
	for h: int in _handles_of(id):
		_apply_volume(h)


func audio_master_gain(gain: float) -> void:
	_master_gain = gain
	for h: int in _players:
		_apply_volume(h)


func audio_sound_set_track_position(id: int, seconds: float) -> void:
	for h: int in _handles_of(id):
		(_players[h] as AudioStreamPlayer).seek(seconds)
