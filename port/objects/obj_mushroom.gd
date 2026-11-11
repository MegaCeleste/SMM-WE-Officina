extends "res://objects/obj_powerupparent.gd"

var t_mario: String = ""
var jump: float = 0.0
var jump2: float = 0.0
var position: float = 0.0
var path_position: float = 0.0  # GML 内置的路径变量，GMObject 没有；这里只当普通变量用（原版只在 Create 里赋 0）
var delay: float = 0.0


# from objects/obj_mushroom/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_mushroom
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_index = A.spr_SMB3_mushroom
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_mushroom
			sprite_wings = A.spr_NSMBU_wings_items
	if G.apariencia == 3.0:
		image_speed = 0.25
	else:
		image_speed = 0.0
	swimming = 0.0
	t_mario = ""
	jump = 0.0
	jump2 = 0.0
	direct = -1.0
	wings = 0.0
	wings_anim = 0.0
	position = 0.0
	path_position = 0.0
	paracaidas = 0.0
	delay = 0.0
	progresivo = 0.0
	alarm[10] = 4.0


# from objects/obj_mushroom/Step_1.gml
func _step_begin() -> void:
	#
	# if (path_exists(obj_rails.pathIndex)) {
	#    var totalLength = path_get_length(obj_rails.pathIndex);
	#
	#    path_position += 0.2 / totalLength; // Update the path position
	#
	#    if (path_position >= 1) {
	#        path_position -= 1; // Wrap the path position to stay within range
	#    }
	#
	#    var offset = obj_rails.drawX - obj_rails.x;
	#    x = path_get_x(obj_rails.pathIndex, path_position) + offset;
	#    y = path_get_y(obj_rails.pathIndex, path_position + 4); // Update the item's y position
	# }
	# /*
	pass


# from objects/obj_mushroom/Step_0.gml
func _step() -> void:
	super._step()
	if wings == 0.0:
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0):
			if hspeed > 1.0:
				hspeed -= 0.08
				if hspeed <= 0.5:
					hspeed = 0.5
			elif hspeed < -1.0:
				hspeed += 0.08
				if hspeed > -0.5:
					hspeed = -0.5
		elif hspeed > 1.0:
			hspeed -= 0.08
			if hspeed < 1.0:
				hspeed = 1.0
		elif hspeed < -1.0:
			hspeed += 0.08
			if hspeed > -1.0:
				hspeed = -1.0
	if G.modo_noche == 1.0 and G.bg_level == "ground" and wings == 0.0 and gravity == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			if jump == 0.0 and (not place_meeting(x, (y - 16.0), A.obj_solid)):
				GM.audio_stop_sound(A.snd_rotten)
				GM.audio_play_sound(A.snd_rotten, 0.0, false)
				vspeed = -2.0
				y -= 1.0
				jump = 1.0
			jump2 = 0.0
			hspeed = 1.0
		else:
			if jump2 == 0.0 and (not place_meeting(x, (y - 16.0), A.obj_solid)):
				GM.audio_stop_sound(A.snd_rotten)
				GM.audio_play_sound(A.snd_rotten, 0.0, false)
				vspeed = -2.0
				y -= 1.0
				jump2 = 1.0
			jump = 0.0
			hspeed = -1.0
		GM.audio_stop_sound(A.snd_rotten)
		GM.audio_play_sound(A.snd_rotten, 0.0, false)
		vspeed = -3.0
		if delay > 0.0:
			delay -= 1.0


# from objects/obj_mushroom/Alarm_0.gml
func _alarm_0() -> void:
	if gravity == 0.0:
		vspeed = -3.0
		y -= 1.0
		if G.modo_noche == 1.0:
			alarm[0] = 90.0
	elif G.modo_noche == 1.0:
		alarm[0] = 90.0


