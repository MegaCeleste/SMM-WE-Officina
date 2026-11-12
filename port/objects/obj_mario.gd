extends GMObject

var pmeter = null
var jumping = null  # 原版 obj_mario 自己不用，obj_spring/Collision_obj_mario.gml:227 给它赋值（第 5 批补）
var canjump: float = 0.0
var invincible: float = 0.0
var disablecontrols: float = 0.0
var skidnow = null
var direct = null
var state = null
var jumpnow: float = 0.0
var hitpoint: float = 0.0
var isduck: float = 0.0
var isduckhold: float = 0.0
var holding: float = 0.0
var stompstyle: float = 0.0
var helice_fly: float = 0.0
var inclown: float = 0.0
var isup: float = 0.0
var isuphold: float = 0.0
var gp_limit: float = 0.0
var isflashing: float = 0.0
var blend_star = null
var link_transform: float = 0.0
var dash_atack: float = 0.0
var dash_cont: float = 0.0
var down_atack: float = 0.0
var down_cont: float = 0.0
var arrow: float = 0.0
var arrow_ready = null
var direct_turn: float = 0.0
var yview = null
var camera_jump: float = 0.0
var x_speed: float = 0.0
var boostme: float = 0.0
var flashAlpha: float = 0.0
var speed_cinta: float = 0.0
var helice_fly_temp: float = 0.0
var jump_loaded: float = 0.0
var airspin: float = 0.0
var airspin_count: float = 0.0
var groundpount: float = 0.0
var jump_type = null
var platform_m: float = 0.0
var canhang: float = 0.0
var canturn: float = 0.0
var enable_gravity: float = 0.0
var disablegrav: float = 0.0
var ygrav: float = 0.0
var mario_index: String = ""
var keys: float = 0.0
var shake: float = 0.0
var stuntime: float = 0.0
var snow: float = 0.0
var turning: float = 0.0
var fly_cap: float = 0.0
var modo_vuelo: float = 0.0
var canfly: float = 0.0
var fly_high: float = 0.0
var helmet: float = 0.0
var s_hen: float = 0.0
var isswim: float = 0.0
var new_swim: float = 0.0
var isswimhold: float = 0.0
var netsmack: float = 0.0
var iamkicking: float = 0.0
var isslip: float = 0.0
var isfloating: float = 0.0
var floatnow: float = 0.0
var powerupfly: float = 0.0
var walljump: float = 0.0
var squirrelpropel: float = 0.0
var arcon_slide: float = 0.0
var doublejump: float = 0.0
var squirrel_fly: float = 0.0
var firing: float = 0.0
var caped: float = 0.0
var wiggle: float = 0.0
var swimtype: float = 0.0
var noisy: float = 0.0
var statedelay: float = 0.0
var can_break_block: float = 0.0
var frog_jump: float = 0.0
var flag = null
var conveyor_first_col = null
var disable_doublejump: float = 0.0
var hspeedmax = null
var pow = null
var pswitch = null
var conveyor = null
var player_on_conveyor = null
var solid_col = null
var solid_col_2 = null
var imdead = null
var col_enemigos = null
var enemigo = null
var hold = null
var nube = null
var suelo_nieve = null
var start_nieve = null
var goal_nieve = null
var c_nube = null
var c_enemy = null
var disablecontrol = null
var jumpnow_temp = null
var sprite_cond = null
var triple_jump = null
var triple_count = null


# from objects/obj_mario/Create_0.gml
func _create() -> void:
	# / @description It's a me, Mario!
	sprite_index = Scr.scr_marioidle(self)
	pmeter = 0.0
	canjump = 1.0
	match G.powerup:
		0.0:
			mask_index = A.spr_smallmask
		-85.0:
			mask_index = A.spr_smallmask
		-77.0:
			mask_index = A.spr_megamask
		-82.0:
			mask_index = A.spr_smallmask
		_:
			mask_index = A.spr_bigmask
	if G.powerup == 3.0 and (not GM.instance_exists(A.obj_cap_mario)):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_cap_mario)):
			inst.set("cap_invisible", 0.0)
			inst.visible = true
	if G.powerup == -82.0 and (not GM.instance_exists(A.obj_mario_pballon)):
		for inst in GM.with_list(GM.instance_create(x, (y + 20.0), A.obj_mario_pballon)):
			inst.visible = true
	var _lm = GM.instance_find(A.obj_levelmanager, 0)
	if GM.instance_exists(A.obj_levelmanager) and _lm.get("fallow_mario") == 0.0 and (_lm.get("camlock") == 0.0 or (_lm.get("camlock") == 1.0 and _lm.y < 216.0)):
		for inst in GM.with_list(A.obj_levelmanager):
			inst.y = (y + 32.0)
	link_transform = 0.0
	dash_atack = 0.0
	dash_cont = 0.0
	down_atack = 0.0
	down_cont = 0.0
	arrow = 0.0
	arrow_ready = 0.0
	direct_turn = 1.0
	yview = (y + 32.0)
	camera_jump = 0.0
	x_speed = 0.0
	boostme = 0.0
	blend_star = GM.c_white
	flashAlpha = 1.0
	speed_cinta = 0.0
	helice_fly = 0.0
	helice_fly_temp = 0.0
	jump_loaded = 0.0
	airspin = 0.0
	airspin_count = 0.0
	groundpount = 0.0
	gp_limit = 0.0
	jump_type = 0.0
	platform_m = 0.0
	inclown = 0.0
	canhang = 0.0
	canturn = 0.0
	enable_gravity = 1.0
	disablegrav = 0.0
	ygrav = 1.0
	mario_index = "walk"
	keys = 0.0
	shake = 0.0
	stuntime = 0.0
	snow = 0.0
	# Mario's current state
	# 0: Stand, 1: Walk, 2: Jump, 3: Climb 4: Wall Climb/Jump
	state = 0.0
	# Mario's direction
	# -1: Left, 1: Right
	direct = 1.0
	# Whether Mario is holding something
	# 0: Nothing, 1: Overhead, 2: On Front 3: Can't Hold Stuff
	holding = 0.0
	turning = 0.0
	fly_cap = 0.0
	modo_vuelo = 0.0
	canfly = 0.0
	fly_high = 3.0
	helmet = 0.0
	# Variable jump state
	# 0: Can Jump, 1: Variable Jump, 2: No Variable Jump
	jumpnow = 0.0
	s_hen = 0.0
	# Is Mario skidding?
	skidnow = 0.0
	# Is Mario swimming?
	isswim = 0.0
	new_swim = 0.0
	isswimhold = 0.0
	# Is Mario ducking?
	isduck = 0.0
	isduckhold = 0.0
	isup = 0.0
	isuphold = 0.0
	# Is Mario invincible?
	# 0: Normal, 1: Invincible, -1: Phase through
	invincible = 0.0
	# Is Mario smacking a net?
	netsmack = 0.0
	# Is Mario kicking something?
	iamkicking = 0.0
	# Is Mario spin jumping?
	stompstyle = 0.0
	# Is Mario on a slippery surface?
	isslip = 0.0
	# Is Mario's controls disabled?
	disablecontrols = 0.0
	# Is carrot/bee Mario floating?
	isfloating = 0.0
	# Is the float sound effect playing?
	floatnow = 0.0
	# How much longer can bee/crown Mario fly/float?
	powerupfly = 0.0
	# Did Mario wall jump?
	walljump = 0.0
	# Did squirrel Mario propel upwards yet?
	squirrelpropel = 0.0
	arcon_slide = 0.0
	# Did Mario double jump?
	doublejump = 0.0
	squirrel_fly = 0.0
	# Is Mario firing a projectile?
	firing = 0.0
	caped = 0.0
	# Is leaf/tanooki Mario wiggling his tail?
	wiggle = 0.0
	# What direction is frog/penguin Mario swimming in?
	swimtype = 0.0
	noisy = 0.0
	# Is Mario flashing?
	isflashing = 0.0
	# How many consecutive stomps has Mario made?
	hitpoint = 0.0
	# State delay variable
	statedelay = 0.0
	# Can Mario break a block?
	can_break_block = 0.0
	frog_jump = 0.0
	flag = 0.0
	conveyor_first_col = false
	disable_doublejump = 0.0
	# Handles Mario's skid smoke
	alarm[5] = 8.0
	# Handles Mario's underwater bubbles
	alarm[9] = 24.0 + GM.random(96.0)


# from objects/obj_mario/Destroy_0.gml
func _destroy() -> void:
	_user_14()
	if GM.instance_exists(A.obj_shake_mario):
		for inst in GM.with_list(A.obj_shake_mario):
			inst.instance_destroy()


