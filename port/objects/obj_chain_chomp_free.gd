# from objects/obj_chain_chomp_free（第 6e 批移植，已核对）
extends "res://objects/obj_enemyparent.gd"

var dark: float = 0.0
var s_chain: float = 0.0
var edible: float = 0.0
var fallow_chomp: float = 0.0
var sound: float = 0.0
var followers: float = 0.0
var closeness: float = 0.0
var amount_previous: float = 0.0
var i: float = 0.0
var oldx: Array = []
var oldy: Array = []
var imdead1 = null


# from objects/obj_chain_chomp_free/Create_0.gml
func _create() -> void:
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB_chainchomp_night
			else:
				sprite_index = A.spr_SMB_chainchomp
			s_chain = A.spr_SMB_chain
		1.0:
			if dark == 1.0:
				sprite_index = A.spr_SMB3_chainchomp_night
			else:
				sprite_index = A.spr_SMB3_chainchomp
			s_chain = A.spr_SMB3_chain
		2.0:
			sprite_index = A.spr_chainchomp
			s_chain = A.spr_chain
		3.0:
			sprite_index = A.spr_NSMBU_chainchomp
			s_chain = A.spr_NSMBU_chain
	hardness = 0.0
	stomp = 1.0
	edible = 0.0
	direct = -1.0
	dead_h = 0.0
	modo_lava = 0.0
	wings = 0.0
	swimming = 0.0
	paracaidas = 0.0
	fallow_chomp = 1.0
	apilar = 0.0
	sound = 0.0
	alarm[10] = 2.0
	if G.apariencia == 3.0:
		image_speed = 0.3
	else:
		image_speed = 0.15
	followers = 5.0
	closeness = 7.0
	amount_previous = 40.0
	i = 0.0
	while i < amount_previous:
		GM.aset(oldx, int(i), x)
		GM.aset(oldy, int(i), y)
		i += 1.0


# from objects/obj_chain_chomp_free/Step_0.gml
func _step() -> void:
	super._step()
	if fallow_chomp == 1.0:
		GM.aset(oldx, 0, x)
		GM.aset(oldy, 0, y)
		i = amount_previous
		while i > 0.0:
			GM.aset(oldx, int(i), oldx[int(i - 1.0)])
			GM.aset(oldy, int(i), oldy[int(i - 1.0)])
			i -= 1.0
	if gravity == 0.0:
		if object_index == A.obj_chain_chomp_free_b:
			vspeed = (-((3.0 - (1.0 * swimming))))
		else:
			vspeed = (-((2.0 - (0.5 * swimming))))
		y -= 1.0
	else:
		gravity = 0.125
	if G.apariencia != 3.0:
		return
	if Scr.outside_view(self) <= 0.5:
		if sound == 0.0:
			GM.audio_stop_sound(A.snd_NSMBU_chomp)
			GM.audio_play_sound(A.snd_NSMBU_chomp, 0.0, false)
			sound = 1.0
	else:
		sound = 0.0


# from objects/obj_chain_chomp_free/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if G.bg_level == "underwater" or ((G.bg_level == "airship" or G.bg_level == "sky") and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			hspeed = (0.8 * direct)
		else:
			hspeed = (1.3 * direct)


# from objects/obj_chain_chomp_free/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	imdead.image_speed = 0.0
	imdead.image_index = image_index
	imdead.direct = direct
	imdead.gravity = 0.16
	var k: float = 1.0  # PORT: 原版 for (var i...) 是局部变量 i，与实例变量 i 同名，改名 k 避免遮蔽
	while k < 5.0:
		imdead1 = GM.instance_create(oldx[int(k * closeness)], oldy[int(k * closeness)], A.obj_enemy_dead)
		imdead1.girar = 1.0
		imdead1.sprite_index = s_chain
		imdead1.image_speed = 0.0
		imdead1.image_index = dark
		imdead1.direct = direct
		imdead1.gravity = 0.16
		imdead.hspeed = GM.choose(1.0, -1.0)
		imdead1.hspeed = -1.0
		k += 1.0
	instance_destroy()


# from objects/obj_chain_chomp_free/Draw_0.gml
func _gm_draw() -> void:
	i = 1.0
	while i < followers:
		GM.draw_sprite(s_chain, dark, oldx[int(i * closeness)], oldy[int(i * closeness)])
		i += 1.0
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
