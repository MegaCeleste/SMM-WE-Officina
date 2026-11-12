# from objects/obj_checkpoint（第 7 批移植，已核对）
extends GMObject

var rotacion: float = 0.0
var sprout: float = 0.0
var my_sprite = null  ## scr_constant_get_sprite 的返回值
var pink_coins: float = 0.0
var pink_coin1_x: float = 0.0
var pink_coin1_y: float = 0.0
var pink_coin2_x: float = 0.0
var pink_coin2_y: float = 0.0
var pink_coin3_x: float = 0.0
var pink_coin3_y: float = 0.0
var pink_coin4_x: float = 0.0
var pink_coin4_y: float = 0.0
var pink_coin5_x: float = 0.0
var pink_coin5_y: float = 0.0
var pink_coin6_x: float = 0.0
var pink_coin6_y: float = 0.0
var pink_coin7_x: float = 0.0
var pink_coin7_y: float = 0.0
var pink_coin8_x: float = 0.0
var pink_coin8_y: float = 0.0
var pink_coin9_x: float = 0.0
var pink_coin9_y: float = 0.0
var pink_coin10_x: float = 0.0
var pink_coin10_y: float = 0.0


# from objects/obj_checkpoint/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if GM.room == G.checkpointroom:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_checkpoint
				image_speed = 0.0
				image_index = G.jugador
			1.0:
				sprite_index = A.spr_SMB3_checkpoint
				image_speed = 0.0
				image_index = G.jugador
			2.0:
				match G.jugador:
					0.0:
						sprite_index = A.spr_flag_mario
					1.0:
						sprite_index = A.spr_flag_luigi
					2.0:
						sprite_index = A.spr_flag_toad
					3.0:
						sprite_index = A.spr_flag_toadette
				image_speed = 0.15
			3.0:
				sprite_index = A.spr_NSMBU_checkpoint_mario
				image_speed = 0.5
	else:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_checkpoint_bowser
			1.0:
				sprite_index = A.spr_SMB3_checkpoint_bowser
			2.0:
				image_speed = 0.15
			3.0:
				sprite_index = A.spr_NSMBU_checkpoint
				image_speed = 0.5
	rotacion = 0.0
	sprout = -1.0
	my_sprite = 0.0
	pink_coins = G.pink_coins
	pink_coin1_x = G.pink_coin1_x
	pink_coin1_y = G.pink_coin1_y
	pink_coin2_x = G.pink_coin2_x
	pink_coin2_y = G.pink_coin2_y
	pink_coin3_x = G.pink_coin3_x
	pink_coin3_y = G.pink_coin3_y
	pink_coin4_x = G.pink_coin4_x
	pink_coin4_y = G.pink_coin4_y
	pink_coin5_x = G.pink_coin5_x
	pink_coin5_y = G.pink_coin5_y
	pink_coin6_x = G.pink_coin6_x
	pink_coin6_y = G.pink_coin6_y
	pink_coin7_x = G.pink_coin7_x
	pink_coin7_y = G.pink_coin7_y
	pink_coin8_x = G.pink_coin8_x
	pink_coin8_y = G.pink_coin8_y
	pink_coin9_x = G.pink_coin9_x
	pink_coin9_y = G.pink_coin9_y
	pink_coin10_x = G.pink_coin10_x
	pink_coin10_y = G.pink_coin10_y