# from objects/obj_mario/Step_0.gml
func _step() -> void:
	# / @description Handles Mario's physics and movements
	if G.pp == 0.0:
		var pblock = collision_rectangle((bbox_right - 3.0), (bbox_top + 3.0), (bbox_left + 3.0), (bbox_bottom - 3.0), A.obj_enabledsolid, true, false)
		if pblock != null:
			speed = 0.0
			gravity = 0.0
			state = 0.0
			isduck = 1.0
			jumpnow = 0.0
			canjump = 0.0
		else:
			canjump = 1.0
		if (G.modo_noche == 1.0 and G.bg_level == "snow") or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_ice, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_icecoin, false, false) != null:
			snow = 1.0
		else:
			snow = 0.0
		if (collision_rectangle(bbox_left, (bbox_bottom - 5.0), bbox_right, (bbox_bottom + 5.0), A.obj_platform_parent, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 5.0), bbox_right, (bbox_bottom + 5.0), A.obj_block_pow_hold, false, false) != null) and state < 2.0:
			platform_m = 1.0
		else:
			platform_m = 0.0
		if boostme > 0.0:
			boostme -= 1.0
			if absf(hspeed) < hspeedmax:
				boostme = 0.0
		if vspeed >= 0.0:
			var solidtop = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
			var solidphy = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
			var b_drybones = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_lava_water_drybones, false, false)
			if solidtop != null and bbox_bottom < (solidtop.yprevious + 5.0) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (solidtop.y - 1.0), A.obj_solid, true, false) == null):
				if sprite_index == Scr.scr_mario_cap_fly_decender(self) and image_index == 2.0:
					_user_8()
				if collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_rockparent, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_blockparent, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_block_pow_hold, false, false) != null:
					if jumpnow != 0.0 and can_break_block == 0.0 and vspeed > 0.0:
						can_break_block = 1.0
					if can_break_block == 2.0:
						can_break_block = 0.0
				elif can_break_block == 2.0:
					can_break_block = 0.0
				y = (solidtop.y - 32.0)
				vspeed = 0.0
				gravity = 0.0
				_user_15()
			if solidphy != null and bbox_bottom < (solidphy.yprevious + 5.0) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (solidphy.y - 1.0), A.obj_solid, true, false) == null):
				if sprite_index == Scr.scr_mario_cap_fly_decender(self) and image_index == 2.0:
					_user_8()
				y = (solidphy.y - 32.0)
				vspeed = 0.0
				gravity = 0.0
				_user_15()
			if b_drybones != null and bbox_bottom < (b_drybones.yprevious + 5.0) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (b_drybones.y - 1.0), A.obj_solid, true, false) == null) and (GM.instance_exists(A.obj_kuribo_drybones) or (G.powerup == -29.0 and GM.instance_find(A.obj_mario, 0).pmeter > 5.0 and GM.instance_find(A.obj_mario, 0).holding == 2.0)):
				y = (b_drybones.y - 32.0)
				vspeed = 0.0
				gravity = 0.0
				_user_15()
			var enemigos_solid = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_enemyparent, false, false)
			if enemigos_solid != null and ((G.powerup == -80.0) and ((bbox_bottom < (enemigos_solid.yprevious + 5.0)) and ((enemigos_solid.get("stomp") != 1.0) and ((enemigos_solid.get("stomp") != 2.0) and (enemigos_solid.get("stomp") != 5.0))))):
				y = ceilf(((enemigos_solid.bbox_top - 32.0) - enemigos_solid.vspeed))
				vspeed = 0.0
				gravity = 0.0
				jumpnow = 0.0
				hitpoint = 0.0
		if stuntime > 0.0:
			stuntime -= 1.0
			if stuntime == 0.0:
				shake = 0.0
				disablecontrols = 0.0
				if GM.instance_exists(A.obj_shake_mario):
					GM.instance_destroy(A.obj_shake_mario)
		if isswim == 0.0:
			match int(state):
				3:
					_user_4()
				4:
					_user_5()
				_:
					_user_2()
		else:
			match int(state):
				3:
					_user_4()
				_:
					_user_3()
		if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, true, false) != null:
			if hspeed > 0.0:
				hspeed = 0.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_solid, false, false) == null) and inclown != 2.0:
				x -= 1.0
			if collision_rectangle((bbox_left + 4.0), (bbox_top + 4.0), (bbox_right + 1.0), bbox_bottom, A.obj_pinchos, false, false) != null:
				_user_0()
		elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) != null:
			if hspeed < 0.0:
				hspeed = 0.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_solid, false, false) == null) and inclown != 2.0:
				x += 1.0
			if collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), (bbox_right - 4.0), bbox_bottom, A.obj_pinchos, false, false) != null:
				_user_0()
		if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null:
			if hspeed > 0.0:
				hspeed = 0.0
			if (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null) and inclown != 2.0:
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_physicssolid, false, false) == null):
					x -= 1.0
			if collision_rectangle((bbox_left + 4.0), (bbox_top + 4.0), (bbox_right + 1.0), bbox_bottom, A.obj_muncher, false, false) != null:
				_user_0()
		elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null:
			if hspeed < 0.0:
				hspeed = 0.0
			if (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null) and inclown != 2.0:
				while collision_rectangle(bbox_left, (bbox_top + 4.0), (bbox_left + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_physicssolid, false, false) == null):
					x += 1.0
			if collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), (bbox_right - 4.0), bbox_bottom, A.obj_muncher, false, false) != null:
				_user_0()
		if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null:
			if hspeed > 0.0:
				hspeed = 0.0
			if (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null) and inclown != 2.0:
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_bullebill_base, false, false) == null):
					x -= 1.0
		elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null:
			if hspeed < 0.0:
				hspeed = 0.0
			if (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) == null) and inclown != 2.0:
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_solidphy, false, false) == null):
					x += 1.0
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, true, false)
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, true, false)
		if col_one_right != null:
			if hspeed < 0.0:
				hspeed = 0.0
				var _o1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_right):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o1
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_onewaygate_right, false, false) == null):
				x += 1.0
		if col_one_left != null:
			if hspeed > 0.0:
				hspeed = 0.0
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_left):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_left, true, false) != null and (collision_point(x, (bbox_top + 4.0), A.obj_onewaygate_left, false, false) == null):
				x -= 1.0
		pow = collision_rectangle((bbox_left + 1.0), (bbox_top - 2.0), (bbox_right - 1.0), bbox_top, A.obj_block_pow_hold, true, false)
		if vspeed < 0.0 and pow != null and pow.get("held") == 0.0 and pow.get("inmune") == 0.0 and (pow.y + 8.0) < bbox_top:
			vspeed = 0.0
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(pow):
				inst.set("explode", 1.0)
				inst.event_user(6)
			GM.other = _o3
		pswitch = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_pswitch, true, false)
		if pswitch != null and pswitch.get("inmune") == 0.0 and pswitch.get("inup") == 1.0:
			var _o4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(pswitch):
				inst.event_user(6)
			GM.other = _o4
		var one_2 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false)
		if vspeed < 0.0 and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or (pswitch != null and pswitch.get("held") == 0.0 and (pswitch.y + 16.0) < bbox_top) or (one_2 != null and (bbox_top + 5.0) >= one_2.bbox_bottom)):
			var block_col = collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top + 4.0, A.obj_blockparent, false, false)
			var rock_parent = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_rockparent, true, false)
			if state > 1.0 and canjump == 1.0:
				while collision_rectangle(bbox_left, (bbox_top), bbox_right, (bbox_top), A.obj_solid, true, false) != null:
					y += 1.0
			vspeed = 0.0
			if helmet == 0.0 and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_bottom - 2.0), A.obj_pinchos, false, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_bottom - 2.0), A.obj_muncher, false, false) != null):
				_user_0()
			var col_one_bottom = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o5: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o5
			elif not GM.audio_is_playing(Scr.scr_snd_bump(self)):
				GM.audio_stop_sound(Scr.scr_jump(self))
				GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
			if GM.instance_exists(A.obj_helmet_spiny) and rock_parent != null and rock_parent.vspeed == 0.0:
				for inst in GM.with_list(rock_parent):
					inst.alarm[0] = 1.0
			if (GM.instance_exists(A.obj_helmet_spiny) or G.powerup == -77.0) and block_col != null and block_col.vspeed == 0.0 and block_col.object_index != A.obj_onoffblock and block_col.object_index != A.obj_noteblock and block_col.object_index != A.obj_musicblock and block_col.object_index != A.obj_noteblock_s:
				for inst in GM.with_list(block_col):
					inst.alarm[2] = 1.0
			if block_col != null and block_col.vspeed == 0.0 and block_col.object_index == A.obj_flipblock and G.apariencia != 2.0 and ((G.powerup != 0.0 and G.powerup != -85.0) or ((G.powerup == 0.0 or G.powerup == -85.0) and GM.instance_exists(A.obj_helmet))):
				for inst in GM.with_list(block_col):
					inst.alarm[2] = 1.0
			elif block_col != null and block_col.object_index == A.obj_onoffblock and block_col.get("ready_v") == 0.0:
				var _o6: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_col):
					inst.event_user(1)
				GM.other = _o6
			elif block_col != null and block_col.object_index == A.obj_block_gold and block_col.get("ready_v") == 0.0:
				var _o7: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block_col):
					if self.helmet == 0.0:
						inst.set("brick_helmet", GM.instance_create(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 8.0), A.obj_brickhelmet))
						inst.get("brick_helmet").set("limit_coins", (inst.get("limit_coins") + 100.0))
						for inst2 in GM.with_list(A.obj_mario):
							inst2.helmet = 1.0
						inst.instance_destroy()
					else:
						inst.set("ready_v", 1.0)
						inst.vspeed = -2.0
						inst.alarm[0] = 4.0
						inst.event_user(0)
				GM.other = _o7
			elif block_col != null and (G.powerup != -77.0 or block_col.object_index == A.obj_noteblock or block_col.object_index == A.obj_musicblock or block_col.object_index == A.obj_noteblock_s):
				if block_col.get("ready_v") == 0.0:
					var _o8: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block_col):
						if inst.object_index != A.obj_noteblock and inst.object_index != A.obj_musicblock:
							inst.set("expand", 1.0)
						inst.set("ready_v", 1.0)
						inst.vspeed = -2.0
						if inst.object_index == A.obj_noteblock or inst.object_index == A.obj_musicblock or inst.object_index == A.obj_noteblock_s:
							inst.alarm[0] = 7.0
						else:
							inst.alarm[0] = 4.0
						inst.event_user(0)
					GM.other = _o8
			if noisy == 0.0 and state < 3.0 and vspeed < 0.0:
				jumpnow = 2.0
				GM.audio_stop_sound(Scr.scr_snd_bump(self))
				GM.audio_stop_sound(Scr.scr_jump(self))
				GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
		if state < 3.0:
			if state != 2.0 and disablecontrols == 0.0:
				if GM.keyboard_check(G.abajo) and (holding == 0.0 or holding == 3.0) and noisy == 0.0 and down_atack == 0.0 and dash_atack == 0.0 and arrow == 0.0:
					isduck = 1.0
					if G.powerup == -85.0 and G.yoshi == 0.0 and (not GM.instance_exists(A.obj_shield_right)) and (not GM.instance_exists(A.obj_shield_left)):
						GM.audio_stop_sound(A.snd_SMB_link_guard)
						GM.audio_play_sound(A.snd_SMB_link_guard, 0.0, false)
						if direct == 1.0:
							GM.instance_create(x, y, A.obj_shield_right)
						else:
							GM.instance_create(x, y, A.obj_shield_left)
				elif GM.keyboard_check(G.abajo) and holding == 2.0 and noisy == 0.0 and G.apariencia == 2.0:
					isduck = 1.0
					isduckhold = 1.0
				elif GM.keyboard_check(G.abajo) and ((holding == 1.0) and ((noisy == 0.0) and (G.powerup == -80.0))):
					isduck = 1.0
					isduckhold = 1.0
				elif GM.keyboard_check(G.abajo) and (((holding == 0.0) or (holding == 3.0)) and ((noisy == 0.0) and ((G.apariencia == 2.0) or (G.powerup == -80.0)))):
					isduck = 1.0
				elif (not GM.keyboard_check(G.abajo)) and (collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 16.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null) and G.powerup != 0.0 and G.powerup != -85.0 and isduck == 1.0:
					isduck = 1.0
				else:
					isduck = 0.0
					isduckhold = 0.0
				if GM.keyboard_check(G.arriba) and holding < 3.0 and noisy == 0.0 and G.apariencia == 2.0:
					isup = 1.0
					if holding == 2.0:
						isuphold = 1.0
				elif not GM.keyboard_check(G.arriba):
					isup = 0.0
					isuphold = 0.0
			elif state == 2.0 and disablecontrols == 0.0:
				if (not GM.keyboard_check(G.abajo)) and isduck == 1.0 and (collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 12.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 16.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) == null) and vspeed > 0.0:
					isduck = 0.0
					isduckhold = 0.0
				elif isduck == 1.0 and holding == 2.0 and noisy == 0.0 and G.apariencia == 2.0:
					isduckhold = 1.0
			if GM.keyboard_check_pressed(G.lanzar_agarrar) and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("barrier") == 0.0:
				alarm[10] = 1.0
		else:
			isduck = 0.0
		if isswim == 0.0 and (G.bg_level == "underwater" or (G.bg_level == "castle" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and (y + 18.0) >= GM.instance_find(A.obj_lava_water, 0).y and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach"))):
			dash_atack = 0.0
			dash_cont = 0.0
			down_atack = 0.0
			down_cont = 0.0
			if holding == 2.0 and G.apariencia == 2.0:
				isswimhold = 1.0
			isswim = 1.0
			if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
			if state > 2.0:
				state = 2.0
		if isswim == 0.0 and (G.bg_level == "underwater" or (G.bg_level == "castle" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and G.bg_level == "forest" and G.modo_noche == 0.0 and (y + 18.0) >= GM.instance_find(A.obj_lava_water, 0).y) or (GM.instance_exists(A.obj_lava_water) and G.bg_level == "beach" and (y + 18.0) >= GM.instance_find(A.obj_lava_water, 0).y)):
			if holding == 2.0 and G.apariencia == 2.0:
				isswimhold = 1.0
			isswim = 1.0
			if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.apariencia != 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
			if state > 2.0:
				state = 2.0
		match G.bg_level:
			"underwater":
				var _lm1 = GM.instance_find(A.obj_levelmanager, 0)
				if GM.instance_exists(A.obj_levelmanager) and _lm1.get("camlock") == 1.0:
					if y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0):
						y = (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0)
				elif y < -16.0:
					y = -16.0
			"castle":
				var _lm2 = GM.instance_find(A.obj_levelmanager, 0)
				if G.modo_noche == 1.0 and GM.instance_exists(A.obj_levelmanager) and _lm2.get("camlock") == 1.0:
					if y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0):
						y = (GM.camera_get_view_y(GM.view_get_camera(0)) - 16.0)
				elif y < -16.0:
					y = -16.0
			_:
				var _lm3 = GM.instance_find(A.obj_levelmanager, 0)
				if GM.instance_exists(A.obj_mario_pballon) and GM.instance_exists(A.obj_levelmanager) and _lm3.get("camlock") == 1.0:
					if GM.instance_find(A.obj_mario_pballon, 0).y < GM.camera_get_view_y(GM.view_get_camera(0)):
						for inst in GM.with_list(A.obj_mario_pballon):
							inst.y = GM.camera_get_view_y(GM.view_get_camera(0))
					# break (end of switch)
		if y < -96.0:
			y = -96.0
		elif ((bbox_top - 32.0) > GM.room_height) and (G.bg_level != "castle"):
			if (G.powerup == 24.0) and (doublejump != -1.0):
				doublejump = -1.0
				vspeed = -4.5
				y -= 8.0
				jumpnow = 1.0
				GM.audio_play_sound(A.snd_jump, 0.0, false)
				GM.audio_play_sound(A.snd_stomp, 0.0, false)
			else:
				for inst in GM.with_list(GM.instance_create(x, (GM.room_height - 32.0), A.obj_deadmario)):
					inst.visible = false
				instance_destroy()
		elif (GM.instance_exists(A.obj_lava_water) and (((G.bg_level == "castle") or ((G.bg_level == "forest") and (G.modo_noche == 1.0))) and (((y + 32.0) >= GM.instance_find(A.obj_lava_water, 0).y) and (not GM.instance_exists(A.obj_kuribo_drybones))))) or (GM.instance_exists(A.obj_lava_water) and (((G.bg_level == "castle") or ((G.bg_level == "forest") and (G.modo_noche == 1.0))) and (((y + 32.0) >= (GM.instance_find(A.obj_lava_water, 0).y + 12.0)) and GM.instance_exists(A.obj_kuribo_drybones)))):
			GM.instance_create(x, y, A.obj_deadmario)
			instance_destroy()
		elif GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 1.0)) and (((y + 32.0) >= GM.instance_find(A.obj_lava_water, 0).y) and (not GM.instance_exists(A.obj_kuribo_drybones))) or (GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 1.0)) and (((y + 32.0) >= (GM.instance_find(A.obj_lava_water, 0).y + 12.0)) and GM.instance_exists(A.obj_kuribo_drybones))):
			GM.instance_create(x, y, A.obj_deadmario)
			instance_destroy()
		if ((G.bg_level == "underwater") and (isswim == 0.0)) or (((G.bg_level == "castle") and ((G.modo_noche == 1.0) and (isswim == 0.0))) or (GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "forest") and ((G.modo_noche == 0.0) and (((y + 18.0) >= GM.instance_find(A.obj_lava_water, 0).y) and (isswim == 0.0)))))):
			if (holding == 2.0) and (G.apariencia == 2.0):
				isswimhold = 1.0
			isswim = 1.0
			powerupfly = 0.0
			walljump = 0.0
			squirrelpropel = 0.0
			doublejump = 0.0
			if collision_point(x, (y - 17.0), A.obj_lava_water, false, false) != null and (collision_point(x, (y - 16.0), A.obj_lava_water, false, false) == null):
				vspeed = 0.0
				if G.apariencia != 0.0:
					for inst in GM.with_list(GM.instance_create(x, (y + 7.0), A.obj_smoke)):
						if G.apariencia == 1.0:
							inst.sprite_index = A.spr_SMB3_splash
						elif G.apariencia == 2.0:
							inst.sprite_index = A.spr_splash
						inst.depth = -10.0
			isfloating = 0.0
			if floatnow == 1.0:
				GM.audio_stop_sound(A.snd_spin)
				floatnow = 0.0
			if state > 2.0:
				state = 2.0
		if GM.instance_exists(A.obj_cinta) and GM.instance_exists(A.obj_mario):
			conveyor = null  # GML: false (== no instance)
			player_on_conveyor = collision_rectangle((bbox_left - 2.0), (bbox_top + 10.0), (bbox_right + 2.0), (bbox_bottom + 10.0), A.obj_cinta_parent, false, false)
			solid_col = (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom - 1.0), A.obj_solidtop, false, false))
			solid_col_2 = (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false))
			if player_on_conveyor != null:
				conveyor_first_col = true
			elif (solid_col != null) or (solid_col_2 != null):
				conveyor_first_col = false
			if conveyor_first_col == true:
				conveyor = collision_rectangle((bbox_left - 2.0), GM.instance_find(A.obj_cinta_parent, 0).y - 48.0, (bbox_right + 2.0), GM.instance_find(A.obj_cinta_parent, 0).y, A.obj_cinta_parent, false, false)
			elif conveyor_first_col == false:
				conveyor = null  # GML: false
			if conveyor != null and GM.instance_find(A.obj_mario, 0).y > GM.instance_find(A.obj_cinta_parent, 0).y:
				conveyor = null  # GML: false
			if conveyor != null and (conveyor.image_speed != 0.0):
				if conveyor.image_speed > 0.0:
					if (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_pinchos, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_muncher, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_cannon, true, false) == null) and ((collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 2.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) == null))))):
						x -= conveyor.image_speed
				elif conveyor.image_speed < 0.0:
					if (collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_pinchos, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_muncher, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_cannon, true, false) == null) and ((collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) == null) and (collision_rectangle((bbox_left - 2.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) == null))))):
						x -= conveyor.image_speed


