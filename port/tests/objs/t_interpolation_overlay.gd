extends GMObject


func _gm_draw() -> void:
	GM.draw_set_color(GM.c_red)
	GM.draw_rectangle(x - 4.0, y - 12.0, x + 4.0, y + 2.0, false)
	GM.draw_set_color(GM.c_white)
