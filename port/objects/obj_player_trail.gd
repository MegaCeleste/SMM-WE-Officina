extends GMObject

var y_draw: float = 0.0
var drybones: float = 0.0
var sprite_capa = null
var index_capa = null
var direct_capa = null
var depth_cap: float = 0.0
var sprite_m_yoshi = null
var index_m_yoshi = null
var x_m_yoshi = null
var y_m_yoshi = null
var depth_capa = null  # ORIG-BUG: editor manager writes depth_capa; Draw reads depth_cap.


# from objects/obj_player_trail/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	y_draw = y
	drybones = 0.0
	sprite_capa = 0.0
	index_capa = 0.0
	direct_capa = 0.0
	depth_cap = 0.0
	sprite_m_yoshi = 0.0
	index_m_yoshi = 0.0
	x_m_yoshi = 0.0
	y_m_yoshi = 0.0


# from objects/obj_player_trail/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and G.player_trail == 1.0:
		if sprite_capa != A.spr_SMB_mario_small_idle and depth_cap == 0.0:
			GM.draw_sprite_ext(sprite_capa, index_capa, GM.gm_round(x), GM.gm_round(y), direct_capa, 1.0, 0.0, GM.c_white, 0.5)
		if drybones == 1.0:
			if sprite_m_yoshi != A.spr_SMB_mario_small_idle:
				GM.draw_sprite_ext(sprite_m_yoshi, index_m_yoshi, x_m_yoshi, y_m_yoshi, image_xscale, 1.0, 0.0, GM.c_white, 0.5)
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y_draw, image_xscale, 1.0, 0.0, GM.c_white, 0.5)
		else:
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y_draw, image_xscale, 1.0, image_angle, GM.c_white, 0.5)
			if sprite_m_yoshi != A.spr_SMB_mario_small_idle:
				GM.draw_sprite_ext(sprite_m_yoshi, index_m_yoshi, x_m_yoshi, y_m_yoshi, image_xscale, 1.0, 0.0, GM.c_white, 0.5)
		if sprite_capa != A.spr_SMB_mario_small_idle and depth_cap == 1.0:
			GM.draw_sprite_ext(sprite_capa, index_capa, GM.gm_round(x), (y - 10.0), direct_capa, 1.0, 0.0, GM.c_white, 0.5)