# from objects/obj_mario/Step_2.gml
func _step_end() -> void:
	var spd_i  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Handles Mario's sprites
	if G.pp == 0.0:
		if GM.instance_exists(A.obj_levelmanager):
			pmeter = GM.instance_find(A.obj_levelmanager, 0).get("pmeter")
		if frog_jump != 0.0 and state != 1.0:
			frog_jump = 0.0
		if G.powerup == -29.0 and isswim == 1.0:
			isduck = 0.0
		if link_transform == 1.0:
			sprite_index = A.spr_SMB_link_transform
			image_speed = 0.15
			return
		if isduck == 0.0:
			match G.powerup:
				0.0:
					if GM.instance_exists(A.obj_yoshi_blue):
						mask_index = A.spr_bigmask
					else:
						mask_index = A.spr_smallmask
				-85.0:
					mask_index = A.spr_smallmask
				-77.0:
					mask_index = A.spr_megamask
				-82.0:
					mask_index = A.spr_smallmask
				_:
					mask_index = A.spr_bigmask
			if G.powerup == 2.0 or G.powerup == -50.0 or G.powerup == -46.0:
				if firing > 0.0:
					firing -= 1.0
			else:
				firing = 0.0
			if G.powerup == -39.0:
				if state == 2.0:
					if wiggle > 1.0:
						wiggle -= 1.0
					if wiggle > 12.0:
						image_index = 3.0
					elif wiggle > 8.0:
						image_index = 2.0
					elif wiggle > 4.0:
						image_index = 1.0
					elif wiggle > 1.0:
						image_index = 2.0
					elif wiggle == 1.0:
						image_index = 1.0
				else:
					wiggle = 0.0
			else:
				wiggle = 0.0
			if holding == 0.0:
				# Skid when moving and facing in opposite directions
				if state < 2.0 and pmeter > 5.0 and G.powerup != -29.0 and ((direct == 1.0 and hspeed < 0.0 and GM.keyboard_check(G.derecha)) or (direct == -1.0 and hspeed > 0.0 and GM.keyboard_check(G.izquierda))):
					sprite_index = Scr.scr_marioskid(self)
					image_speed = 0.0
					image_index = 0.0
					if skidnow == 0.0:
						skidnow = 1.0
						if G.apariencia != 0.0:
							GM.audio_play_sound(Scr.scr_snd_skid(self), 1.0, true)
				elif state == 0.0:
					if caped > 0.0:
						if GM.instance_exists(A.obj_mario_transform2):
							image_speed = 0.0
						else:
							image_speed = 0.3
						sprite_index = Scr.scr_mariowarp(self)
					elif firing > 0.0:
						image_speed = 0.0
						if firing < 6.0 and firing > 3.0:
							image_index = 1.0
						else:
							image_index = 0.0
							sprite_index = Scr.scr_marioshoot(self)
					elif GM.instance_exists(A.obj_mario_transform2):
						if G.powerup != -29.0 and skidnow == 1.0:
							sprite_index = Scr.scr_marioskid(self)
							GM.audio_stop_sound(Scr.scr_snd_skid(self))
						elif GM.instance_find(A.obj_mario_transform2, 0).get("m_hspeed") != 0.0:
							sprite_index = Scr.scr_mariowalk(self)
						else:
							sprite_index = Scr.scr_marioidle(self)
					elif arrow > 0.0:
						sprite_index = A.spr_SMB_link_arrow_idle
						image_speed = 0.0
						image_index = (arrow - 1.0)
					elif G.powerup == -29.0 and isswim == 1.0:
						sprite_index = Scr.scr_marioswim_idle(self)
						image_speed = 0.15
					else:
						sprite_index = Scr.scr_marioidle(self)
						image_speed = 0.0
						if isup == 1.0:
							sprite_index = Scr.scr_marioup(self)
				elif state == 1.0:
					if caped > 0.0:
						if GM.instance_exists(A.obj_mario_transform2):
							image_speed = 0.0
						else:
							image_speed = 0.3
						sprite_index = Scr.scr_mariowarp(self)
					elif firing > 0.0:
						image_speed = 0.0
						if firing < 6.0 and firing > 3.0:
							image_index = 1.0
						else:
							image_index = 0.0
							sprite_index = Scr.scr_marioshoot(self)
					elif GM.instance_exists(A.obj_mario_transform2):
						if skidnow == 1.0:
							sprite_index = Scr.scr_marioskid(self)
							image_speed = 0.0
							image_index = 0.0
							GM.audio_stop_sound(Scr.scr_snd_skid(self))
						else:
							image_speed = 0.0
							if pmeter < 6.0:
								sprite_index = Scr.scr_mariowalk(self)
							elif G.apariencia == 0.0:
								sprite_index = Scr.scr_mariowalk(self)
							else:
								sprite_index = Scr.scr_mariorun(self)
					elif G.powerup == -29.0:
						if isswim == 1.0:
							sprite_index = Scr.scr_marioswim(self)
							if G.key_br == 1.0:
								image_speed = (0.1 + (0.1 * G.key_br))
							else:
								image_speed = (0.1 + (0.1 * float(GM.keyboard_check(G.lanzar_agarrar))))
						else:
							if frog_jump == 0.0:
								GM.audio_stop_sound(A.snd_SMB_smalljump)
								GM.audio_play_sound(A.snd_SMB_smalljump, 0.0, false)
								frog_jump = 1.0
							if frog_jump == 1.0 and image_index >= 3.75:
								frog_jump = 0.0
							sprite_index = Scr.scr_mariowalk(self)
							image_speed = absf((hspeed / 10.0))
					elif arrow > 0.0:
						sprite_index = Scr.scr_link_arrow_walk(self, arrow)
						image_speed = 0.15
					else:
						if absf((hspeed / 5.0)) > 0.3:
							spd_i = 0.3
						else:
							spd_i = absf((hspeed / 5.0))
						image_speed = spd_i
						if pmeter < 6.0 or G.apariencia == 0.0:
							sprite_index = Scr.scr_mariowalk(self)
						else:
							sprite_index = Scr.scr_mariorun(self)
				elif state == 2.0:
					if isswim == 1.0:
						if caped > 0.0:
							if GM.instance_exists(A.obj_mario_transform2):
								image_speed = 0.0
							else:
								image_speed = 0.3
							sprite_index = Scr.scr_mariowarp(self)
						elif firing > 0.0:
							image_speed = 0.0
							if firing < 6.0 and firing > 3.0:
								image_index = 1.0
							else:
								image_index = 0.0
								sprite_index = Scr.scr_marioshoot(self)
						elif G.powerup == -29.0:
							if swimtype == 0.0:
								if hspeed == 0.0:
									sprite_index = Scr.scr_marioswim_idle(self)
									image_speed = 0.15
								else:
									sprite_index = Scr.scr_marioswim(self)
									if G.key_br == 1.0:
										image_speed = (0.1 + (0.1 * G.key_br))
									else:
										image_speed = (0.1 + (0.1 * float(GM.keyboard_check(G.lanzar_agarrar))))
							elif swimtype == 1.0:
								if x != xprevious or y != yprevious:
									sprite_index = Scr.scr_marioswim2(self)
									if G.key_br == 1.0:
										image_speed = (0.1 + (0.1 * G.key_br))
									else:
										image_speed = (0.1 + (0.1 * float(GM.keyboard_check(G.lanzar_agarrar))))
								else:
									sprite_index = Scr.scr_marioswim_idle(self)
									image_speed = 0.15
							elif swimtype == 2.0:
								if x != xprevious or y != yprevious:
									sprite_index = Scr.scr_marioswim3(self)
									if G.key_br == 1.0:
										image_speed = (0.1 + (0.1 * G.key_br))
									else:
										image_speed = (0.1 + (0.1 * float(GM.keyboard_check(G.lanzar_agarrar))))
								else:
									sprite_index = Scr.scr_marioswim_idle(self)
									image_speed = 0.15
						elif noisy == 0.0:
							if G.powerup == -85.0 and arrow > 0.0:
								if sprite_index == Scr.scr_link_arrow_swim(self, arrow):
									if image_index >= 2.85:
										sprite_index = Scr.scr_link_arrow_jump(self, arrow)
										image_index = 0.0
									else:
										image_speed = 0.15
								else:
									sprite_index = Scr.scr_link_arrow_jump(self, arrow)
									image_speed = 0.15
							elif sprite_index == Scr.scr_marioswim(self):
								if (G.powerup == -85.0 and image_index >= 2.85) or (G.apariencia == 0.0 and image_index >= 4.75) or (G.apariencia != 0.0 and image_index >= 2.85):
									sprite_index = Scr.scr_marioswimhold(self)
									image_index = 0.0
								elif G.apariencia == 0.0 and G.powerup != -85.0:
									image_speed = 0.25
								else:
									image_speed = 0.15
							else:
								sprite_index = Scr.scr_marioswimhold(self)
								image_speed = 0.15
					elif stompstyle == 1.0:
						if GM.instance_exists(A.obj_mario_transform2):
							image_speed = 0.0
						else:
							image_speed = 0.4
						sprite_index = Scr.scr_mariowarp(self)
					elif caped > 0.0:
						if GM.instance_exists(A.obj_mario_transform2):
							image_speed = 0.0
						else:
							image_speed = 0.3
						sprite_index = Scr.scr_mariowarp(self)
					elif firing > 0.0:
						image_speed = 0.0
						if firing < 6.0 and firing > 3.0:
							image_index = 1.0
						else:
							image_index = 0.0
						sprite_index = Scr.scr_marioshoot(self)
					elif modo_vuelo == 1.0:
						if place_free(x, (y + 1.0)) and vspeed > 0.0:
							if sprite_index != Scr.scr_mario_cap_fly_acender(self) and sprite_index != Scr.scr_mario_cap_fly_decender(self) and sprite_index != Scr.scr_mario_cap_fly_acender_decender(self):
								sprite_index = Scr.scr_mario_cap_fly(self)
								image_speed = 0.2
						elif sprite_index != Scr.scr_mario_cap_fly_acender(self):
							sprite_index = Scr.scr_mario_cap_fly(self)
							image_speed = 0.0
					elif pmeter < 6.0:
						if G.apariencia == 1.0 and G.powerup != -29.0 and G.powerup != 0.0 and GM.instance_exists(A.obj_invincibility):
							sprite_index = Scr.scr_mariojumpstar(self)
							image_speed = 0.4
						elif arrow > 0.0:
							sprite_index = Scr.scr_link_arrow_jump(self, arrow)
							image_speed = 0.0
							if vspeed > 0.0 or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
								image_index = 1.0
							else:
								image_index = 0.0
						else:
							sprite_index = Scr.scr_mariojump(self)
							if G.powerup == -78.0:
								image_speed = 0.2
							if G.powerup != -39.0:
								if vspeed > 0.0 or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
									if G.powerup == -78.0 and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) == null) and jumpnow != 0.0 and s_hen == 1.0:
										GM.audio_play_sound(A.snd_SMB_hen_jump_fall, 0.0, false)
										s_hen = 0.0
										sprite_index = Scr.scr_mariodrop(self)
									elif G.apariencia == 0.0 and jumpnow == 0.0:
										sprite_index = Scr.scr_mariowalk(self)
										image_index = 0.0
									else:
										sprite_index = Scr.scr_mariodrop(self)
							elif wiggle == 0.0:
								image_speed = 0.0
								if (place_free(x, (y + 1.0)) and vspeed > 0.0) or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
									image_index = 3.0
								else:
									image_index = 0.0
					elif G.apariencia == 1.0 and G.powerup != 0.0 and G.powerup != -39.0 and G.powerup != -29.0 and GM.instance_exists(A.obj_invincibility):
						sprite_index = Scr.scr_mariojumpstar(self)
						image_speed = 0.4
					elif collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
						if G.apariencia == 0.0 and jumpnow == 0.0:
							sprite_index = Scr.scr_mariowalk(self)
							image_index = 0.0
						else:
							sprite_index = Scr.scr_mariodrop(self)
					else:
						if G.apariencia == 0.0:
							if (place_free(x, (y + 1.0)) and vspeed > 0.0) or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
								if G.powerup == -78.0 and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) == null) and jumpnow != 0.0 and s_hen == 1.0:
									GM.audio_play_sound(A.snd_SMB_hen_jump_fall, 0.0, false)
									s_hen = 0.0
									sprite_index = Scr.scr_mariodrop(self)
								else:
									sprite_index = Scr.scr_mariodrop(self)
							else:
								sprite_index = Scr.scr_mariojump(self)
								if G.powerup == -78.0:
									image_speed = 0.2
						elif G.powerup == -29.0:
							if (place_free(x, (y + 1.0)) and vspeed > 0.0) or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
								sprite_index = Scr.scr_mariodrop(self)
							else:
								sprite_index = Scr.scr_mariojump(self)
						else:
							sprite_index = Scr.scr_mariorunjump(self)
						if G.powerup == -39.0:
							if wiggle == 0.0:
								image_speed = 0.0
								if (place_free(x, (y + 1.0)) and vspeed > 0.0) or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
									image_index = 0.0
								else:
									image_index = 2.0
			else:
				if state == 0.0:
					if G.powerup == -29.0 and isswim == 1.0:
						sprite_index = Scr.scr_marioswim_hold_idle(self)
						image_speed = 0.15
					else:
						image_speed = 0.0
						image_index = 0.99
				if state == 1.0:
					if turning == 0.0:
						if absf((hspeed / 5.0)) > 0.3:
							spd_i = 0.3
						else:
							spd_i = absf((hspeed / 5.0))
						image_speed = spd_i
					else:
						image_speed = 0.0
						image_index = 1.0
				if state == 2.0:
					if turning == 0.0:
						if G.powerup == -29.0 and isswim == 1.0:
							if swimtype == 0.0:
								if hspeed == 0.0:
									sprite_index = Scr.scr_marioswim_hold_idle(self)
									image_speed = 0.15
								else:
									sprite_index = Scr.scr_marioswimhold(self)
									if G.key_br == 1.0:
										image_speed = (0.1 + (0.1 * G.key_br))
									else:
										image_speed = (0.1 + (0.1 * float(GM.keyboard_check(G.lanzar_agarrar))))
							elif swimtype == 1.0:
								if x != xprevious or y != yprevious:
									sprite_index = Scr.scr_marioswimhold(self)
									if G.key_br == 1.0:
										image_speed = (0.1 + (0.1 * G.key_br))
									else:
										image_speed = (0.1 + (0.1 * float(GM.keyboard_check(G.lanzar_agarrar))))
								else:
									sprite_index = Scr.scr_marioswim_hold_idle(self)
									image_speed = 0.15
							elif swimtype == 2.0:
								if x != xprevious or y != yprevious:
									sprite_index = Scr.scr_marioswimhold(self)
									if G.key_br == 1.0:
										image_speed = (0.1 + (0.1 * G.key_br))
									else:
										image_speed = (0.1 + (0.1 * float(GM.keyboard_check(G.lanzar_agarrar))))
								else:
									sprite_index = Scr.scr_marioswim_hold_idle(self)
									image_speed = 0.15
						elif isswim == 1.0 and (holding == 2.0 or holding == 1.0):
							image_speed = 0.0
							if vspeed > 0.0:
								image_speed = 0.16
							else:
								image_index = 0.0
						elif holding == 2.0 and stompstyle == 1.0 and isswim == 0.0:
							image_speed = 0.4
						else:
							image_speed = 0.0
							if G.powerup == -85.0:
								if vspeed > 0.0 or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
									image_index = 1.0
								else:
									image_index = 0.0
							elif G.powerup != -39.0:
								if G.powerup != 0.0 and G.apariencia == 1.0:
									image_index = 2.0
								else:
									image_index = 1.0
							elif wiggle == 0.0:
								if vspeed > 0.0 or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null:
									image_index = 2.0
								else:
									image_index = 1.0
					else:
						image_speed = 0.0
						image_index = 1.0
				if turning == 1.0:
					sprite_index = Scr.scr_mariowarp(self)
				elif holding == 2.0 and isswim == 1.0 and gravity != 0.0 and G.powerup == -85.0:
					sprite_index = A.spr_SMB_link_hold_swim
				elif holding == 2.0 and isswim == 1.0 and gravity != 0.0 and G.powerup != -29.0:
					sprite_index = Scr.scr_marioswimhold(self)
				elif holding == 2.0 and stompstyle == 1.0 and isswim == 0.0:
					sprite_index = Scr.scr_mariowarp(self)
				elif holding == 1.0 or holding == 2.0:
					if G.apariencia == 1.0 and G.powerup == -39.0 and vspeed != 0.0:
						sprite_index = Scr.scr_mariojumphold(self)
					elif G.powerup == -29.0 and isswim == 0.0:
						if pmeter > 5.0 and state < 2.0:
							sprite_index = Scr.scr_mariorun(self)
						else:
							sprite_index = Scr.scr_mariohold(self)
					elif G.powerup == -29.0 and isswim == 1.0 and state == 1.0:
						sprite_index = Scr.scr_marioswimhold(self)
					elif G.powerup == -85.0 and state == 2.0:
						sprite_index = A.spr_SMB_link_hold_jump
					elif G.powerup != -29.0:
						sprite_index = Scr.scr_mariohold(self)
					if isuphold == 1.0 and jumpnow == 0.0 and state == 0.0:
						sprite_index = Scr.scr_mariouphold(self)
			if state == 3.0:
				sprite_index = Scr.scr_marioclimb(self)
				if G.apariencia < 2.0:
					if speed == 0.0:
						image_speed = 0.0
					else:
						image_speed = 0.15
				elif G.apariencia == 2.0:
					if speed == 0.0:
						image_speed = 0.0
						image_index = 2.0
					else:
						image_speed = 0.25
						if image_index > 1.8:
							image_index = 0.0
			elif state == 4.0:
				sprite_index = Scr.scr_marioskid(self)
				if skidnow == 0.0 and G.apariencia != 0.0:
					skidnow = 1.0
					GM.audio_play_sound(Scr.scr_snd_skid(self), 1.0, true)
			if iamkicking == 1.0 and stompstyle == 0.0 and (G.apariencia != 0.0 or G.powerup == -85.0 or G.powerup == -80.0):
				if G.powerup == -29.0 and isswim == 1.0:
					pass
				else:
					sprite_index = Scr.scr_mariokick(self)
		elif isduck == 1.0:
			match G.powerup:
				0.0:
					if GM.instance_exists(A.obj_yoshi_blue):
						mask_index = A.spr_bigmask
					else:
						mask_index = A.spr_smallduckmask
				-85.0:
					mask_index = A.spr_smallduckmask
				-77.0:
					if GM.instance_exists(A.obj_kuriboshoe):
						mask_index = A.spr_megamask
					else:
						mask_index = A.spr_mega_mask_duck
				_:
					mask_index = A.spr_smallmask
			if sprite_index != A.spr_SMB_link_shield:
				if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0 and (G.apariencia != 0.0 or (G.apariencia == 0.0 and vspeed == 0.0) or (G.powerup == -80.0)):
					direct = 1.0
				elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0 and (G.apariencia != 0.0 or (G.apariencia == 0.0 and vspeed == 0.0) or (G.powerup == -80.0)):
					direct = -1.0
			if G.powerup == -39.0:
				if state == 2.0:
					if wiggle > 1.0:
						wiggle -= 1.0
					if wiggle > 12.0:
						image_index = 3.0
					elif wiggle > 8.0:
						image_index = 2.0
					elif wiggle > 4.0:
						image_index = 1.0
					elif wiggle > 1.0:
						image_index = 2.0
					elif wiggle == 1.0:
						image_index = 1.0
				else:
					wiggle = 0.0
			else:
				wiggle = 0.0
			if isduckhold == 1.0:
				sprite_index = Scr.scr_marioduckhold(self)
				if jump_loaded == 60.0:
					image_speed = 0.3
				else:
					image_speed = 0.0
					image_index = 0.0
			else:
				sprite_index = Scr.scr_marioduck(self)
				if wiggle == 0.0:
					if (place_free(x, (y + 1.0)) and vspeed > 0.0 and G.powerup == -39.0) or (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bortice, false, false) != null and G.powerup == -39.0):
						image_index = 2.0
					elif jump_loaded == 60.0:
						image_speed = 0.3
					else:
						image_speed = 0.0
						image_index = 0.0
		if sprite_index != Scr.scr_marioskid(self) and skidnow == 1.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			GM.audio_stop_sound(Scr.scr_snd_skid(self))
			skidnow = 0.0


