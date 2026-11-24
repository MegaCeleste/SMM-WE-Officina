extends GMObject

var write: float = 0.0
var TX: float = 0.0
var TY: float = 0.0
var texto: String = ""
var new_texto: String = ""
var _touch_input: LineEdit

# from objects/obj_iname/Create_0.gml
func _create() -> void:
	write = 1.0
	TX = 132.0
	TY = 20.0
	texto = ""
	new_texto = ""
	GM.keyboard_string = ""
	image_speed = 0.0
	image_index = 0.0
	if OS.has_feature("android"):
		_create_touch_input()

# from objects/obj_iname/Destroy_0.gml
func _destroy() -> void:
	GM.keyboard_string = ""

func _cleanup() -> void:
	if _touch_input != null:
		_touch_input.release_focus()
		_touch_input.hide()


func _create_touch_input() -> void:
	var layer: CanvasLayer = CanvasLayer.new()
	layer.layer = 11
	add_child(layer)
	_touch_input = LineEdit.new()
	var style: StyleBoxEmpty = StyleBoxEmpty.new()
	style.content_margin_left = 20.0
	style.content_margin_right = 3.0
	for state: String in ["normal", "focus"]:
		_touch_input.add_theme_stylebox_override(state, style)
	_touch_input.add_theme_color_override("font_color", Color.BLACK)
	_touch_input.add_theme_color_override("caret_color", Color.BLACK)
	_touch_input.add_theme_font_size_override("font_size", 14)
	_touch_input.text = new_texto
	_touch_input.text_changed.connect(_touch_text_changed)
	_touch_input.text_submitted.connect(func(_text: String) -> void: _touch_input.release_focus())
	layer.add_child(_touch_input)
	_touch_input.size = Vector2(sprite_width, sprite_height)
	get_viewport().size_changed.connect(_position_touch_input)
	_position_touch_input()


func _position_touch_input() -> void:
	var camera: int = GM.view_get_camera(0)
	var camera_position: Vector2 = Vector2(GM.camera_get_view_x(camera), GM.camera_get_view_y(camera))
	var camera_size: Vector2 = Vector2(GM.camera_get_view_width(camera), GM.camera_get_view_height(camera))
	_touch_input.scale = GM._output_rect.size / camera_size
	_touch_input.position = GM._output_rect.position + (Vector2(x, y) - camera_position) * _touch_input.scale


func _touch_text_changed(text: String) -> void:
	new_texto = text.replace("#", "")
	if new_texto != text:
		var caret: int = text.left(_touch_input.caret_column).replace("#", "").length()
		_touch_input.text = new_texto
		_touch_input.caret_column = caret


# from objects/obj_iname/Step_0.gml
func _step() -> void:
	if _touch_input != null:
		image_index = 1.0 if _touch_input.has_focus() else 0.0
		return
	image_index = write
	if write == 1.0:
		if GM.string_width(GM.string_hash_to_newline(new_texto)) < TX or GM.keyboard_check(GM.vk_backspace):
			new_texto = GM.string_replace_all(GM.keyboard_string, "#", "")
		else:
			GM.keyboard_string = new_texto
	if GM.mouse_check_button_pressed(GM.mb_left):
		if GM.mouse_x >= x and GM.mouse_x <= x + TX and GM.mouse_y >= y and GM.mouse_y <= y + TY:
			for inst in GM.with_list(A.obj_lp):
				inst.write = 0.0
			write = 1.0
			GM.keyboard_string = new_texto
		else:
			write = 0.0
	if GM.keyboard_check(GM.vk_return):
		write = 0.0

# from objects/obj_iname/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if _touch_input != null:
		return
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_black)
	var new_string: String = new_texto
	if GM.string_width(GM.string_hash_to_newline(new_texto)) > 100.0:
		new_string = GM.string_copy(new_texto, 0.0, 20.0) + "..."
	GM.draw_text(x + 20.0, y + 2.0, GM.string_hash_to_newline(new_string))
