# from objects/obj_icecoin（第 5 批移植，已核对）
extends "res://objects/obj_rockparent.gd"

var sprite_block: int = 0  ## sprite 编号
# shard 已声明在 obj_rockparent
var sprite_wings: int = 0  ## sprite 编号
var sprite_coin: int = 0  ## sprite 编号
var wings: float = 0.0
var wings_anim: float = 0.0


# from objects/obj_icecoin/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_ice_coin
			sprite_block = A.spr_SMB_ice_coinblock
			shard = A.spr_SMB_shard_ice
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_ice_coin_ice
					else:
						sprite_index = A.spr_SMB3_ice_coin
				"castle":
					sprite_index = A.spr_SMB3_ice_coin_night
				"ghost":
					sprite_index = A.spr_SMB3_ice_coin_night
				"underground":
					sprite_index = A.spr_SMB3_ice_coin_night
				_:
					# 原版 default 里 if 内的 break 只是跳出 switch，等价于 if/else
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_ice_coin_night
					else:
						sprite_index = A.spr_SMB3_ice_coin
			sprite_block = A.spr_SMB3_ice_coinblock
			shard = A.spr_SMB3_shard_ice
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_block = A.spr_ice_coinblock
			shard = A.spr_shard_ice
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_ice_coin
			sprite_block = A.spr_NSMBU_ice_coinblock
			shard = A.spr_NSMBU_shardice
			sprite_wings = A.spr_NSMBU_wings_items
	sprite_coin = sprite_index
	image_speed = 0.15
	wings = 0.0
	wings_anim = 0.0
	alarm[10] = 4.0


# from objects/obj_icecoin/Step_0.gml
func _step() -> void:
	super._step()
	if GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
		sprite_index = sprite_block
	else:
		sprite_index = sprite_coin


# from objects/obj_icecoin/Collision_obj_angrysun.gml
func _collision_obj_angrysun(other: GMObject) -> void:
	if G.modo_noche == 0.0:
		_user_1()


# from objects/obj_icecoin/Collision_obj_bowser_fire.gml
func _collision_obj_bowser_fire(other: GMObject) -> void:
	_user_1()


# from objects/obj_icecoin/Collision_obj_cheepcheep.gml
func _collision_obj_cheepcheep(other: GMObject) -> void:
	if other.lava == 1.0 and G.bg_level == "castle":
		_user_1()


# from objects/obj_icecoin/Collision_obj_explosion.gml
func _collision_obj_explosion(other: GMObject) -> void:
	var lm = GM.instance_find(A.obj_levelmanager, 0)  # obj_levelmanager.editor 读：第 16 条
	if lm.editor == 0.0:
		alarm[0] = 1.0


# from objects/obj_icecoin/Collision_obj_fire_clown.gml
func _collision_obj_fire_clown(other: GMObject) -> void:
	_user_1()


# from objects/obj_icecoin/Collision_obj_plantfire.gml
func _collision_obj_plantfire(other: GMObject) -> void:
	_user_1()
	for inst in GM.with_list(other):
		inst.instance_destroy()


# from objects/obj_icecoin/Collision_obj_podoboo.gml
func _collision_obj_podoboo(other: GMObject) -> void:
	_user_1()


# from objects/obj_icecoin/Collision_obj_soplete.gml
func _collision_obj_soplete(other: GMObject) -> void:
	if other.invisible == 0.0:
		_user_1()


# from objects/obj_icecoin/Collision_obj_yoshifire.gml
func _collision_obj_yoshifire(other: GMObject) -> void:
	var lm = GM.instance_find(A.obj_levelmanager, 0)  # obj_levelmanager.editor 读：第 16 条
	if lm.editor == 0.0:
		_user_1()


# from objects/obj_icecoin/Other_11.gml
func _user_1() -> void:
	GM.instance_create(x, y, A.obj_smoke)
	GM.instance_create(x, y, A.obj_coin)
	instance_destroy()


# from objects/obj_icecoin/Draw_0.gml
func _gm_draw() -> void:
	var anim: float
	var lm = GM.instance_find(A.obj_levelmanager, 0)  # obj_levelmanager.banim 读：第 16 条
	if G.apariencia == 3.0:
		anim = (lm.banim - 0.05)
	else:
		anim = lm.banim
	GM.draw_sprite_ext(sprite_index, anim, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