# from objects/obj_mario/Alarm_0.gml
func _alarm_0() -> void:
	# / @description camera_jump holding variable
	camera_jump = 0.0


# from objects/obj_mario/Alarm_1.gml
func _alarm_1() -> void:
	# / @description Make Mario's alpha blink
	if not GM.instance_exists(A.obj_mario_transform2):
		if image_alpha == 1.0:
			image_alpha = 0.0
		else:
			image_alpha = 1.0
	alarm[2] = 4.0


# from objects/obj_mario/Alarm_2.gml
func _alarm_2() -> void:
	# / @description Make Mario's alpha blink stop
	image_alpha = 1.0
	if invincible == 1.0:
		alarm[1] = 6.0


# from objects/obj_mario/Alarm_3.gml
func _alarm_3() -> void:
	# / @description Make Mario no longer invincible
	if not GM.instance_exists(A.obj_invincibility):
		invincible = 0.0


# from objects/obj_mario/Alarm_4.gml
func _alarm_4() -> void:
	# / @description End Mario's net smack
	netsmack = 0.0
	can_break_block = 2.0


# from objects/obj_mario/Alarm_5.gml
func _alarm_5() -> void:
	# / @description Create Mario's skid smoke
	if skidnow == 1.0 and G.apariencia != 0.0:
		if (direct == 1.0 and state != 4.0) or (direct == -1.0 and state == 4.0):
			for inst in GM.with_list(GM.instance_create((x + 1.0), (y + 24.0), A.obj_smoke)):
				inst.sprite_index = A.spr_skidsmoke
				inst.depth = -6.0
		else:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y + 24.0), A.obj_smoke)):
				inst.sprite_index = A.spr_skidsmoke
				inst.depth = -6.0
	alarm[5] = 8.0


# from objects/obj_mario/Alarm_6.gml
func _alarm_6() -> void:
	# / @description Finish Mario's kicking animation
	if G.apariencia != 3.0:
		iamkicking = 0.0
	canhang = 2.0


# from objects/obj_mario/Alarm_7.gml
func _alarm_7() -> void:
	var o_fire  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Create Mario's first spin jump projectile
	if holding == 0.0:
		if G.powerup == 2.0 and GM.instance_number(A.obj_fireball) < 2:
			if GM.instance_exists(A.obj_brickhelmet):
				o_fire = A.obj_fireball_b
			else:
				o_fire = A.obj_fireball
			for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 12.0), o_fire)):
				inst.hspeed = 4.5
		elif G.powerup == -38.0 and GM.instance_number(A.obj_snowball) < 2:
			for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 12.0), A.obj_snowball)):
				inst.hspeed = 2.6
	if stompstyle == 1.0:
		alarm[8] = 10.0


# from objects/obj_mario/Alarm_8.gml
func _alarm_8() -> void:
	var o_fire  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Create Mario's second spin jump projectile
	if holding == 0.0:
		if G.powerup == 2.0 and GM.instance_number(A.obj_fireball) < 2:
			if GM.instance_exists(A.obj_brickhelmet):
				o_fire = A.obj_fireball_b
			else:
				o_fire = A.obj_fireball
			for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 12.0), o_fire)):
				inst.hspeed = -4.5
		elif G.powerup == -38.0 and GM.instance_number(A.obj_snowball) < 2:
			for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 12.0), A.obj_snowball)):
				inst.hspeed = -2.6


# from objects/obj_mario/Alarm_9.gml
func _alarm_9() -> void:
	# / @description Create Mario's underwater bubble effect
	alarm[9] = (45.0 + GM.random_range(-15.0, 15.0))
	if isswim == 1.0:
		GM.instance_create(x, bbox_top, A.obj_bubble)


# from objects/obj_mario/Alarm_10.gml
func _alarm_10() -> void:
	var clown_col  # 局部变量提升（GML 的 var 是函数作用域）
	var hammer  # 局部变量提升（GML 的 var 是函数作用域）
	var o_fire  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Handles powerup specific projectiles, tail spinning, and statue morphing
	if disablecontrols == 0.0 and (holding == 0.0 or (holding == 3.0 and G.yoshi == 2.0)) and skidnow == 0.0 and walljump == 0.0 and stompstyle == 0.0:
		if isduck == 0.0:
			if G.powerup == 3.0 and G.yoshi == 0.0:
				clown_col = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false)
				if clown_col != null and clown_col.get("inmario") == 1.0:
					return
				else:
					GM.audio_stop_sound(A.snd_spin)
					GM.audio_play_sound(A.snd_spin, 0.0, false)
					caped = 1.0
					alarm[11] = 25.0
			elif G.powerup == 2.0:
				if GM.instance_number(A.obj_fireball) < 2:
					clown_col = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown_fire, false, false)
					if clown_col != null and clown_col.get("inmario") == 1.0:
						return
					else:
						if GM.instance_exists(A.obj_brickhelmet):
							o_fire = A.obj_fireball_b
						else:
							o_fire = A.obj_fireball
						if G.apariencia == 3.0:
							firing = 20.0
						else:
							firing = 9.0
						if G.apariencia == 0.0:
							for inst in GM.with_list(GM.instance_create((x + (8.0 * direct)), (y + 12.0), o_fire)):
								inst.hspeed = (3.0 * self.direct)
						else:
							for inst in GM.with_list(GM.instance_create((x + (14.0 * direct)), (y + 12.0), o_fire)):
								inst.hspeed = (3.0 * self.direct)
				elif stompstyle == 1.0:
					alarm[10] = 4.0
			elif G.powerup == -38.0:
				if GM.instance_number(A.obj_snowball) < 2:
					clown_col = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown_fire, false, false)
					if clown_col != null and clown_col.get("inmario") == 1.0:
						return
					else:
						firing = 20.0
						for inst in GM.with_list(GM.instance_create((x + (14.0 * direct)), (y + 12.0), A.obj_snowball)):
							inst.hspeed = (2.6 * self.direct)
				elif stompstyle == 1.0:
					alarm[10] = 4.0
			elif G.powerup == -50.0 and GM.instance_number(A.obj_superball) < 1:
				clown_col = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown_fire, false, false)
				if clown_col != null and clown_col.get("inmario") == 1.0:
					return
				else:
					firing = 9.0
					if isswim == 0.0:
						for inst in GM.with_list(GM.instance_create(x, (y + 12.0), A.obj_superball)):
							inst.hspeed = (4.5 * self.direct)
					else:
						for inst in GM.with_list(GM.instance_create(x, (y + 12.0), A.obj_superball)):
							inst.hspeed = (3.0 * self.direct)
			elif G.powerup == -39.0 and sprite_index != Scr.scr_mariojumpstar(self) and (not GM.instance_exists(A.obj_spinner)) and G.yoshi == 0.0:
				clown_col = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false)
				if clown_col != null and clown_col.get("inmario") == 1.0:
					return
				else:
					GM.instance_create(x, y, A.obj_spinner)
			elif G.powerup == -85.0 and (not GM.instance_exists(A.obj_link_atack)) and G.yoshi == 0.0 and down_atack == 0.0 and arrow == 0.0:
				clown_col = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false)
				if clown_col != null and clown_col.get("inmario") == 1.0:
					return
				else:
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_link_atack)):
						if self.direct == -1.0:
							inst.mask_index = A.spr_SMB_link_atack_mask
			elif G.powerup == -46.0 and sprite_index != Scr.scr_mariojumpstar(self):
				clown_col = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown_fire, false, false)
				if clown_col != null and clown_col.get("inmario") == 1.0:
					return
				elif GM.instance_number(A.obj_hammer) < 2:
					firing = 9.0
					if GM.instance_exists(A.obj_brickhelmet):
						hammer = A.obj_hammer_b
					else:
						hammer = A.obj_hammer
					for inst in GM.with_list(GM.instance_create((x + (14.0 * direct)), (y + 12.0), hammer)):
						inst.hspeed = ((absf(self.hspeed) + 1.5) * self.direct)


