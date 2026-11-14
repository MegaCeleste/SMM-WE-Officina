extends "res://gm/gm_audio.gd"
## 兼容层第 4 层：键盘、鼠标、手柄。键码用 GMS 的 vk 码（即 Windows 虚拟键码）。
## 按下/松开的“这一步刚发生”状态在每个 tick 开头锁存，整个 tick 内保持不变。

const gp_face1: int = 32769
const gp_face2: int = 32770
const gp_face3: int = 32771
const gp_face4: int = 32772
const gp_shoulderl: int = 32773
const gp_shoulderr: int = 32774
const gp_shoulderlb: int = 32775
const gp_shoulderrb: int = 32776
const gp_select: int = 32777
const gp_start: int = 32778
const gp_stickl: int = 32779
const gp_stickr: int = 32780
const gp_padu: int = 32781
const gp_padd: int = 32782
const gp_padl: int = 32783
const gp_padr: int = 32784
const gp_axislh: int = 32785
const gp_axislv: int = 32786
const gp_axisrh: int = 32787
const gp_axisrv: int = 32788

var keyboard_lastkey: int = 0
var keyboard_key: int = 0
var keyboard_string: String = ""

var _key_down: PackedByteArray = PackedByteArray()
var _key_pressed: PackedByteArray = PackedByteArray()
var _key_released: PackedByteArray = PackedByteArray()
var _key_pend_press: PackedByteArray = PackedByteArray()
var _key_pend_release: PackedByteArray = PackedByteArray()
var _any_pressed: bool = false
var _any_released: bool = false

var _mb_down: PackedByteArray = PackedByteArray([0, 0, 0, 0])
var _mb_pressed: PackedByteArray = PackedByteArray([0, 0, 0, 0])
var _mb_released: PackedByteArray = PackedByteArray([0, 0, 0, 0])
var _mb_pend_press: PackedByteArray = PackedByteArray([0, 0, 0, 0])
var _mb_pend_release: PackedByteArray = PackedByteArray([0, 0, 0, 0])
var _wheel_up: bool = false
var _wheel_down: bool = false
var _wheel_pend_up: bool = false
var _wheel_pend_down: bool = false

var _pad_down: Dictionary = {}
var _pad_prev: Dictionary = {}

## 测试用：非 null 时 mouse_x/mouse_y 取这个值（视口坐标），不读真实鼠标
var mouse_override: Variant = null

var mouse_x: float:
	get:
		return _cam_x[0] + _mouse_view_pos().x * _cam_w[0] / VIEW_W
var mouse_y: float:
	get:
		return _cam_y[0] + _mouse_view_pos().y * _cam_h[0] / VIEW_H


func _init_input() -> void:
	_key_down.resize(256)
	_key_pressed.resize(256)
	_key_released.resize(256)
	_key_pend_press.resize(256)
	_key_pend_release.resize(256)


func _mouse_view_pos() -> Vector2:
	if mouse_override != null:
		return mouse_override
	return _output_to_view(get_viewport().get_mouse_position())


func _output_to_view(pos: Vector2) -> Vector2:
	return (pos - _output_rect.position) * Vector2(VIEW_W / _output_rect.size.x, VIEW_H / _output_rect.size.y)