# from objects/obj_mushroom/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0 and paracaidas == 0.0:
		hspeed = (0.5 * direct)
		vspeed = -0.5
	elif paracaidas == 1.0:
		hspeed = -0.6
	elif paracaidas == 0.0:
		if vspeed < 0.0 or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null:
			if G.modo_noche == 1.0:
				if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
					hspeed = (1.0 - (0.5 * swimming))
				else:
					hspeed = (-((1.0 - (0.5 * swimming))))
			else:
				hspeed = (1.0 - (0.5 * swimming))
		else:
			alarm[10] = 2.0


# from objects/obj_mushroom/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and other.y < (other.ystart - 2.0) and bbox_bottom < (other.yprevious + 5.0) and wings == 0.0:
		if collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				if G.apariencia == 3.0:
					inst.sprite_index = A.spr_NSMBU_smoke_flag
			instance_destroy()
		else:
			if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0):
				vspeed = -1.8
			else:
				vspeed = -3.0
			if hspeed == 0.0:
				hspeed = 1.0
			elif (x + (sprite_width / 2.0)) > (other.x + (sprite_width / 2.0)):
				hspeed = 1.0
			elif (x + (sprite_width / 2.0)) < (other.x + (sprite_width / 2.0)):
				hspeed = -1.0
	elif other.vspeed > 0.0 and other.bbox_bottom < (bbox_top + 4.0) and vspeed == 0.0 and gravity == 0.0:
		GM.instance_create(x, y, A.obj_smoke)
		instance_destroy()


# from objects/obj_mushroom/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	if GM.instance_exists(A.obj_mario_transform2) or GM.instance_exists(A.obj_frozenmario):
		return
	if G.powerup != 0.0 and (collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(other.bbox_left, (other.bbox_top - 16.0), other.bbox_right, other.bbox_top, A.obj_bullebill_base, true, false) != null):
		if o.holding == 2.0 and G.apariencia == 2.0:
			o.isduck = 1.0
			o.isduckhold = 1.0
		else:
			o.isduck = 1.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_score)):
		inst.event_user(3)
	GM.other = _o
	if G.apariencia == 3.0:
		for inst in GM.with_list(GM.instance_create((x + 8.0), y, A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_effect_powerup
			inst.image_speed = 0.25
			inst.depth = -10.0
	if G.powerup == 0.0:
		GM.audio_stop_sound(Scr.scr_snd_powerup(self))
		GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(GM.instance_create(0.0, 0.0, A.obj_mario_transform2)):
				inst.set("c_powerup", 1.0)
				inst.set("small", 1.0)
				inst.set("sprite_powerup", sprite_index)
	elif G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_powerup_second)
		GM.audio_play_sound(A.snd_NSMBU_powerup_second, 0.0, false)
	else:
		GM.audio_stop_sound(Scr.scr_snd_powerup(self))
		GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	instance_destroy()


# from objects/obj_mushroom/Other_13.gml
func _user_3() -> void:
	if G.modo_noche == 1.0 and G.bg_level == "ground":
		if (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_hurtsolid2, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_hurtsolid2, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_spring_land, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_spring_land, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_left + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null) or (hspeed > 0.0 and collision_rectangle((bbox_right + (hspeed * 2.0)), (bbox_top + 4.0), (bbox_right + (hspeed * 2.0)), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null):
			if delay == 0.0 and gravity == 0.0:
				if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship"):
					vspeed = -2.4
				else:
					vspeed = -4.8
				delay = 6.0
				y -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solid, false, false) != null:
			x -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
			x -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_hurtsolid2, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_hurtsolid2, false, false) != null:
			x -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null:
			x -= 1.0
		if hspeed < 0.0 and collision_rectangle((bbox_left + hspeed), (bbox_top + 4.0), (bbox_left + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null:
			x += 1.0
		if hspeed > 0.0 and collision_rectangle((bbox_right + hspeed), (bbox_top + 4.0), (bbox_right + hspeed), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null:
			x -= 1.0
	else:
		super._user_3()