# from objects/obj_mario/Alarm_11.gml
func _alarm_11() -> void:
	# / @description Set Cap sprite
	turning = 0.0
	caped = 0.0
	if G.powerup != 3.0:
		return
	if G.powerup == 3.0 and GM.instance_find(A.obj_mario, 0).state == 2.0 and GM.instance_exists(A.obj_cap_mario):
		for inst in GM.with_list(A.obj_cap_mario):
			inst.sprite_index = A.spr_cap_fall
	elif G.powerup == 3.0 and GM.instance_find(A.obj_mario, 0).state == 1.0 and GM.instance_exists(A.obj_cap_mario) and GM.instance_find(A.obj_mario, 0).hspeed != 0.0:
		for inst in GM.with_list(A.obj_cap_mario):
			inst.sprite_index = A.spr_cap_run
	elif G.powerup == 3.0 and GM.instance_find(A.obj_mario, 0).state == 1.0 and GM.instance_exists(A.obj_cap_mario) and GM.instance_find(A.obj_mario, 0).hspeed == 0.0:
		for inst in GM.with_list(A.obj_cap_mario):
			inst.sprite_index = A.spr_cap_start_stay
		for inst in GM.with_list(A.obj_cap_mario):
			inst.image_speed = 0.1


# from objects/obj_mario/Other_5.gml
func _room_end() -> void:
	# / @description Execute destroy event
	instance_destroy()


# from objects/obj_mario/Other_7.gml
func _animation_end() -> void:
	if G.powerup != 3.0:
		return
	if sprite_index == Scr.scr_mario_cap_fly(self):
		image_speed = 0.0
		image_index = 2.0
	elif sprite_index == Scr.scr_mario_cap_fly_acender(self):
		if fly_high == 6.0:
			vspeed = -4.8
			fly_high = 3.0
		elif fly_high == 3.0:
			vspeed = -2.8
		jumpnow = 1.0
		GM.audio_play_sound(A.snd_mariocap_rise, 0.0, false)
		sprite_index = Scr.scr_mario_cap_fly(self)
	elif sprite_index == Scr.scr_mario_cap_fly_decender(self):
		image_speed = 0.0
		image_index = 2.0
	elif sprite_index == Scr.scr_mario_cap_fly_acender_decender(self):
		sprite_index = Scr.scr_mario_cap_fly_acender(self)


# from objects/obj_mario/Other_10.gml
func _user_0() -> void:
	var yoshi  # 局部变量提升（GML 的 var 是函数作用域）
	var yoshis  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Hurt Mario
	# If Mario is not invincible
	if invincible == 0.0:
		if G.yoshi > 0.0:
			if G.yoshi == 1.0:
				_user_6()
				if GM.instance_exists(A.obj_yoshi_red):
					yoshi = A.obj_yoshi_red
				elif GM.instance_exists(A.obj_yoshi_blue):
					yoshi = A.obj_yoshi_blue
				elif GM.instance_exists(A.obj_yoshi2):
					yoshi = A.obj_yoshi2
				if GM.instance_exists(yoshi):
					if yoshi == A.obj_yoshi_red:
						yoshis = A.obj_yoshi_runaway_red
					elif yoshi == A.obj_yoshi_blue:
						yoshis = A.obj_yoshi_runaway_blue
					elif yoshi == A.obj_yoshi2:
						yoshis = A.obj_yoshi_runaway
					var yoshi_i = GM.instance_find(yoshi, 0)  # yoshi holds an object index: yoshi.x reads the first instance
					var yoshi_r = GM.instance_create(yoshi_i.x, yoshi_i.y, yoshis)
					if yoshi_i.get("mouthholder") != null:
						yoshi_r.set("mouthholder", yoshi_i.get("mouthholder"))
						yoshi_r.set("mouthsprite", yoshi_i.get("mouthsprite"))
					for inst in GM.with_list(yoshi):
						inst.instance_destroy()
					vspeed = -3.5
					hspeed = 0.0
			elif G.yoshi == 2.0:
				_user_6()
				var _o1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_kuriboshoe):
					inst.event_user(5)
				GM.other = _o1
			G.yoshi = 0.0
			holding = 0.0
			visible = true
			fly_cap = 0.0
			canfly = 0.0
			Scr.scr_lose_condition(self)
		elif modo_vuelo == 0.0 and (not GM.instance_exists(A.obj_deadmario)) and (not GM.instance_exists(A.obj_mario_transform2)):
			if helmet == 0.0:
				match G.powerup:
					0.0:
						visible = false
						GM.instance_create(x, y, A.obj_deadmario)
						instance_destroy()
					1.0:
						GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
						for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
							inst.set("c_powerup", 1.0)
							inst.set("small", 2.0)
							inst.set("powerdown", 1.0)
					-85.0:
						GM.audio_play_sound(A.snd_SMB_link_powerdown, 0.0, false)
						G.powerup = 0.0
						for inst in GM.with_list(A.obj_levelmanager):
							inst.set("mchange", 3.0)
						G.ef_repeat = 1.0
						holding = 0.0
						down_atack = 0.0
						down_cont = 0.0
						arrow = 0.0
						arrow_ready = 0.0
						dash_atack = 0.0
						dash_cont = 0.0
						_user_6()
						imdead = GM.instance_create(x, (y + 3.0), A.obj_enemy_dead)
						imdead.set("girar", 1.0)
						imdead.sprite_index = A.spr_link_deads
						imdead.hspeed = (-((1.0 * direct)))
						Scr.scr_lose_condition(self)
					-80.0:
						GM.audio_play_sound(A.snd_SMB_link_powerdown, 0.0, false)
						G.powerup = 0.0
						for inst in GM.with_list(A.obj_levelmanager):
							inst.set("mchange", 3.0)
						G.ef_repeat = 1.0
						holding = 0.0
						_user_6()
					3.0:
						GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
						G.powerup = 1.0
						if GM.instance_exists(A.obj_cap_mario):
							for inst in GM.with_list(A.obj_cap_mario):
								inst.set("cap_invisible", 1.0)
								inst.visible = false
						for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
							inst.set("cap", 2.0)
							inst.set("powerdown", 1.0)
					-39.0:
						GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
						for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
							inst.set("c_powerup", 1.0)
							inst.set("sprite_powerup", A.spr_SMB3_mushroom)
							inst.set("powerdown", 1.0)
					_:
						if G.powerup == -50.0:
							for inst in GM.with_list(A.obj_levelmanager):
								inst.set("mchange", 3.0)
							G.ef_repeat = 1.0
						elif G.powerup == -80.0:
							for inst in GM.with_list(A.obj_levelmanager):
								inst.set("mchange", 3.0)
							G.ef_repeat = 1.0
						GM.audio_play_sound(Scr.scr_snd_powerdown(self), 0.0, false)
						for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
							inst.set("c_powerup", 1.0)
							match G.apariencia:
								0.0:
									inst.set("sprite_powerup", A.spr_SMB_mushroom)
								1.0:
									inst.set("sprite_powerup", A.spr_SMB3_mushroom)
								2.0:
									inst.set("sprite_powerup", A.spr_mushroom)
								3.0:
									inst.set("sprite_powerup", A.spr_NSMBU_mushroom)
							inst.set("powerdown", 1.0)
				Scr.scr_lose_condition(self)
				fly_cap = 0.0
				canfly = 0.0
			else:
				_user_6()
				helmet = 0.0
				if GM.instance_exists(A.obj_brickhelmet):
					var _o2: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_brickhelmet):
						inst.event_user(5)
					GM.other = _o2
				else:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_helmet):
						inst.event_user(5)
					GM.other = _o3
				Scr.scr_lose_condition(self)
		else:
			_user_6()
			GM.audio_play_sound(A.snd_mariocap_out, 0.0, false)
			modo_vuelo = 0.0
			stompstyle = 1.0
			fly_cap = 0.0
			canfly = 0.0