# from objects/obj_checkpoint/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if (sprite_index == A.spr_flag_bowser or sprite_index == A.spr_SMB3_checkpoint_bowser or sprite_index == A.spr_SMB_checkpoint_bowser or sprite_index == A.spr_NSMBU_checkpoint) and (not GM.audio_is_playing(Scr.scr_snd_getcheckpoint(self))):
		match G.apariencia:
			0.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_SMB_checkpoint_bowser
				sprite_index = A.spr_SMB_checkpoint_ready
				image_speed = 0.22
			1.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_SMB3_checkpoint_bowser
				sprite_index = A.spr_SMB3_checkpoint_ready
				image_speed = 0.22
			2.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_flag_bowser
				match G.jugador:
					0.0:
						sprite_index = A.spr_flag_move
					1.0:
						sprite_index = A.spr_flag_move_luigi
					2.0:
						sprite_index = A.spr_flag_move_toad
					3.0:
						sprite_index = A.spr_flag_move_toadette
			3.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_NSMBU_checkpoint
				sprite_index = A.spr_NSMBU_checkpoint_move
				image_speed = 0.6
		G.checkpoint_x = x
		G.checkpoint_y = y
		G.checkpointroom = GM.room
		if GM.room == A.rm_guardabot_play and G.ms != 0.0:
			G.ms_check = G.ms
			G.ms = 0.0
		_user_1()
		GM.audio_play_sound(Scr.scr_snd_getcheckpoint(self), 0.0, false)
		if G.apariencia == 2.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_spinthump)):
				inst.sprite_index = A.spr_checkpoint_effect
				inst.depth = 9.0
		if sprout != 0.0:
			my_sprite = Scr.scr_constant_get_sprite(self, sprout)
			Scr.scr_sprite_make_object(self, (other.x - 8.0), (other.y + 16.0), my_sprite)
			sprout = 0.0


# from objects/obj_checkpoint/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	if (sprite_index == A.spr_flag_bowser or sprite_index == A.spr_SMB3_checkpoint_bowser or sprite_index == A.spr_SMB_checkpoint_bowser or sprite_index == A.spr_NSMBU_checkpoint) and (not GM.audio_is_playing(Scr.scr_snd_getcheckpoint(self))):
		match G.apariencia:
			0.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_SMB_checkpoint_bowser
				sprite_index = A.spr_SMB_checkpoint_ready
				image_speed = 0.22
			1.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_SMB3_checkpoint_bowser
				sprite_index = A.spr_SMB3_checkpoint_ready
				image_speed = 0.22
			2.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_flag_bowser
				match G.jugador:
					0.0:
						sprite_index = A.spr_flag_move
					1.0:
						sprite_index = A.spr_flag_move_luigi
					2.0:
						sprite_index = A.spr_flag_move_toad
					3.0:
						sprite_index = A.spr_flag_move_toadette
			3.0:
				for inst in GM.with_list(A.obj_checkpoint):
					inst.sprite_index = A.spr_NSMBU_checkpoint
				sprite_index = A.spr_NSMBU_checkpoint_move
				image_speed = 0.6
		G.checkpoint_x = x
		G.checkpoint_y = y
		G.checkpointroom = GM.room
		if GM.room == A.rm_guardabot_play and G.ms != 0.0:
			G.ms_check = G.ms
			G.ms = 0.0
		_user_1()
		GM.audio_play_sound(Scr.scr_snd_getcheckpoint(self), 0.0, false)
		if G.apariencia == 2.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_spinthump)):
				inst.sprite_index = A.spr_checkpoint_effect
				inst.depth = 9.0
		if sprout != 0.0:
			my_sprite = Scr.scr_constant_get_sprite(self, sprout)
			Scr.scr_sprite_make_object(self, (other.x - 8.0), (other.y + 16.0), my_sprite)
			sprout = 0.0


# from objects/obj_checkpoint/Other_4.gml
func _room_start() -> void:
	if GM.room == G.checkpointroom:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_checkpoint
				image_speed = 0.0
				image_index = G.jugador
			1.0:
				sprite_index = A.spr_SMB3_checkpoint
				image_speed = 0.0
				image_index = G.jugador
			2.0:
				match G.jugador:
					0.0:
						sprite_index = A.spr_flag_mario
					1.0:
						sprite_index = A.spr_flag_luigi
					2.0:
						sprite_index = A.spr_flag_toad
					3.0:
						sprite_index = A.spr_flag_toadette
				image_speed = 0.15
			3.0:
				sprite_index = A.spr_NSMBU_checkpoint_mario
				image_speed = 0.5