## Godot 键码 → GMS vk 码；不认识的返回 0
func _vk_of(ev: InputEventKey) -> int:
	var k: int = ev.keycode
	if k >= KEY_A and k <= KEY_Z:
		return k
	if k >= KEY_0 and k <= KEY_9:
		return k
	if k >= KEY_F1 and k <= KEY_F12:
		return vk_f1 + (k - KEY_F1)
	if k >= KEY_KP_0 and k <= KEY_KP_9:
		return vk_numpad0 + (k - KEY_KP_0)
	match k:
		KEY_SPACE: return vk_space
		KEY_ENTER, KEY_KP_ENTER: return vk_enter
		KEY_ESCAPE: return vk_escape
		KEY_BACKSPACE: return vk_backspace
		KEY_TAB: return vk_tab
		KEY_SHIFT: return vk_shift
		KEY_CTRL: return vk_control
		KEY_ALT: return vk_alt
		KEY_PAUSE: return vk_pause
		KEY_LEFT: return vk_left
		KEY_UP: return vk_up
		KEY_RIGHT: return vk_right
		KEY_DOWN: return vk_down
		KEY_PAGEUP: return vk_pageup
		KEY_PAGEDOWN: return vk_pagedown
		KEY_END: return vk_end
		KEY_HOME: return vk_home
		KEY_INSERT: return vk_insert
		KEY_DELETE: return vk_delete
		KEY_PRINT: return vk_printscreen
		KEY_KP_MULTIPLY: return vk_multiply
		KEY_KP_ADD: return vk_add
		KEY_KP_SUBTRACT: return vk_subtract
		KEY_KP_PERIOD: return vk_decimal
		KEY_KP_DIVIDE: return vk_divide
		KEY_SEMICOLON: return 186
		KEY_EQUAL: return 187
		KEY_COMMA: return 188
		KEY_MINUS: return 189
		KEY_PERIOD: return 190
		KEY_SLASH: return 191
		KEY_QUOTELEFT: return 192
		KEY_BRACKETLEFT: return 219
		KEY_BACKSLASH: return 220
		KEY_BRACKETRIGHT: return 221
		KEY_APOSTROPHE: return 222
	return 0


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var ek: InputEventKey = event
		if ek.echo:
			if ek.pressed and ek.unicode >= 32:
				keyboard_string += String.chr(ek.unicode)
			return
		if ek.pressed and ek.keycode == KEY_ENTER and ek.alt_pressed:
			window_set_fullscreen(not window_get_fullscreen())
			return
		var vk: int = _vk_of(ek)
		if vk > 0:
			if ek.pressed:
				_key_pend_press[vk] = 1
			else:
				_key_pend_release[vk] = 1
		if ek.pressed:
			if ek.keycode == KEY_BACKSPACE:
				keyboard_string = keyboard_string.substr(0, maxi(keyboard_string.length() - 1, 0))
			elif ek.unicode >= 32:
				keyboard_string += String.chr(ek.unicode)
	elif event is InputEventMouseButton:
		var em: InputEventMouseButton = event
		var b: int = 0
		match em.button_index:
			MOUSE_BUTTON_LEFT: b = mb_left
			MOUSE_BUTTON_RIGHT: b = mb_right
			MOUSE_BUTTON_MIDDLE: b = mb_middle
			MOUSE_BUTTON_WHEEL_UP:
				if em.pressed:
					_wheel_pend_up = true
			MOUSE_BUTTON_WHEEL_DOWN:
				if em.pressed:
					_wheel_pend_down = true
		if b > 0:
			if em.pressed:
				_mb_pend_press[b] = 1
			else:
				_mb_pend_release[b] = 1


## 每个 tick 开头调用：把两个 tick 之间积累的输入锁存成这一步的状态
func _input_begin_step() -> void:
	_any_pressed = false
	_any_released = false
	for vk: int in 256:
		var pr: int = _key_pend_press[vk]
		var rl: int = _key_pend_release[vk]
		_key_pressed[vk] = pr
		_key_released[vk] = rl
		if pr != 0:
			_key_down[vk] = 1
			_any_pressed = true
			keyboard_lastkey = vk
			keyboard_key = vk
		if rl != 0:
			# 同一步内既按下又松开：这一步仍算按下过，状态记为已松开
			_key_down[vk] = 0
			_any_released = true
		_key_pend_press[vk] = 0
		_key_pend_release[vk] = 0
	for b: int in range(1, 4):
		_mb_pressed[b] = _mb_pend_press[b]
		_mb_released[b] = _mb_pend_release[b]
		if _mb_pend_press[b] != 0:
			_mb_down[b] = 1
		if _mb_pend_release[b] != 0:
			_mb_down[b] = 0
		_mb_pend_press[b] = 0
		_mb_pend_release[b] = 0
	_wheel_up = _wheel_pend_up
	_wheel_down = _wheel_pend_down
	_wheel_pend_up = false
	_wheel_pend_down = false
	_pad_prev = _pad_down
	_pad_down = {}


# ---- 键盘 ----

func keyboard_check(vk: int) -> bool:
	if vk == vk_anykey:
		return _key_down.has(1)
	if vk == vk_nokey:
		return not _key_down.has(1)
	if vk == vk_shift:
		return _key_down[vk_shift] != 0 or _key_down[vk_lshift] != 0 or _key_down[vk_rshift] != 0
	return vk > 0 and vk < 256 and _key_down[vk] != 0


func keyboard_check_pressed(vk: int) -> bool:
	if vk == vk_anykey:
		return _any_pressed
	if vk == vk_nokey:
		return not _any_pressed
	return vk > 0 and vk < 256 and _key_pressed[vk] != 0


func keyboard_check_released(vk: int) -> bool:
	if vk == vk_anykey:
		return _any_released
	if vk == vk_nokey:
		return not _any_released
	return vk > 0 and vk < 256 and _key_released[vk] != 0


## 模拟按键。 UNVERIFIED(U10)：这里让“按住”状态立刻生效、“刚按下”在下一步生效；
## GMS 里 keyboard_key_press 之后同一步内 keyboard_check_pressed 是否为真未确认。
func keyboard_key_press(vk: int) -> void:
	if vk > 0 and vk < 256:
		if _key_down[vk] == 0:
			_key_pend_press[vk] = 1
		_key_down[vk] = 1