# from objects/obj_mario/Other_11.gml
func _user_1() -> void:
	# / @description Make Mario bounce off of something
	if state != 3.0:
		if GM.keyboard_check(G.saltar) or GM.keyboard_check(G.saltar_spin):
			jumpnow = 1.0
		else:
			jumpnow = 2.0
		state = 2.0
		yview = (y + 32.0)
		camera_jump = 1.0
		alarm[0] = 4.0
		alarm[4] = 15.0
		if (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_hurtsolid2, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 4.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				vspeed = -2.675
			else:
				vspeed = (-((4.225 - (2.55 * isswim))))
			y -= 1.0
		if GM.instance_find(A.obj_levelmanager, 0).get("pmeter") > 5.0 and G.powerup == -39.0:
			for inst in GM.with_list(A.obj_levelmanager):
				inst.alarm[8] = 300.0
		if stompstyle == 1.0:
			alarm[7] = 5.0


# from objects/obj_mario/Other_12.gml
func _user_2() -> void:
	var climb1  # 局部变量提升（GML 的 var 是函数作用域）
	var posy  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Mario's default step event
	col_enemigos = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_enemyparent, false, false)
	if gravity == 0.0 and (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom - 1.0), A.obj_solidtop, false, false) != null or (collision_rectangle(bbox_left, bbox_bottom + 1.0, bbox_right, bbox_bottom + 1.5, A.obj_slopeparent, true, false) != null) or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_lava_water_drybones, false, false) != null and (GM.instance_exists(A.obj_kuribo_drybones) or (G.powerup == -29.0 and GM.instance_find(A.obj_mario, 0).pmeter > 5.0 and GM.instance_find(A.obj_mario, 0).holding == 2.0)) or ((col_enemigos != null and ((G.powerup == -80.0) and ((col_enemigos.get("stomp") != 1.0) and ((col_enemigos.get("stomp") != 2.0) and (col_enemigos.get("stomp") != 5.0)))))))):
		if vspeed >= 0.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			statedelay = 0.0
			if hspeed == 0.0:
				state = 0.0
			else:
				state = 1.0
			yview = (y + 32.0)
			if G.yoshi == 0.0 and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsizable, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsolid, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_rockparent, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null):
				_user_0()
		elif vspeed < 0.0:
			state = 2.0
	else:
		statedelay += 1.0
		if statedelay > 4.0:
			state = 2.0
	if down_atack == 0.0 and disablecontrols == 2.0:
		disablecontrols = 0.0
	if down_atack == 1.0:
		vspeed = 0.0
		gravity = 0.0
	elif down_atack == 2.0:
		if vspeed > 6.0:
			vspeed = 6.0
	elif vspeed > 4.0:
		vspeed = 4.0
	if G.powerup == -80.0 and state == 0.0:
		if GM.keyboard_check(G.abajo):
			if jump_loaded < 60.0:
				jump_loaded += 1.0
			else:
				jump_loaded = 60.0
		else:
			jump_loaded = 0.0
	else:
		jump_loaded = 0.0
	if (G.powerup == -80.0) and (Scr.scr_canpull(self) > 0.5 and ((not GM.instance_exists(A.obj_puller)) and (holding == 0.0))):
		enemigo = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_enemyparent, false, false)
		hold = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_holdparent, false, false)
		nube = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_nube, false, false)
		suelo_nieve = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_modelsolid, false, false)
		start_nieve = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_ground2, false, false)
		goal_nieve = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_ground3, false, false)
		if nube != null:
			speed = 0.0
			GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
			c_nube = GM.instance_create(x, y, A.obj_puller)
			c_nube.set("cloud", 1.0)
			c_nube.set("obj", nube)
		elif enemigo != null and ((enemigo.get("hardness") < 99.0) or (enemigo.object_index == A.obj_banzaibill)):
			speed = 0.0
			GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
			c_enemy = GM.instance_create(x, y, A.obj_puller)
			c_enemy.set("enemy", 1.0)
			c_enemy.set("obj", enemigo)
		elif hold != null and ((hold.object_index != A.obj_pswitch) and (hold.object_index != A.obj_spring)):
			speed = 0.0
			GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
			c_enemy = GM.instance_create(x, y, A.obj_puller)
			c_enemy.set("held", 1.0)
			c_enemy.set("obj", hold)
		elif G.bg_level == "snow":
			if suelo_nieve != null or (start_nieve != null or goal_nieve != null):
				speed = 0.0
				GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_puller)):
					inst.set("snowball", 1.0)
	if GM.keyboard_check(G.lanzar_agarrar) or G.key_br == 1.0:
		if (G.powerup == -29.0 and holding == 0.0) or arrow > 0.0:
			hspeedmax = (1.3 + absf((1 * GM.instance_number(A.obj_invincibility))))
		else:
			hspeedmax = (3.0 + absf((1 * GM.instance_number(A.obj_invincibility))))
	elif (G.powerup == -29.0 and holding == 0.0) or arrow > 0.0:
		hspeedmax = (1.0 + absf((1 * GM.instance_number(A.obj_invincibility))))
	else:
		hspeedmax = (1.3 + absf((1 * GM.instance_number(A.obj_invincibility))))
	if GM.keyboard_check_pressed(G.saltar) and disablecontrols == 0.0 and jumpnow == 0.0 and state < 2.0 and (sprite_index != A.spr_SMB_link_shield or G.yoshi > 0.0):
		if absf(hspeed) > 2.8:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				if G.powerup == -78.0:
					vspeed = -3.8
				else:
					vspeed = -3.3
			elif G.powerup == -78.0:
				vspeed = -4.8
			else:
				vspeed = -4.3
		elif G.bg_level == "sky" and G.modo_noche == 1.0:
			if G.powerup == -78.0:
				if GM.gm_round((hspeed / 2.0)) == 0.0:
					vspeed = -3.45
				else:
					vspeed = -3.55
			elif jump_loaded == 60.0:
				vspeed = -3.6
			elif GM.gm_round((hspeed / 2.0)) == 0.0:
				vspeed = -2.85
			else:
				vspeed = -2.95
		elif G.powerup == -78.0:
			if GM.gm_round((hspeed / 2.0)) == 0.0:
				vspeed = -4.45
			else:
				vspeed = -4.55
		elif jump_loaded == 60.0:
			vspeed = -4.5
		elif GM.gm_round((hspeed / 2.0)) == 0.0:
			vspeed = -3.95
		else:
			vspeed = -4.05
		GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
		jumpnow = 1.0
		s_hen = 1.0
		state = 2.0
	if (GM.keyboard_check_pressed(G.saltar_spin) and G.apariencia == 2.0 and disablecontrols == 0.0 and holding == 0.0 and isduck == 0.0 and jumpnow == 0.0 and state < 2.0) or (GM.keyboard_check_pressed(G.saltar_spin) and (G.apariencia == 2.0 or G.apariencia == 3.0) and disablecontrols == 0.0 and holding == 3.0 and isduck == 0.0 and G.yoshi > 0.0 and vspeed == 0.0 and jumpnow == 0.0 and state < 2.0):
		image_index = 0.0
		if absf(hspeed) > 2.8:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				vspeed = -2.3
			else:
				vspeed = -3.3
		elif G.bg_level == "sky" and G.modo_noche == 1.0:
			if GM.gm_round((hspeed / 2.0)) == 0.0:
				vspeed = -2.3
			else:
				vspeed = -2.3
		elif GM.gm_round((hspeed / 2.0)) == 0.0:
			vspeed = -3.3
		else:
			vspeed = -3.3
		jumpnow = 1.0
		s_hen = 1.0
		state = 2.0
		isduck = 0.0
		y -= 1.0
		stompstyle = 1.0
		GM.audio_play_sound(Scr.scr_snd_spinjump(self), 0.0, false)
		alarm[7] = 10.0
		if G.yoshi == 2.0:
			G.yoshi = 0.0
			holding = 0.0
			if GM.instance_exists(A.obj_kuriboshoe):
				var _o1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_kuriboshoe):
					inst.event_user(0)
				GM.other = _o1
		elif G.yoshi > 0.0:
			G.yoshi = 0.0
			holding = 0.0
			if direct > 0.0:
				hspeed = -1.2
			else:
				hspeed = 1.2
			if GM.instance_exists(A.obj_yoshi2):
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_yoshi2):
					inst.event_user(1)
				GM.other = _o2
	elif (GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 2.0 and jumpnow == 0.0 and state < 2.0) or (GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and G.yoshi > 0.0 and vspeed != 0.0 and G.apariencia == 2.0 and state == 2.0) or (GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and G.yoshi > 0.0 and G.apariencia != 2.0) or (GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and jumpnow == 0.0 and state < 2.0 and G.apariencia != 2.0 and G.powerup != -85.0):
		if absf(hspeed) > 2.8:
			if G.bg_level == "sky" and G.modo_noche == 1.0:
				if G.powerup == -78.0:
					vspeed = -3.8
				else:
					vspeed = -3.3
			elif G.powerup == -78.0:
				vspeed = -4.8
			else:
				vspeed = -4.3
		elif G.bg_level == "sky" and G.modo_noche == 1.0:
			if G.powerup == -78.0:
				if GM.gm_round((hspeed / 2.0)) == 0.0:
					vspeed = -3.45
				else:
					vspeed = -3.55
			elif GM.gm_round((hspeed / 2.0)) == 0.0:
				vspeed = -2.85
			else:
				vspeed = -2.95
		elif G.powerup == -78.0:
			if GM.gm_round((hspeed / 2.0)) == 0.0:
				vspeed = -4.45
			else:
				vspeed = -4.55
		elif GM.gm_round((hspeed / 2.0)) == 0.0:
			vspeed = -3.95
		else:
			vspeed = -4.05
		GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
		jumpnow = 1.0
		s_hen = 1.0
		state = 2.0
		if G.yoshi > 0.0:
			G.yoshi = 0.0
			holding = 0.0
			if GM.instance_exists(A.obj_yoshi2):
				var _o3: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_yoshi2):
					inst.event_user(1)
				GM.other = _o3
			if GM.instance_exists(A.obj_kuriboshoe):
				stompstyle = 0.0
				var _o4: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_kuriboshoe):
					inst.event_user(0)
				GM.other = _o4
	if (GM.keyboard_check_released(G.saltar) and jumpnow == 1.0) or (GM.keyboard_check_released(G.saltar_spin) and jumpnow == 1.0):
		jumpnow = 2.0
	if isduck == 1.0 and state != 2.0:
		if snow == 1.0:
			if hspeed > 0.0:
				hspeed -= 0.01
			if hspeed < 0.0:
				hspeed += 0.01
			if absf(hspeed) < 0.01:
				hspeed = 0.0
		else:
			if hspeed > 0.0:
				hspeed -= 0.05
			if hspeed < 0.0:
				hspeed += 0.05
			if absf(hspeed) < 0.05:
				hspeed = 0.0
	else:
		if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0 and modo_vuelo == 0.0 and dash_atack == 0.0:
			if holding == 2.0 and direct != 1.0 and stompstyle == 0.0 and G.apariencia == 2.0:
				turning = 1.0
				alarm[11] = 7.0
			if hspeed < hspeedmax:
				if snow == 1.0 and gravity == 0.0:
					if hspeed < 0.0:
						hspeed += 0.03
					else:
						hspeed += 0.05
				else:
					if hspeed < 0.0:
						hspeed += 0.07
					hspeed += 0.06
			if modo_vuelo == 0.0 and arrow == 0.0 and (G.apariencia != 0.0 or inclown == 2.0 or (G.apariencia == 0.0 and state != 2.0) or (G.powerup == -80.0)):
				direct = 1.0
			direct_turn = 1.0
		elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0 and modo_vuelo == 0.0 and dash_atack == 0.0:
			if holding == 2.0 and direct != -1.0 and stompstyle == 0.0 and G.apariencia == 2.0:
				turning = 1.0
				alarm[11] = 7.0
			if hspeed > (-hspeedmax):
				if snow == 1.0 and gravity == 0.0:
					if hspeed > 0.0:
						hspeed += -0.03
					else:
						hspeed += -0.05
				else:
					if hspeed > 0.0:
						hspeed += -0.07
					hspeed += -0.06
			if modo_vuelo == 0.0 and arrow == 0.0 and direct_turn != 1.0 and (G.apariencia != 0.0 or inclown == 2.0 or (G.apariencia == 0.0 and state != 2.0) or (G.powerup == -80.0)):
				direct = -1.0
			direct_turn = -1.0
		elif state != 2.0:
			if snow == 1.0:
				if hspeed > 0.0:
					hspeed -= 0.005
				if hspeed < 0.0:
					hspeed += 0.005
				if absf(hspeed) < 0.005:
					hspeed = 0.0
			else:
				if hspeed > 0.0:
					hspeed -= 0.05
				elif hspeed < 0.0:
					hspeed += 0.05
				if absf(hspeed) < 0.05:
					hspeed = 0.0
		if state != 2.0 and absf(hspeed) > hspeedmax:
			if hspeed > 0.0:
				hspeed -= 0.025
			elif hspeed < 0.0:
				hspeed += 0.025
			if absf(hspeed) < 0.025:
				hspeed = 0.0
	if state == 2.0 or statedelay > 0.0:
		if G.modo_noche == 1.0 and G.bg_level == "sky":
			if G.powerup == -39.0:
				if ygrav == 1.0:
					gravity = 0.04
				elif pmeter > 5.0:
					gravity = 0.0
				else:
					gravity = 0.02
			else:
				gravity = 0.05
			if down_atack == 2.0:
				if vspeed > 4.0:
					vspeed = 4.0
			elif vspeed > 2.0:
				vspeed = 2.0
		elif vspeed > -1.0 or jumpnow != 1.0:
			if G.powerup == -39.0:
				if ygrav == 1.0:
					gravity = 0.2
				elif pmeter > 5.0:
					gravity = 0.0
				else:
					gravity = 0.15
			elif down_atack == 2.0:
				gravity = 0.6
			else:
				gravity = 0.3
			if jumpnow == 1.0:
				jumpnow = 2.0
		elif ygrav == 1.0:
			gravity = 0.1
		elif down_atack == 2.0:
			gravity = 0.2
		else:
			gravity = 0.1
		if G.powerup == 3.0:
			if (GM.keyboard_check(G.saltar) and sprite_index != A.spr_mario_cap_fly_decender and sprite_index != A.spr_luigi_cap_fly_decender and sprite_index != A.spr_toad_cap_fly_decender and sprite_index != A.spr_toadette_cap_fly_decender and vspeed > 0.0) or (GM.keyboard_check(G.saltar_spin) and sprite_index != A.spr_mario_cap_fly_decender and sprite_index != A.spr_luigi_cap_fly_decender and sprite_index != A.spr_toad_cap_fly_decender and sprite_index != A.spr_toadette_cap_fly_decender and place_free(x, (y + 1.0)) and vspeed > 0.0):
				gravity /= 2.0
				if vspeed > 1.0:
					vspeed = 1.0
	if G.apariencia == 0.0:
		climb1 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false)
		if climb1 != null and (((y + 19.0) > climb1.y and climb1.object_index == A.obj_vine_green and climb1.image_index == 0.0) or climb1.object_index != A.obj_vine_green or climb1.image_index != 0.0) and isduck == 0.0 and dash_atack == 0.0 and down_atack == 0.0 and arrow == 0.0 and holding == 0.0 and G.yoshi == 0.0 and (GM.keyboard_check(G.arriba) or (GM.keyboard_check(G.abajo) and state == 2.0)) and disablecontrols == 0.0:
			_user_15()
			if hspeed > 0.0:
				direct = 1.0
			elif hspeed < 0.0:
				direct = -1.0
			x = (climb1.x + 8.0)
			state = 3.0
			speed = 0.0
			gravity = 0.0
			canhang = 1.0
			alarm[6] = 8.0
	else:
		climb1 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false)
		if climb1 != null and (((y + 19.0) > climb1.y and climb1.object_index == A.obj_vine_green and climb1.image_index == 0.0) or climb1.object_index != A.obj_vine_green or climb1.image_index != 0.0) and G.yoshi == 0.0 and isduck == 0.0 and (GM.keyboard_check(G.arriba) or (GM.keyboard_check(G.abajo) and state == 2.0)) and holding == 0.0 and disablecontrols == 0.0:
			_user_15()
			state = 3.0
			gravity = 0.0
			speed = 0.0
			walljump = 0.0
	#
	# if (keyboard_check_pressed(global.abajo) && disablecontrols == 0 && holding == 0 && global.apariencia != 0)
	# {
	#    if ((global.powerup == -37 || global.powerup == -38) && state == 1)
	#    {
	#        with (instance_create(x, y, obj_slider))
	#            event_user(0)
	#    }
	#    else if (collision_point(bbox_right, (bbox_bottom + 1), obj_slopeparent, 1, 0) or collision_point(bbox_left, (bbox_bottom + 1), obj_slopeparent, 1, 0))
	#        instance_create(x, y, obj_slider)
	# }
	if stompstyle == 1.0:
		if state != 2.0:
			stompstyle = 0.0
	if G.powerup == -39.0:
		if disablegrav > 0.0:
			if state != 2.0:
				disablegrav = 0.0
			else:
				ygrav = 0.0
				disablegrav -= 1.0
		else:
			ygrav = 1.0
	else:
		disablegrav = 0.0
	if G.powerup == -85.0:
		if GM.keyboard_check(G.lanzar_agarrar):
			if GM.keyboard_check_pressed(G.abajo) and disablecontrols == 0.0 and holding == 0.0 and G.yoshi == 0.0 and inclown == 0.0 and state == 0.0 and arrow == 0.0 and down_atack == 0.0 and dash_atack == 0.0:
				dash_atack = 1.0
		if dash_atack == 1.0:
			isduck = 0.0
			hspeed = 0.0
			dash_cont += 1.0
			if not GM.instance_exists(A.obj_link_dash_atack):
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_link_dash_atack)):
					if self.direct == -1.0:
						inst.mask_index = A.spr_SMB_link_atack_mask
			if dash_cont == 40.0:
				GM.audio_play_sound(A.snd_SMB_link_charge, 0.0, false)
				if not GM.instance_exists(A.obj_effect_link):
					for inst in GM.with_list(GM.instance_create(x, (y + 16.0), A.obj_effect_link)):
						inst.set("arrow", 0.0)
			if dash_cont > 50.0:
				dash_atack = 2.0
		elif dash_atack == 2.0:
			isduck = 0.0
			if hspeed > 0.0 and hspeed > hspeedmax:
				hspeed = hspeedmax
			elif hspeed < 0.0 and hspeed < (-hspeedmax):
				hspeed = (-hspeedmax)
			else:
				hspeed += (0.25 * direct)
		if GM.keyboard_check_pressed(G.abajo) and disablecontrols == 0.0 and (not place_meeting(x, y, A.obj_bortice)) and isduck == 0.0 and holding == 0.0 and G.yoshi == 0.0 and inclown == 0.0 and state == 2.0 and down_atack == 0.0 and dash_atack == 0.0 and arrow == 0.0:
			image_index = 0.0
			down_atack = 1.0
			hspeed = 0.0
			vspeed = 0.0
			disablecontrols = 2.0
			GM.audio_play_sound(A.snd_SMB_link_sword, 0.0, false)
			if not GM.instance_exists(A.obj_link_dash_atack):
				GM.instance_create(x, y, A.obj_link_down_atack)
		if GM.keyboard_check_pressed(G.arriba) and disablecontrols == 2.0 and state == 2.0 and down_atack != 0.0:
			down_atack = 0.0
			down_cont = 0.0
			disablecontrols = 0.0
		if down_atack == 1.0:
			down_cont += 1.0
			if down_cont > 20.0:
				down_atack = 2.0
				down_cont = 0.0
				vspeed = 1.5
		if GM.keyboard_check(G.lanzar_agarrar):
			if GM.keyboard_check_pressed(G.arriba) and (not GM.instance_exists(A.obj_link_bomb)) and (not place_meeting(x, y, A.obj_door)) and (not place_meeting(x, y, A.obj_door_exit)) and (not place_meeting(x, y, A.obj_door_switch)) and (not place_meeting(x, y, A.obj_door_switch_exit)) and (not place_meeting(x, y, A.obj_door_lock)) and (not place_meeting(x, y, A.obj_door_lock_exit)) and disablecontrols == 0.0 and isduck == 0.0 and state < 3.0 and holding == 0.0 and G.yoshi == 0.0 and inclown != 1.0 and down_atack == 0.0 and dash_atack == 0.0 and arrow == 0.0:
				GM.audio_play_sound(A.snd_SMB_link_pull, 0.0, false)
				holding = 2.0
				GM.instance_create(x, (y + 1.0), A.obj_link_bomb)
		if GM.keyboard_check(G.saltar_spin) and GM.instance_number(A.obj_link_arrow) < 2 and disablecontrols == 0.0 and isduck == 0.0 and holding == 0.0 and G.yoshi == 0.0 and inclown != 1.0 and down_atack == 0.0 and dash_atack == 0.0 and arrow == 0.0:
			arrow = 2.0
			GM.instance_create(x, y, A.obj_link_arrow_anim)
		if arrow > 0.0 and arrow_ready == 1.0:
			if GM.keyboard_check_pressed(G.arriba) and (not GM.keyboard_check(G.abajo)):
				if arrow > 1.0:
					arrow -= 1.0
			elif GM.keyboard_check_pressed(G.abajo) and (not GM.keyboard_check(G.arriba)):
				if arrow < 3.0:
					arrow += 1.0
	if arrow > 0.0 and (GM.keyboard_check_released(G.saltar_spin) or state > 2.0 or G.powerup != -85.0):
		if arrow_ready == 1.0:
			match arrow:
				1.0:
					posy = 20.0
				2.0:
					posy = 23.0
				3.0:
					posy = 25.0
			for inst in GM.with_list(GM.instance_create((x + (6.0 * direct)), (y + posy), A.obj_link_arrow)):
				inst.set("direct", self.direct)
				inst.set("type", self.arrow)
		arrow = 0.0
		arrow_ready = 0.0
	if dash_atack > 0.0 and (GM.keyboard_check_released(G.lanzar_agarrar) or state > 2.0 or G.powerup != -85.0):
		dash_atack = 0.0
		dash_cont = 0.0
	if G.apariencia == 0.0 and G.powerup != -85.0 and holding != 0.0:
		holding = 0.0
	if state == 2.0 and isduck == 0.0 and disablecontrols == 0.0:
		if GM.keyboard_check(G.saltar) and (not GM.keyboard_check(G.saltar_spin)) and G.powerup == 3.0 and pmeter > 5.0 and stompstyle == 0.0 and canfly == 0.0:
			vspeed = -3.5
			fly_cap += 2.0
			if fly_cap > 145.0:
				canfly = 1.0
				jumpnow = 2.0
				fly_cap = 0.0
				for inst in GM.with_list(A.obj_levelmanager):
					inst.set("pmeter", 0.0)
					inst.alarm[7] = 15.0
				if GM.keyboard_check(G.lanzar_agarrar) and holding == 0.0:
					modo_vuelo = 1.0
					vspeed = 0.4
			jumpnow = 1.0
		if GM.keyboard_check_released(G.saltar) and G.powerup == 3.0 and pmeter > 5.0 and canfly == 0.0:
			for inst in GM.with_list(A.obj_levelmanager):
				inst.set("pmeter", 0.0)
				inst.alarm[7] = 15.0
			canfly = 1.0
			jumpnow = 2.0
			fly_cap = 0.0
			if GM.keyboard_check(G.lanzar_agarrar) and holding == 0.0:
				modo_vuelo = 1.0
		if vspeed < 0.0 and collision_rectangle((bbox_left - 3.0), bbox_top, (bbox_right + 3.0), bbox_top, A.obj_solid, true, false) != null and G.powerup == 3.0 and pmeter > 5.0 and canfly == 0.0 and stompstyle == 0.0:
			for inst in GM.with_list(A.obj_levelmanager):
				inst.set("pmeter", 0.0)
				inst.alarm[7] = 15.0
			canfly = 1.0
			jumpnow = 2.0
			fly_cap = 0.0
			if GM.keyboard_check(G.lanzar_agarrar) and holding == 0.0:
				modo_vuelo = 1.0
		if GM.keyboard_check_released(G.lanzar_agarrar) and G.powerup == 3.0 and modo_vuelo == 1.0 and canfly == 1.0:
			modo_vuelo = 0.0
		if GM.keyboard_check(G.lanzar_agarrar) and G.powerup == 3.0 and modo_vuelo == 1.0 and canfly == 1.0:
			if (GM.keyboard_check_pressed(G.izquierda) and direct == 1.0) or (GM.keyboard_check_pressed(G.derecha) and direct == -1.0):
				vspeed = 3.0
				if sprite_index == A.spr_mario_cap_fly or sprite_index == A.spr_luigi_cap_fly or sprite_index == A.spr_toad_cap_fly or sprite_index == A.spr_toadette_cap_fly:
					if image_index > (image_number - 2.0):
						image_index = 0.0
						image_speed = 0.15
						sprite_index = Scr.scr_mario_cap_fly_acender(self)
			if (GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and direct == 1.0) or (GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and direct == -1.0):
				if sprite_index == A.spr_mario_cap_fly or sprite_index == A.spr_luigi_cap_fly or sprite_index == A.spr_toad_cap_fly or sprite_index == A.spr_toadette_cap_fly:
					if image_index > (image_number - 1.0):
						image_index = 0.0
						image_speed = 0.18
						sprite_index = Scr.scr_mario_cap_fly_decender(self)
			if (GM.keyboard_check_released(G.derecha) and direct == 1.0) or (GM.keyboard_check_released(G.izquierda) and direct == -1.0):
				if sprite_index == A.spr_mario_cap_fly_decender or sprite_index == A.spr_luigi_cap_fly_decender or sprite_index == A.spr_toad_cap_fly_decender or sprite_index == A.spr_toadette_cap_fly_decender:
					if image_index == 2.0:
						image_index = 0.0
						image_speed = 0.2
						sprite_index = Scr.scr_mario_cap_fly_acender_decender(self)
						fly_high = 6.0
					else:
						image_index = 0.0
						image_speed = 0.15
						sprite_index = Scr.scr_mario_cap_fly_acender(self)
		if GM.keyboard_check(G.saltar_spin) and (not GM.keyboard_check(G.saltar)) and G.powerup == 3.0 and pmeter > 5.0 and canfly == 0.0:
			vspeed = -3.5
			fly_cap += 2.0
			if fly_cap > 145.0:
				canfly = 1.0
				jumpnow = 2.0
				fly_cap = 0.0
			jumpnow = 1.0
		if GM.keyboard_check_released(G.saltar_spin) and G.powerup == 3.0 and pmeter > 5.0 and canfly == 1.0:
			jumpnow = 2.0
			fly_cap = 0.0
		elif GM.keyboard_check_released(G.saltar_spin) and G.powerup == 3.0 and pmeter > 5.0 and canfly == 0.0:
			canfly = 1.0
			jumpnow = 2.0
			fly_cap = 0.0
	if state == 2.0 and stompstyle == 0.0 and disablecontrols == 0.0 and (G.yoshi == 0.0 or G.yoshi == 2.0):
		if G.powerup == -39.0 and GM.keyboard_check_pressed(G.saltar) and jumpnow != 1.0 and wiggle < 12.0 and sprite_index != Scr.scr_mariojumpstar(self):
			if not GM.audio_is_playing(A.snd_atack_leaf):
				GM.audio_play_sound(A.snd_atack_leaf, 0.0, false)
			wiggle = 16.0
			disablegrav = 8.0
			if pmeter > 5.0:
				vspeed = -1.5
			elif vspeed < 0.0:
				vspeed = maxf((vspeed + 0.05), 0.0)
			else:
				vspeed = 0.0