# from objects/obj_checkpoint/Other_7.gml
func _animation_end() -> void:
	if G.apariencia == 0.0:
		if sprite_index == A.spr_SMB_checkpoint_ready:
			sprite_index = A.spr_SMB_checkpoint
			image_speed = 0.0
			image_index = G.jugador
	elif G.apariencia == 1.0:
		if sprite_index == A.spr_SMB3_checkpoint_ready:
			sprite_index = A.spr_SMB3_checkpoint
			image_speed = 0.0
			image_index = G.jugador
	elif G.apariencia == 2.0:
		match sprite_index:
			A.spr_flag_move:
				sprite_index = A.spr_flag_mario
			A.spr_flag_move_luigi:
				sprite_index = A.spr_flag_luigi
			A.spr_flag_move_toad:
				sprite_index = A.spr_flag_toad
			A.spr_flag_move_toadette:
				sprite_index = A.spr_flag_toadette
	elif G.apariencia == 3.0:
		if sprite_index == A.spr_NSMBU_checkpoint_move:
			sprite_index = A.spr_NSMBU_checkpoint_mario
			image_speed = 0.5


# from objects/obj_checkpoint/Other_10.gml
func _user_0() -> void:
	if GM.room == G.checkpointroom:
		if x == G.checkpoint_x and y == G.checkpoint_y:
			if G.apariencia == 0.0:
				sprite_index = A.spr_SMB_checkpoint
				image_speed = 0.0
				image_index = G.jugador
			elif G.apariencia == 1.0:
				sprite_index = A.spr_SMB3_checkpoint
				image_speed = 0.0
				image_index = G.jugador
			elif G.apariencia == 2.0:
				match G.jugador:
					0.0:
						sprite_index = A.spr_flag_mario
					1.0:
						sprite_index = A.spr_flag_luigi
					2.0:
						sprite_index = A.spr_flag_toad
					3.0:
						sprite_index = A.spr_flag_toadette
			elif G.apariencia == 3.0:
				sprite_index = A.spr_NSMBU_checkpoint_mario
				image_speed = 0.5


# from objects/obj_checkpoint/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(A.obj_checkpoint):
		inst.pink_coins = G.pink_coins
	if G.pink_coin1_x == 0.0:
		G.pink_coin1_x = pink_coin1_x
		G.pink_coin1_y = pink_coin1_y
	if G.pink_coin2_x == 0.0:
		G.pink_coin2_x = pink_coin2_x
		G.pink_coin2_y = pink_coin2_y
	if G.pink_coin3_x == 0.0:
		G.pink_coin3_x = pink_coin3_x
		G.pink_coin3_y = pink_coin3_y
	if G.pink_coin4_x == 0.0:
		G.pink_coin4_x = pink_coin4_x
		G.pink_coin4_y = pink_coin4_y
	if G.pink_coin5_x == 0.0:
		G.pink_coin5_x = pink_coin5_x
		G.pink_coin5_y = pink_coin5_y
	if G.pink_coin6_x == 0.0:
		G.pink_coin6_x = pink_coin6_x
		G.pink_coin6_y = pink_coin6_y
	if G.pink_coin7_x == 0.0:
		G.pink_coin7_x = pink_coin7_x
		G.pink_coin7_y = pink_coin7_y
	if G.pink_coin8_x == 0.0:
		G.pink_coin8_x = pink_coin8_x
		G.pink_coin8_y = pink_coin8_y
	if G.pink_coin9_x == 0.0:
		G.pink_coin9_x = pink_coin9_x
		G.pink_coin9_y = pink_coin9_y
	if G.pink_coin10_x == 0.0:
		G.pink_coin10_x = pink_coin10_x
		G.pink_coin10_y = pink_coin10_y
	if pink_coins == G.pink_coins_total:
		G.pink_coins = 0.0


# from objects/obj_checkpoint/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
