extends "res://objects/obj_deactenemyparent.gd"

var edible: float = 0.0
var isheavy: float = 0.0
var jumping: float = 0.0
var hopcount: float = 0.0  # PORT: 原版 Create 没初始化，Alarm_0 里直接读（GML 会报错）；alarm[0] 只有 Alarm_0 自己设置，实际走不到


# from objects/obj_ninji/Create_0.gml
func _create() -> void:
	# /Ninji
	# How vulnerable is this enemy to various items?
	hardness = 0.0
	# How vulnerable is this enemy to the player?
	stomp = 1.0
	# How vulnerable is this enemy to yoshi?
	edible = 0.0
	# Facing direction
	direct = 1.0
	# Is this enemy heavy?
	isheavy = 0.0
	# Whether the object is swimming
	swimming = 0.0  # PORT: 原版写 false；父类里 swimming 是 0/1 数值，统一成 0.0
	# Whether the object is jumping
	jumping = 0.0
	# Do not animate
	image_speed = 0.125
	# Start jumping
	alarm[1] = 15.0 + GM.random(GM.gm_round(30.0))
	# Set sprites
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB_ninji
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_ninji
	elif G.apariencia == 2.0:
		sprite_index = A.spr_ninji


# from objects/obj_ninji/Step_0.gml
func _step() -> void:
	# /Ninji logic
	# Inherit event
	super._step()
	# Animate
	if gravity > 0.0:
		# If jumping and moving down, wait until floor is reached
		if (vspeed > 0.0) and (jumping == 1.0):
			jumping = 2.0
	else:
		if jumping == 2.0:
			# Animate
			image_speed = 0.125
			# End jump
			jumping = 0.0
			# Jump again
			alarm[1] = 15.0 + GM.random(GM.gm_round(30.0))
	# Look at Mario
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x > x:
			direct = 1.0
		else:
			direct = -1.0
	if jumping == 0.0:
		image_index = 0.0


# from objects/obj_ninji/Alarm_0.gml
func _alarm_0() -> void:
	# /Hop
	# Move up
	y -= 1.0
	# Hop higher if he hopped more than twice
	if hopcount > 2.0:
		vspeed = -5.0
		hopcount = 0.0
	# Otherwise, hop low
	else:
		vspeed = -3.0
		hopcount += 1.0
	# Jump animation
	if G.apariencia != 3.0:
		image_index = 1.0
	else:
		sprite_index = A.spr_NSMBU_ninji_jump2  # PORT: 原工程缺这个 sprite，用 spr_NSMBU_ninji_jump 复制补上（用户确认同图，tools/gmlib.py PORT_EXTRA_SPRITES）
	# Hop again
	alarm[0] = 100.0


# from objects/obj_ninji/Alarm_1.gml
func _alarm_1() -> void:
	# /Start jumping
	# If the ninji is not jumping
	if jumping == 0.0:
		# If the player does exists
		if GM.instance_exists(A.obj_mario):
			# If the player is nearby
			if (GM.instance_find(A.obj_mario, 0).x > x - 32.0) and (GM.instance_find(A.obj_mario, 0).x < x + 32.0):
				if not (swimming > 0.5):
					vspeed = -4.0
				else:
					vspeed = -2.0
			else:
				if not (swimming > 0.5):
					vspeed = -2.0
				else:
					vspeed = -1.0
		# Otherwise, if it does not exist
		else:
			if not (swimming > 0.5):
				vspeed = -2.0
			else:
				vspeed = -1.0
		# Boost jump
		y -= 1.0
		# Jump
		jumping = 1.0
		# Stop animation
		image_speed = 0.0
		image_index = 1.0


# from objects/obj_ninji/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