# from objects/obj_mario/Other_13.gml
func _user_3() -> void:
	var climb1  # 局部变量提升（GML 的 var 是函数作用域）
	var posy  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Mario's swimming step event
	col_enemigos = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_enemyparent, false, false)
	if (G.powerup == -80.0) and (Scr.scr_canpull(self) > 0.5 and ((not GM.instance_exists(A.obj_puller)) and (holding == 0.0))):
		enemigo = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_enemyparent, false, false)
		hold = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_holdparent, false, false)
		nube = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_nube, false, false)
		if nube != null:
			GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
			c_nube = GM.instance_create(x, y, A.obj_puller)
			c_nube.set("cloud", 1.0)
			c_nube.set("obj", nube)
		elif enemigo != null and ((enemigo.get("hardness") < 99.0) or (enemigo.object_index == A.obj_banzaibill)):
			GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
			c_enemy = GM.instance_create(x, y, A.obj_puller)
			c_enemy.set("enemy", 1.0)
			c_enemy.set("obj", enemigo)
		elif hold != null and ((hold.object_index != A.obj_pswitch) and (hold.object_index != A.obj_spring)):
			GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
			c_enemy = GM.instance_create(x, y, A.obj_puller)
			c_enemy.set("held", 1.0)
			c_enemy.set("obj", hold)
		elif G.bg_level == "snow":
			GM.audio_play_sound(A.snd_SMB2_get, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_puller)):
				inst.set("snowball", 1.0)
	if gravity == 0.0 and collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or (collision_rectangle(bbox_left, bbox_bottom + 1.0, bbox_right, bbox_bottom + 1.5, A.obj_slopeparent, true, false) != null) or ((col_enemigos != null and ((G.powerup == -80.0) and ((col_enemigos.get("stomp") != 1.0) and ((col_enemigos.get("stomp") != 2.0) and (col_enemigos.get("stomp") != 5.0)))))):
		if vspeed >= 0.0 and (not GM.instance_exists(A.obj_mario_transform2)):
			statedelay = 0.0
			if hspeed == 0.0:
				state = 0.0
			else:
				state = 1.0
			if G.yoshi == 0.0 and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsizable, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_modelsolid, false, false) == null) and (collision_rectangle((bbox_left + 3.0), (bbox_bottom + 1.0), (bbox_right - 3.0), (bbox_bottom + 1.0), A.obj_rockparent, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 8.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null):
				_user_0()
		elif vspeed < 0.0:
			state = 2.0
		if groundpount == 1.0:
			groundpount = 0.0
		if down_atack == 0.0 and disablecontrols == 2.0:
			disablecontrols = 0.0
	else:
		statedelay += 1.0
		if statedelay > 4.0:
			state = 2.0
		gravity = 0.03
	if G.powerup == -29.0:
		gravity = 0.0
		if GM.keyboard_check(G.lanzar_agarrar) or G.key_br == 1.0:
			hspeedmax = 2.0
		else:
			hspeedmax = 1.0
		if GM.keyboard_check(G.izquierda) and isduck == 0.0 and (not GM.keyboard_check(G.derecha)):
			hspeed += -0.2
			direct = -1.0
			swimtype = 0.0
			if image_index > 1.0 and image_index < 1.5:
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
		elif GM.keyboard_check(G.derecha) and isduck == 0.0 and (not GM.keyboard_check(G.izquierda)):
			hspeed += 0.2
			direct = 1.0
			swimtype = 0.0
			if image_index > 1.0 and image_index < 1.5:
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
		else:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.2)) * GM.gm_sign(hspeed))
			if hspeed < 0.2 and hspeed > -0.2:
				hspeed = 0.0
		if GM.keyboard_check(G.arriba):
			vspeed += -0.2
			if hspeed == 0.0:
				swimtype = 1.0
			if image_index > 1.0 and image_index < 1.5:
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
		elif GM.keyboard_check(G.abajo):
			if hspeed == 0.0:
				swimtype = 2.0
			if collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, true, false) != null:
				vspeed = 0.0
			else:
				vspeed += 0.2
			if image_index > 1.0 and image_index < 1.5:
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
		else:
			vspeed = (maxf(0.0, (absf(vspeed) - 0.2)) * GM.gm_sign(vspeed))
			if vspeed < 0.2 and vspeed > -0.2:
				vspeed = 0.0
		if GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and G.yoshi > 0.0:
			vspeed = -2.0
			GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
			state = 2.0
			isduck = 0.0
			G.yoshi = 0.0
			holding = 0.0
			if GM.instance_exists(A.obj_kuriboshoe):
				var _o1: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_kuriboshoe):
					inst.event_user(0)
				GM.other = _o1
		if hspeed > hspeedmax:
			hspeed = hspeedmax
		if hspeed < (-hspeedmax):
			hspeed = (-hspeedmax)
		if vspeed > hspeedmax:
			vspeed = hspeedmax
		if vspeed < (-hspeedmax):
			vspeed = (-hspeedmax)
	else:
		if holding == 0.0 or holding == 3.0:
			if vspeed > 1.0:
				vspeed = 1.0
			if vspeed < -1.5:
				vspeed = -1.5
			if GM.keyboard_check_pressed(G.saltar) and disablecontrols == 0.0:
				if state < 2.0:
					vspeed = -1.0
				elif vspeed > 0.0:
					vspeed = (-((vspeed + 0.18)))
				else:
					vspeed -= 0.6
				if G.powerup == -85.0 and arrow > 0.0:
					if sprite_index != Scr.scr_link_arrow_swim(self, arrow):
						image_index = 0.0
					sprite_index = Scr.scr_link_arrow_swim(self, arrow)
				else:
					if sprite_index != Scr.scr_marioswim(self):
						image_index = 0.0
					sprite_index = Scr.scr_marioswim(self)
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
				state = 2.0
				isduck = 0.0
				isduckhold = 0.0
			if GM.keyboard_check_released(G.saltar) and new_swim == 1.0:
				new_swim = 0.0
				sprite_index = Scr.scr_NSMBU_swim(self)
				image_index = 8.0
			if GM.keyboard_check_pressed(G.saltar_spin) and disablecontrols == 0.0 and holding == 3.0 and G.yoshi > 0.0:
				vspeed = -1.0
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
				state = 2.0
				isduck = 0.0
				isduckhold = 0.0
				G.yoshi = 0.0
				holding = 0.0
				if GM.instance_exists(A.obj_yoshi2):
					var _o2: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_yoshi2):
						inst.event_user(1)
					GM.other = _o2
				if GM.instance_exists(A.obj_kuriboshoe):
					stompstyle = 0.0
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(A.obj_kuriboshoe):
						inst.event_user(0)
					GM.other = _o3
			if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed += 0.05
				direct = 1.0
			elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed -= 0.05
				direct = -1.0
			else:
				if hspeed > 0.0:
					hspeed -= 0.05
				if hspeed < 0.0:
					hspeed += 0.05
				if absf(hspeed) < 0.05:
					hspeed = 0.0
			if G.powerup == -85.0:
				if GM.keyboard_check(G.lanzar_agarrar):
					if GM.keyboard_check_pressed(G.arriba) and (not GM.instance_exists(A.obj_link_bomb)) and (not place_meeting(x, y, A.obj_door)) and (not place_meeting(x, y, A.obj_door_exit)) and (not place_meeting(x, y, A.obj_door_switch)) and (not place_meeting(x, y, A.obj_door_switch_exit)) and (not place_meeting(x, y, A.obj_door_lock)) and (not place_meeting(x, y, A.obj_door_lock_exit)) and disablecontrols == 0.0 and isduck == 0.0 and holding == 0.0 and state < 3.0 and G.yoshi == 0.0 and inclown != 1.0 and down_atack == 0.0 and dash_atack == 0.0 and arrow == 0.0:
						GM.audio_play_sound(A.snd_SMB_link_pull, 0.0, false)
						holding = 2.0
						GM.instance_create(x, (y + 1.0), A.obj_link_bomb)
				if GM.keyboard_check(G.saltar_spin) and GM.instance_number(A.obj_link_arrow) < 2 and disablecontrols == 0.0 and isduck == 0.0 and holding == 0.0 and G.yoshi == 0.0 and inclown != 1.0 and down_atack == 0.0 and dash_atack == 0.0 and arrow == 0.0:
					arrow = 2.0
					GM.instance_create(x, y, A.obj_link_arrow_anim)
				if arrow > 0.0 and arrow_ready == 1.0:
					if GM.keyboard_check_pressed(G.arriba) and (not GM.keyboard_check(G.abajo)):
						if arrow > 1.0:
							arrow -= 1.0
					elif GM.keyboard_check_pressed(G.abajo) and (not GM.keyboard_check(G.arriba)):
						if arrow < 3.0:
							arrow += 1.0
				if arrow > 0.0 and (GM.keyboard_check_released(G.saltar_spin) or state == 4.0 or G.powerup != -85.0):
					if arrow_ready == 1.0:
						match arrow:
							1.0:
								posy = 20.0
							2.0:
								posy = 23.0
							3.0:
								posy = 25.0
						for inst in GM.with_list(GM.instance_create((x + (6.0 * direct)), (y + posy), A.obj_link_arrow)):
							inst.set("direct", self.direct)
							inst.set("type", self.arrow)
					arrow = 0.0
					arrow_ready = 0.0
		else:
			vspeed -= 0.5
			if vspeed < -1.0:
				vspeed = -1.0
			if vspeed > 1.0:
				vspeed = 1.0
			if GM.keyboard_check_pressed(G.abajo) and disablecontrols == 0.0:
				GM.audio_stop_sound(Scr.scr_swim(self))
				GM.audio_play_sound(Scr.scr_swim(self), 0.0, false)
			if GM.keyboard_check(G.abajo) and disablecontrols == 0.0:
				if vspeed < 0.0:
					vspeed = ((-vspeed) + 0.18)
				else:
					vspeed += 0.6
			if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed += 0.05
				direct = 1.0
			elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and disablecontrols == 0.0 and (isduck == 0.0 or state == 2.0):
				hspeed -= 0.05
				direct = -1.0
			elif direct == 1.0:
				hspeed += 0.05
				if hspeed > 0.5:
					hspeed = 0.5
			else:
				hspeed -= 0.05
				if hspeed < -0.5:
					hspeed = -0.5
		if state == 2.0:
			if hspeed > 1.0:
				hspeed = 1.0
			if hspeed < -1.0:
				hspeed = -1.0
		else:
			if hspeed > 0.5:
				hspeed = 0.5
			if hspeed < -0.5:
				hspeed = -0.5
	if noisy == 1.0:
		noisy = 0.0
		GM.audio_stop_sound(Scr.scr_swim(self))
	if G.apariencia == 0.0:
		climb1 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false)
		if climb1 != null and (((y + 19.0) > climb1.y and climb1.object_index == A.obj_vine_green and climb1.image_index == 0.0) or climb1.object_index != A.obj_vine_green or climb1.image_index != 0.0) and G.yoshi == 0.0 and isduck == 0.0 and dash_atack == 0.0 and down_atack == 0.0 and arrow == 0.0 and holding == 0.0 and (GM.keyboard_check(G.arriba) or (GM.keyboard_check(G.abajo) and state == 2.0)) and disablecontrols == 0.0:
			if hspeed > 0.0:
				direct = 1.0
			elif hspeed < 0.0:
				direct = -1.0
			x = (climb1.x + 8.0)
			state = 3.0
			speed = 0.0
			gravity = 0.0
			canhang = 1.0
			alarm[6] = 8.0
	else:
		climb1 = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false)
		if climb1 != null and (((y + 19.0) > climb1.y and climb1.object_index == A.obj_vine_green and climb1.image_index == 0.0) or climb1.object_index != A.obj_vine_green or climb1.image_index != 0.0) and G.yoshi == 0.0 and isduck == 0.0 and (GM.keyboard_check(G.arriba) or (GM.keyboard_check(G.abajo) and state == 2.0)) and holding == 0.0 and disablecontrols == 0.0:
			state = 3.0
			gravity = 0.0
			speed = 0.0
	if GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach") and (y + 16.0) <= (GM.instance_find(A.obj_lava_water, 0).y - 4.0):
		isswim = 0.0
		if place_meeting(x, (y + 16.0), A.obj_lava_water):
			if G.apariencia != 0.0 and vspeed > 0.0:
				GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
			if GM.keyboard_check(G.saltar):
				vspeed = -4.125
				jumpnow = 1.0
				if G.apariencia != 0.0:
					GM.instance_create(x, (GM.instance_find(A.obj_lava_water, 0).y - 26.0), A.obj_splash_agua)
		if noisy == 1.0:
			noisy = 0.0
			GM.audio_stop_sound(Scr.scr_swim(self))
	if G.yoshi != 2.0:
		stompstyle = 0.0