func keyboard_key_release(vk: int) -> void:
	if vk > 0 and vk < 256:
		if _key_down[vk] != 0:
			_key_pend_release[vk] = 1
		_key_down[vk] = 0


func keyboard_clear(vk: int) -> void:
	if vk > 0 and vk < 256:
		_key_down[vk] = 0
		_key_pressed[vk] = 0
		_key_released[vk] = 0


# ---- 鼠标 ----

func mouse_check_button(b: int) -> bool:
	if b == mb_any:
		return _mb_down[1] != 0 or _mb_down[2] != 0 or _mb_down[3] != 0
	if b == mb_none:
		return _mb_down[1] == 0 and _mb_down[2] == 0 and _mb_down[3] == 0
	return _mb_down[b] != 0


func mouse_check_button_pressed(b: int) -> bool:
	if b == mb_any:
		return _mb_pressed[1] != 0 or _mb_pressed[2] != 0 or _mb_pressed[3] != 0
	if b == mb_none:
		return _mb_pressed[1] == 0 and _mb_pressed[2] == 0 and _mb_pressed[3] == 0
	return _mb_pressed[b] != 0


func mouse_check_button_released(b: int) -> bool:
	if b == mb_any:
		return _mb_released[1] != 0 or _mb_released[2] != 0 or _mb_released[3] != 0
	if b == mb_none:
		return _mb_released[1] == 0 and _mb_released[2] == 0 and _mb_released[3] == 0
	return _mb_released[b] != 0


func mouse_wheel_up() -> bool:
	return _wheel_up


func mouse_wheel_down() -> bool:
	return _wheel_down


# ---- 手柄（原版只在 2 个文件里用） ----

func _joy_button(gp: int) -> int:
	match gp:
		gp_face1: return JOY_BUTTON_A
		gp_face2: return JOY_BUTTON_B
		gp_face3: return JOY_BUTTON_X
		gp_face4: return JOY_BUTTON_Y
		gp_shoulderl: return JOY_BUTTON_LEFT_SHOULDER
		gp_shoulderr: return JOY_BUTTON_RIGHT_SHOULDER
		gp_select: return JOY_BUTTON_BACK
		gp_start: return JOY_BUTTON_START
		gp_stickl: return JOY_BUTTON_LEFT_STICK
		gp_stickr: return JOY_BUTTON_RIGHT_STICK
		gp_padu: return JOY_BUTTON_DPAD_UP
		gp_padd: return JOY_BUTTON_DPAD_DOWN
		gp_padl: return JOY_BUTTON_DPAD_LEFT
		gp_padr: return JOY_BUTTON_DPAD_RIGHT
	return -1


func _pad_state(device: int, gp: int) -> bool:
	var key: int = device * 100000 + gp
	if _pad_down.has(key):
		return _pad_down[key]
	var v: bool = false
	if gp == gp_shoulderlb:
		v = Input.get_joy_axis(device, JOY_AXIS_TRIGGER_LEFT) > 0.5
	elif gp == gp_shoulderrb:
		v = Input.get_joy_axis(device, JOY_AXIS_TRIGGER_RIGHT) > 0.5
	else:
		var jb: int = _joy_button(gp)
		v = jb >= 0 and Input.is_joy_button_pressed(device, jb)
	_pad_down[key] = v
	return v


func gamepad_is_connected(device: int) -> bool:
	return Input.get_connected_joypads().has(device)


func gamepad_button_check(device: int, gp: int) -> bool:
	return _pad_state(device, gp)


func gamepad_button_check_pressed(device: int, gp: int) -> bool:
	return _pad_state(device, gp) and not bool(_pad_prev.get(device * 100000 + gp, false))


func gamepad_button_check_released(device: int, gp: int) -> bool:
	return not _pad_state(device, gp) and bool(_pad_prev.get(device * 100000 + gp, false))


func gamepad_axis_value(device: int, axis: int) -> float:
	match axis:
		gp_axislh: return Input.get_joy_axis(device, JOY_AXIS_LEFT_X)
		gp_axislv: return Input.get_joy_axis(device, JOY_AXIS_LEFT_Y)
		gp_axisrh: return Input.get_joy_axis(device, JOY_AXIS_RIGHT_X)
		gp_axisrv: return Input.get_joy_axis(device, JOY_AXIS_RIGHT_Y)
	return 0.0


# ---- 窗口 ----

func window_set_fullscreen(full: Variant) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if bool(full) else DisplayServer.WINDOW_MODE_WINDOWED)


func window_get_fullscreen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
