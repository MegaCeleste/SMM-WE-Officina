# 第 4 批移植，已核对。
extends GMObject

var holding: float = 0.0
var direct: float = 0.0
var yview: float = 0.0
var helmet: float = 0.0
var cap: float = 0.0
var myitem = null
var offset: float = 0.0
var my_y: float = 0.0
var snow = null


# from objects/obj_doormario/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if G.apariencia == 3.0:
		match G.powerup:
			0.0:
				image_index = 0.0
			1.0:
				image_index = 1.0
			2.0:
				image_index = 2.0
			-30.0:
				image_index = 3.0
			-38.0:
				image_index = 4.0
			-43.0:
				image_index = 5.0
	else:
		image_index = 0.0
	holding = 0.0
	direct = 1.0
	yview = (y + 32.0)
	helmet = 0.0
	cap = 0.0
	myitem = GM.noone
	offset = 0.0
	if G.powerup == 0.0:
		my_y = (y + 15.0)
	else:
		my_y = (y + 12.0)


# from objects/obj_doormario/Draw_0.gml
func _gm_draw() -> void:
	var bota_roja
	var bota_verde
	var drybones_shell
	var iindex
	match G.apariencia:
		0.0:
			if G.powerup == -77.0:
				drybones_shell = A.spr_SMB_kuribo_drybones_mega
				bota_roja = A.spr_SMB_kuriboshoe2_big
				bota_verde = A.spr_kuriboshoe_big
			else:
				drybones_shell = A.spr_SMB_kuribo_drybones
				bota_roja = A.spr_SMB_kuriboshoe2
				bota_verde = A.spr_SMB_kuriboshoe
		1.0:
			drybones_shell = A.spr_SMB3_kuribo_drybones
			bota_roja = A.spr_kuriboshoe2
			bota_verde = A.spr_kuriboshoe
		3.0:
			drybones_shell = A.spr_NSMBU_kuribo_drybones
			bota_roja = A.spr_kuriboshoe2
			bota_verde = A.spr_SMB_kuriboshoe
		_:
			drybones_shell = A.spr_kuribo_drybones
			bota_roja = A.spr_SMB_kuriboshoe2
			bota_verde = A.spr_SMB_kuriboshoe
	if G.yoshi > 0.0:
		if G.yoshi == 1.0:
			if GM.instance_exists(A.obj_yoshi_red):
				GM.draw_sprite_ext(A.spr_yoshi_red, image_index, GM.gm_round(x), (GM.gm_round(y) + 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			elif GM.instance_exists(A.obj_yoshi_blue):
				var i_yoshi_blue = GM.instance_find(A.obj_yoshi_blue, 0)
				if i_yoshi_blue.mouthholder != null:
					GM.draw_sprite_ext(A.spr_yoshi_fm_blue, image_index, GM.gm_round(x), (GM.gm_round(y) + 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(A.spr_yoshi_blue, image_index, GM.gm_round(x), (GM.gm_round(y) + 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			elif GM.instance_exists(A.obj_yoshi2):
				var i_yoshi2 = GM.instance_find(A.obj_yoshi2, 0)
				if i_yoshi2.mouthholder != null:
					GM.draw_sprite_ext(A.spr_yoshi_fm, image_index, GM.gm_round(x), (GM.gm_round(y) + 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(A.spr_yoshi, image_index, GM.gm_round(x), (GM.gm_round(y) + 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			GM.draw_sprite_ext(Scr.scr_marioride(self), image_index, GM.gm_round(x), (y - 8.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
		elif G.yoshi == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if G.powerup == -77.0:
					GM.draw_sprite_ext(Scr.scr_mario_drybones(self), 0.0, GM.gm_round(x), (y - 15.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(Scr.scr_mario_drybones(self), 0.0, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				GM.draw_sprite_ext(drybones_shell, 0.0, GM.gm_round(x), (y + 17.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			elif GM.instance_exists(A.obj_kuriboshoe2):
				if G.powerup == -77.0:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), (y - 15.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				GM.draw_sprite_ext(bota_roja, 0.0, GM.gm_round(x), (y + 17.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			elif GM.instance_exists(A.obj_kuriboshoe):
				if G.powerup == -77.0:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), (y - 17.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				GM.draw_sprite_ext(bota_verde, 0.0, GM.gm_round(x), (y + 17.0), direct, 1.0, 0.0, GM.c_white, 1.0)
	else:
		if holding == 1.0 or holding == 2.0:
			if G.apariencia == 3.0:
				sprite_index = Scr.scr_NSMBU_hold(self)
			else:
				sprite_index = Scr.scr_mariohold(self)
		elif G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_mario_turn
		else:
			sprite_index = Scr.scr_marioidle(self)
		if G.powerup == 3.0:
			GM.draw_sprite_ext(A.spr_cap_stay_start, 0.0, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
		if holding == 2.0:
			if G.powerup == -85.0:
				GM.draw_sprite(myitem, 0.0, x, (y + 1.0))
			else:
				var posx: float = GM.sprite_get_xoffset(myitem)
				if posx != 0.0:
					posx = 0.0
				else:
					posx = 8.0
				if myitem == A.spr_frozenblock_24x24 or myitem == A.spr_frozenblock_32x32 or myitem == A.spr_frozenblock_24x36 or myitem == A.spr_frozenblock_24x24 or myitem == A.spr_frozenblock_36x24 or myitem == A.spr_frozenblock_32x48:
					iindex = G.apariencia
				else:
					iindex = 0.0
				GM.draw_sprite(myitem, iindex, ((x - posx) + (11.0 * direct)), my_y)
			GM.draw_sprite_ext(sprite_index, 0.0, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
		else:
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