# from objects/obj_mario/Other_14.gml
func _user_4() -> void:
	# / @description Mario's climbing step event
	if disablecontrols == 0.0:
		if G.apariencia == 0.0:
			jumpnow = 0.0
			if GM.keyboard_check_pressed(G.derecha):
				var liana_right = collision_point((x + 16.0), (y + 18.0), A.obj_climb, false, false)
				if direct == -1.0 and liana_right != null and (collision_point((x + 16.0), (y + 18.0), A.obj_solid, false, false) == null) and (collision_point((x + 16.0), (y + 18.0), A.obj_physicssolid, false, false) == null) and (collision_point((x + 16.0), (y + 18.0), A.obj_solidphy, false, false) == null) and (collision_point((x + 16.0), (y + 18.0), A.obj_bullebill_base, false, false) == null) and (collision_point((x + 16.0), (y + 18.0), A.obj_onewaygate_left, false, false) == null):
					x = (liana_right.x + 8.0)
					direct = 1.0
				else:
					direct = -1.0
			elif GM.keyboard_check_pressed(G.izquierda):
				var liana_left = collision_point((x - 16.0), (y + 18.0), A.obj_climb, false, false)
				if direct == 1.0 and liana_left != null and (collision_point((x - 16.0), (y + 18.0), A.obj_solid, false, false) == null) and (collision_point((x - 16.0), (y + 18.0), A.obj_physicssolid, false, false) == null) and (collision_point((x - 16.0), (y + 18.0), A.obj_solidphy, false, false) == null) and (collision_point((x - 16.0), (y + 18.0), A.obj_bullebill_base, false, false) == null) and (collision_point((x - 16.0), (y + 18.0), A.obj_onewaygate_right, false, false) == null):
					x = (liana_left.x + 8.0)
					direct = -1.0
				else:
					direct = 1.0
			if GM.keyboard_check(G.arriba) and (not GM.keyboard_check(G.abajo)):
				if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_climb, false, false) == null:
					vspeed = 0.0
				elif GM.keyboard_check(G.lanzar_agarrar):
					vspeed = -1.5
				else:
					vspeed = -1.0
			elif GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)):
				if GM.keyboard_check(G.lanzar_agarrar):
					vspeed = 1.5
				else:
					vspeed = 1.0
				if collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, true, false) != null:
					state = 0.0
					jumpnow = 0.0
			else:
				vspeed = 0.0
			if GM.keyboard_check_pressed(G.saltar) or GM.keyboard_check_pressed(G.saltar_spin):
				GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
				state = 2.0
				jumpnow = 1.0
				if isswim == 1.0:
					vspeed = -1.8
				else:
					vspeed = -3.75
			if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false) == null:
				if vspeed < 0.0:
					vspeed = 0.0
				else:
					state = 2.0
		else:
			if GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)):
				hspeed += 0.15
				if GM.keyboard_check(G.lanzar_agarrar):
					if hspeed > 1.5:
						hspeed = 1.5
				elif hspeed > 1.0:
					hspeed = 1.0
				direct = 1.0
			elif GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)):
				hspeed += -0.15
				if GM.keyboard_check(G.lanzar_agarrar):
					if hspeed < -1.5:
						hspeed = -1.5
				elif hspeed < -1.0:
					hspeed = -1.0
				direct = -1.0
			else:
				hspeed = 0.0
			if GM.keyboard_check(G.arriba) and (not GM.keyboard_check(G.abajo)):
				if collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_top - 1.0), A.obj_solid, false, false) == null:
					if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_climb, false, false) == null:
						vspeed = 0.0
					else:
						vspeed += -0.15
						if GM.keyboard_check(G.lanzar_agarrar):
							if vspeed < -1.5:
								vspeed = -1.5
						elif vspeed < -1.0:
							vspeed = -1.0
			elif GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)):
				vspeed += 0.15
				if GM.keyboard_check(G.lanzar_agarrar):
					if vspeed > 1.5:
						vspeed = 1.5
				elif vspeed > 1.0:
					vspeed = 1.0
				if collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null:
					state = 0.0
					jumpnow = 0.0
			else:
				vspeed = 0.0
			if GM.keyboard_check_pressed(G.saltar) or GM.keyboard_check_pressed(G.saltar_spin):
				if isswim == 1.0:
					vspeed = -1.8
				else:
					vspeed = -3.75
				GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
				jumpnow = 1.0
				state = 2.0
			if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_climb, false, false) == null:
				state = 2.0
	else:
		speed = 0.0


# from objects/obj_mario/Other_15.gml
func _user_5() -> void:
	# / @description Mario's wall climbing + wall jumping step event
	# If Mario reaches the floor
	if collision_rectangle(bbox_left, bbox_bottom + 1.0, bbox_right, bbox_bottom + 1.5, A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, bbox_bottom + 1.0, bbox_right, bbox_bottom + 1.5, A.obj_slopeparent, true, false) != null:
		# Switch to the jump state
		state = 2.0
		# Disable variable jumping
		jumpnow = 0.0
		# Do not execute the rest of this event
		return


# from objects/obj_mario/Other_16.gml
func _user_6() -> void:
	# / @description Give Mario temporary invincibility
	# If Mario is not star invincible
	if invincible != -1.0:
		# Make Mario invincible
		invincible = 1.0
		# Make Mario's alpha blink
		alarm[1] = 1.0
		# Make Mario not invincible after a cooldown
		alarm[3] = 120.0


# from objects/obj_mario/Other_17.gml
func _user_7() -> void:
	# / @description Make Mario kick something
	# Mario is now kicking
	iamkicking = 1.0
	# Set image_index to 0
	image_index = 0.0
	# Finish kicking animation
	if G.apariencia != 3.0:
		alarm[6] = 16.0


# from objects/obj_mario/Other_18.gml
func _user_8() -> void:
	GM.audio_play_sound(A.snd_thwomp_original, 0.0, false)
	if GM.instance_exists(A.obj_levelmanager):
		for inst in GM.with_list(A.obj_levelmanager):
			inst.alarm[11] = 1.0
	if GM.instance_exists(A.obj_enemyparent):
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_enemyparent):
			if inst.vspeed == 0.0 and inst.get("hardness") < 99.0 and inst.object_index != A.obj_grinder and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.set("dead_h", 1.0)
				inst.event_user(0)
		GM.other = _o1
	if GM.instance_exists(A.obj_boomboom):
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_boomboom):
			if inst.vspeed == 0.0 and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.set("dead_h", 1.0)
				inst.event_user(0)
		GM.other = _o2
	if GM.instance_exists(A.obj_muncher):
		var _o3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_muncher):
			if inst.vspeed == 0.0 and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.set("dead_h", 1.0)
				inst.event_user(0)
		GM.other = _o3


# from objects/obj_mario/Other_24.gml
func _user_14() -> void:
	# / @description Stop these sounds from playing
	if skidnow == 1.0:
		GM.audio_stop_sound(Scr.scr_snd_skid(self))
	if noisy == 1.0:
		GM.audio_stop_sound(Scr.scr_swim(self))
	GM.audio_stop_sound(A.snd_NSMBU_desllizarse_walljump)
	GM.audio_stop_sound(A.snd_NSMBU_helice_planear)
	GM.audio_stop_sound(A.snd_NSMBU_squirrel_plan)
	GM.audio_stop_sound(A.snd_NSMBU_vine_up)


# from objects/obj_mario/Other_25.gml
func _user_15() -> void:
	# / @description Reset some variables
	modo_vuelo = 0.0
	stompstyle = 0.0
	airspin = 0.0
	airspin_count = 0.0
	helice_fly = 0.0
	helice_fly_temp = 0.0
	if jumpnow != 0.0:
		jumpnow_temp = 1.0
	jumpnow = 0.0
	doublejump = 0.0
	arcon_slide = 0.0
	squirrel_fly = 0.0
	down_atack = 0.0
	down_cont = 0.0
	hitpoint = 0.0
	canfly = 0.0
	walljump = 0.0
	jump_type = 0.0
	disable_doublejump = 0.0


# from objects/obj_mario/Draw_0.gml
func _gm_draw() -> void:
	var posyy  # 局部变量提升（GML 的 var 是函数作用域）
	# / @description Draws Mario
	# Draw Mario
	if state == 3.0 and G.apariencia == 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, (x - (6.0 * direct)), (y + 1.0), direct, image_yscale, 0.0, GM.c_white, image_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) + shake), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
	if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
		# Make Mario flash
		GM.shader_set(A.sha_blendreplace)
		if state == 3.0 and G.apariencia == 0.0:
			GM.draw_sprite_ext(sprite_index, image_index, (x - (6.0 * direct)), (y + 1.0), direct, image_yscale, 0.0, blend_star, GM.instance_find(A.obj_invincibility, 0).get("flashAlpha"))
		else:
			GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) + shake), (GM.gm_round(y) + 1.0), direct, 1.0, 0.0, blend_star, GM.instance_find(A.obj_invincibility, 0).get("flashAlpha"))
		# Reset flashing
		GM.shader_reset()
	if helice_fly == 4.0:
		GM.draw_sprite(A.spr_NSMBU_mario_helice_remolino, image_index, x, (y + 1.0))
	if G.condiciones == 1.0 and G.condiciones_clear == 1.0:
		if G.powerup == 0.0 or G.powerup == -85.0:
			posyy = 1.0
		else:
			posyy = 11.0
		if G.apariencia > 1.0:
			sprite_cond = A.spr_condicion_obtenida
		else:
			sprite_cond = A.spr_SMB3_condicion_obtenida
		GM.draw_sprite(sprite_cond, G.jugador, (x - 19.0), (y - posyy))
	#
	# draw_text(x, y, string(hspeed));
	# draw_text(x+20, y, string(vspeed));
