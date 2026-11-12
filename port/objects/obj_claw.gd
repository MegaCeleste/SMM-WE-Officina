# from objects/obj_claw（第 6e 批移植，已核对）
# PORT: hold_obj 在“没有”时存 A.obj_lighting（int，原版用 obj_lighting 当占位），有时存实例。
# GDScript 里 Object 和 int 用 ==/!= 比较、或对 int 取成员会报运行时错误，所以涉及占位的地方用 is_same() 区分。
extends "res://objects/obj_deactivation.gd"

var s_claw: int = 0  ## sprite 编号
var s_claw_chain: int = 0  ## sprite 编号
var base_x: float = 0.0
var base_y: float = 0.0
var hold: float = 0.0  # obj_enabledsolid 读写
var hold_obj = null
var posx: float = 0.0
var posy: float = 0.0
var hold_speed: float = 0.0
var enemy: float = 0.0
var release: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名；obj_enabledsolid 也写它
var segmenten: float = 0.0
var segmentlengte: float = 0.0
var snelheidbaumgartefactor: float = 0.0
var positiebaumgartefactor: float = 0.0
var snelheiditeraties: float = 0.0
var positieiteraties: float = 0.0
var knoopmassa: float = 0.0
var eindmassa: float = 0.0
var zwaartekracht: float = 0.0
var knopen_x: Array = []
var knopen_y: Array = []
var knopen_xspeed: Array = []
var knopen_yspeed: Array = []
var knopen_invmassa: Array = []
var knopen_r: Array = []
# 以下是只在 Step/Draw/碰撞里第一次赋值的实例变量（GML 里没写 var）
var deltaxspeed = null
var deltayspeed = null
var snelheidsfout = null
var f = null
var raedy = null  # ORIG-BUG: Step_2 里 ready 拼成了 raedy，见 _step_end
var posyy = null
var i = null  # Draw_0 用的是实例变量 i（Create/Step 里的 i 是局部变量）


# from objects/obj_claw/Create_0.gml
func _create() -> void:
	var i: int
	match G.apariencia:
		0.0:
			s_claw = A.spr_SMB_claw
			s_claw_chain = A.spr_SMB_claw_chain
		1.0:
			s_claw = A.spr_SMB3_claw
			s_claw_chain = A.spr_SMB3_claw_chain
		2.0:
			s_claw = A.spr_claw
			s_claw_chain = A.spr_claw_chain
		3.0:
			s_claw = A.spr_NSMBU_claw
			s_claw_chain = A.spr_NSMBU_claw_chain
	base_x = x
	base_y = (y - 41.0)
	hold = 0.0
	hold_obj = A.obj_lighting
	posx = 0.0
	posy = 0.0
	hold_speed = 0.0
	enemy = 0.0
	release = 0.0
	ready_v = 1.0
	alarm[0] = 5.0
	segmenten = 5.0
	segmentlengte = 8.0
	snelheidbaumgartefactor = 0.1
	positiebaumgartefactor = 1.0
	snelheiditeraties = 20.0
	positieiteraties = 10.0
	knoopmassa = 1.0
	eindmassa = 5.0
	zwaartekracht = 0.2
	i = 0
	while i <= segmenten:
		GM.aset(knopen_x, i, base_x)
		GM.aset(knopen_y, i, (base_y + (i * segmentlengte)))
		GM.aset(knopen_xspeed, i, 0.0)
		GM.aset(knopen_yspeed, i, 0.0)
		GM.aset(knopen_invmassa, i, (1.0 / knoopmassa))
		GM.aset(knopen_r, i, 3.0)
		i += 1
	knopen_invmassa[0] = 0.0
	knopen_invmassa[int(segmenten)] = (1.0 / eindmassa)
	knopen_r[int(segmenten)] = 10.0


# from objects/obj_claw/Step_0.gml
func _step() -> void:
	var i: int
	var xx: float
	var yy: float
	var d: float
	var m
	var col_one_right
	var col_one_left
	var seg: int = int(segmenten)  # PORT: 数组下标用的 int 版 segmenten
	knopen_xspeed[0] = ((base_x - knopen_x[0]) * 0.3)
	knopen_yspeed[0] = ((base_y - knopen_y[0]) * 0.3)
	i = 0
	while i <= segmenten:
		knopen_yspeed[i] += zwaartekracht
		i += 1
	for _rep in range(int(snelheiditeraties)):
		i = 0
		if i < segmenten:
			xx = (knopen_x[(i + 1)] - knopen_x[i])
			yy = (knopen_y[(i + 1)] - knopen_y[i])
			d = sqrt(((xx * xx) + (yy * yy)))
			if d > 0.001:
				xx /= d
				yy /= d
			else:
				xx = 1.0
				yy = 0.0
			deltaxspeed = (knopen_xspeed[(i + 1)] - knopen_xspeed[i])
			deltayspeed = (knopen_yspeed[(i + 1)] - knopen_yspeed[i])
			snelheidsfout = (((deltaxspeed * xx) + (deltayspeed * yy)) + ((d - segmentlengte) * snelheidbaumgartefactor))
			f = (snelheidsfout / (knopen_invmassa[i] + knopen_invmassa[(i + 1)]))
			knopen_xspeed[i] += ((xx * f) * knopen_invmassa[i])
			knopen_yspeed[i] += ((yy * f) * knopen_invmassa[i])
			knopen_xspeed[(i + 1)] -= ((xx * f) * knopen_invmassa[(i + 1)])
			knopen_yspeed[(i + 1)] -= ((yy * f) * knopen_invmassa[(i + 1)])
			i += 1
			while i < segmenten:
				xx = (knopen_x[(i + 1)] - knopen_x[i])
				yy = (knopen_y[(i + 1)] - knopen_y[i])
				d = sqrt(((xx * xx) + (yy * yy)))
				if d > 0.001:
					xx /= d
					yy /= d
				else:
					xx = 1.0
					yy = 0.0
				deltaxspeed = (knopen_xspeed[(i + 1)] - knopen_xspeed[i])
				deltayspeed = (knopen_yspeed[(i + 1)] - knopen_yspeed[i])
				snelheidsfout = (((deltaxspeed * xx) + (deltayspeed * yy)) + ((d - segmentlengte) * snelheidbaumgartefactor))
				f = (snelheidsfout / (knopen_invmassa[i] + knopen_invmassa[(i + 1)]))
				knopen_xspeed[i] += ((xx * f) * knopen_invmassa[i])
				knopen_yspeed[i] += ((yy * f) * knopen_invmassa[i])
				knopen_xspeed[(i + 1)] -= ((xx * f) * knopen_invmassa[(i + 1)])
				knopen_yspeed[(i + 1)] -= ((yy * f) * knopen_invmassa[(i + 1)])
				i += 1
		i = 0
		if i <= segmenten:
			if (knopen_r[i] - (knopen_x[i] - 0.0)) > -0.01:
				knopen_xspeed[i] += maxf(0.0, ((-knopen_xspeed[i]) + ((knopen_r[i] - (knopen_x[i] - 0.0)) * snelheidbaumgartefactor)))
			if (knopen_r[i] - (knopen_y[i] - 0.0)) > -0.01:
				knopen_yspeed[i] += maxf(0.0, ((-knopen_yspeed[i]) + ((knopen_r[i] - (knopen_y[i] - 0.0)) * snelheidbaumgartefactor)))
			if (knopen_r[i] - (GM.room_width - knopen_x[i])) > -0.01:
				knopen_xspeed[i] -= maxf(0.0, (knopen_xspeed[i] + ((knopen_r[i] - (GM.room_width - knopen_x[i])) * snelheidbaumgartefactor)))
			i += 1
			while i <= segmenten:
				if (knopen_r[i] - (knopen_x[i] - 0.0)) > -0.01:
					knopen_xspeed[i] += maxf(0.0, ((-knopen_xspeed[i]) + ((knopen_r[i] - (knopen_x[i] - 0.0)) * snelheidbaumgartefactor)))
				if (knopen_r[i] - (knopen_y[i] - 0.0)) > -0.01:
					knopen_yspeed[i] += maxf(0.0, ((-knopen_yspeed[i]) + ((knopen_r[i] - (knopen_y[i] - 0.0)) * snelheidbaumgartefactor)))
				if (knopen_r[i] - (GM.room_width - knopen_x[i])) > -0.01:
					knopen_xspeed[i] -= maxf(0.0, (knopen_xspeed[i] + ((knopen_r[i] - (GM.room_width - knopen_x[i])) * snelheidbaumgartefactor)))
				i += 1
	i = 0
	while i <= segmenten:
		knopen_x[i] += knopen_xspeed[i]
		knopen_y[i] += knopen_yspeed[i]
		i += 1
	for _rep in range(int(positieiteraties)):
		i = 0
		if i < segmenten:
			xx = (knopen_x[(i + 1)] - knopen_x[i])
			yy = (knopen_y[(i + 1)] - knopen_y[i])
			d = sqrt(((xx * xx) + (yy * yy)))
			if d > 0.001:
				xx /= d
				yy /= d
			else:
				xx = 1.0
				yy = 0.0
			snelheidsfout = ((d - segmentlengte) * positiebaumgartefactor)
			f = (snelheidsfout / (knopen_invmassa[i] + knopen_invmassa[(i + 1)]))
			knopen_x[i] += ((xx * f) * knopen_invmassa[i])
			knopen_y[i] += ((yy * f) * knopen_invmassa[i])
			knopen_x[(i + 1)] -= ((xx * f) * knopen_invmassa[(i + 1)])
			knopen_y[(i + 1)] -= ((yy * f) * knopen_invmassa[(i + 1)])
			i += 1
			while i < segmenten:
				xx = (knopen_x[(i + 1)] - knopen_x[i])
				yy = (knopen_y[(i + 1)] - knopen_y[i])
				d = sqrt(((xx * xx) + (yy * yy)))
				if d > 0.001:
					xx /= d
					yy /= d
				else:
					xx = 1.0
					yy = 0.0
				snelheidsfout = ((d - segmentlengte) * positiebaumgartefactor)
				f = (snelheidsfout / (knopen_invmassa[i] + knopen_invmassa[(i + 1)]))
				knopen_x[i] += ((xx * f) * knopen_invmassa[i])
				knopen_y[i] += ((yy * f) * knopen_invmassa[i])
				knopen_x[(i + 1)] -= ((xx * f) * knopen_invmassa[(i + 1)])
				knopen_y[(i + 1)] -= ((yy * f) * knopen_invmassa[(i + 1)])
				i += 1
		i = 0
		if i <= segmenten:
			if (knopen_r[i] - (knopen_x[i] - 0.0)) > 0.0:
				knopen_x[i] += ((knopen_r[i] - (knopen_x[i] - 0.0)) * positiebaumgartefactor)
			if (knopen_r[i] - (knopen_y[i] - 0.0)) > 0.0:
				knopen_y[i] += ((knopen_r[i] - (knopen_y[i] - 0.0)) * positiebaumgartefactor)
			if (knopen_r[i] - (GM.room_width - knopen_x[i])) > 0.0:
				knopen_x[i] -= ((knopen_r[i] - (GM.room_width - knopen_x[i])) * positiebaumgartefactor)
			i += 1
			while i <= segmenten:
				if (knopen_r[i] - (knopen_x[i] - 0.0)) > 0.0:
					knopen_x[i] += ((knopen_r[i] - (knopen_x[i] - 0.0)) * positiebaumgartefactor)
				if (knopen_r[i] - (knopen_y[i] - 0.0)) > 0.0:
					knopen_y[i] += ((knopen_r[i] - (knopen_y[i] - 0.0)) * positiebaumgartefactor)
				if (knopen_r[i] - (GM.room_width - knopen_x[i])) > 0.0:
					knopen_x[i] -= ((knopen_r[i] - (GM.room_width - knopen_x[i])) * positiebaumgartefactor)
				i += 1
	x = knopen_x[seg]
	y = knopen_y[seg]
	if hold == 2.0 and GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = 0.0
			inst.hspeed = 0.0
			inst.gravity = 0.0
			inst.state = 0.0
			inst.jumpnow = 0.0
			inst.isup = 0.0
			inst.isuphold = 0.0
		m = GM.instance_find(A.obj_mario, 0)
		var obj_mario_inst = GM.instance_find(A.obj_mario, 0)
		if collision_rectangle(m.bbox_right, (m.bbox_top + 4.0), (m.bbox_right + 1.0), (m.bbox_bottom - 1.0), A.obj_solid, true, false) != null:
			knopen_xspeed[seg] = 0.0
		elif collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 4.0), obj_mario_inst.bbox_left, (obj_mario_inst.bbox_bottom - 1.0), A.obj_solid, true, false) != null:
			knopen_xspeed[seg] = 0.0
		if collision_rectangle(obj_mario_inst.bbox_right, (obj_mario_inst.bbox_top + 4.0), (obj_mario_inst.bbox_right + 1.0), (obj_mario_inst.bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null:
			knopen_xspeed[seg] = 0.0
		elif collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 4.0), obj_mario_inst.bbox_left, (obj_mario_inst.bbox_bottom - 1.0), A.obj_physicssolid, true, false) != null:
			knopen_xspeed[seg] = 0.0
		if collision_rectangle(obj_mario_inst.bbox_right, (obj_mario_inst.bbox_top + 4.0), (obj_mario_inst.bbox_right + 1.0), (obj_mario_inst.bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null:
			knopen_xspeed[seg] = 0.0
		elif collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 4.0), obj_mario_inst.bbox_left, (obj_mario_inst.bbox_bottom - 1.0), A.obj_bullebill_base, true, false) != null:
			knopen_xspeed[seg] = 0.0
		if collision_rectangle(obj_mario_inst.bbox_right, (obj_mario_inst.bbox_top + 4.0), (obj_mario_inst.bbox_right + 1.0), (obj_mario_inst.bbox_bottom - 1.0), A.obj_bumper, true, false) != null:
			knopen_xspeed[seg] = -2.0
		elif collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 4.0), obj_mario_inst.bbox_left, (obj_mario_inst.bbox_bottom - 1.0), A.obj_bumper, true, false) != null:
			knopen_xspeed[seg] = 2.0
		if collision_rectangle(obj_mario_inst.bbox_right, (obj_mario_inst.bbox_top + 4.0), (obj_mario_inst.bbox_right + 1.0), (obj_mario_inst.bbox_bottom - 1.0), A.obj_spring_land, true, false) != null:
			knopen_xspeed[seg] = -2.0
		elif collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 4.0), obj_mario_inst.bbox_left, (obj_mario_inst.bbox_bottom - 1.0), A.obj_spring_land, true, false) != null:
			knopen_xspeed[seg] = 2.0
		# ORIG-BUG: 第四个参数是爪子自己的 bbox_bottom（其余都是 obj_mario.bbox_bottom），照搬
		col_one_right = collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 4.0), obj_mario_inst.bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, true, false)
		col_one_left = collision_rectangle(obj_mario_inst.bbox_right, (obj_mario_inst.bbox_top + 4.0), (obj_mario_inst.bbox_right + 1.0), (obj_mario_inst.bbox_bottom - 1.0), A.obj_onewaygate_left, true, false)
		if col_one_right != null:
			if knopen_xspeed[seg] < 0.0:
				knopen_xspeed[seg] = 0.0
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_right):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
		if col_one_left != null:
			if knopen_xspeed[seg] > 0.0:
				knopen_xspeed[seg] = 0.0
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_left):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
		if GM.instance_exists(A.obj_autoscroll) and GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).barrier == 0.0:
			if obj_mario_inst.x <= (GM.camera_get_view_x(GM.view_get_camera(0)) + 8.0) and obj_mario_inst.inclown != 0.0:
				_user_1()
				ready_v = 1.0
				alarm[0] = 40.0
				hold = 0.0
				for inst in GM.with_list(A.obj_mario):
					inst.inclown = 0.0


# from objects/obj_claw/Step_2.gml
func _step_end() -> void:
	var sped_claw: float
	var m
	var solidtop
	var solidphy
	var solidbullet
	var seg: int = int(segmenten)  # PORT: 数组下标用的 int 版 segmenten
	if hold == 2.0:
		if G.powerup == -82.0:
			for inst in GM.with_list(A.obj_mario):
				inst.inclown = 0.0
			hold = 0.0
			raedy = 1.0  # ORIG-BUG: 原版写成 raedy（不是 ready），ready 没有被置 1，照搬
			alarm[0] = 40.0
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_mario):
				inst.vspeed = 0.0
				inst.hspeed = 0.0
				inst.gravity = 0.0
				inst.state = 0.0
				inst.jumpnow = 0.0
				inst.isup = 0.0
				inst.isuphold = 0.0
			for inst in GM.with_list(A.obj_mario):
				inst.x = x
			if G.apariencia == 3.0:
				if G.powerup == 0.0:
					for inst in GM.with_list(A.obj_mario):
						inst.y = (y - 6.0)
				else:
					for inst in GM.with_list(A.obj_mario):
						inst.y = (y - 2.0)
			else:
				for inst in GM.with_list(A.obj_mario):
					inst.y = (y - 9.0)
			var obj_mario_inst = GM.instance_find(A.obj_mario, 0)
			if GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and (collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 1.0), obj_mario_inst.bbox_left, (obj_mario_inst.bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((obj_mario_inst.bbox_left - 1.0), (obj_mario_inst.bbox_top + 1.0), obj_mario_inst.bbox_left, (obj_mario_inst.bbox_bottom - 4.0), A.obj_bumper, false, false) == null):
				knopen_xspeed[seg] -= 0.05
				if knopen_xspeed[seg] < -3.0:
					knopen_xspeed[seg] = -3.0
			elif GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and (collision_rectangle(obj_mario_inst.bbox_right, (obj_mario_inst.bbox_top + 1.0), (obj_mario_inst.bbox_right + 1.0), (obj_mario_inst.bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(obj_mario_inst.bbox_right, (obj_mario_inst.bbox_top + 1.0), (obj_mario_inst.bbox_right + 1.0), (obj_mario_inst.bbox_bottom - 4.0), A.obj_bumper, false, false) == null):
				knopen_xspeed[seg] += 0.05
				if knopen_xspeed[seg] > 3.0:
					knopen_xspeed[seg] = 3.0
			if GM.keyboard_check_pressed(G.saltar) and (not GM.keyboard_check_pressed(G.saltar_spin)):
				_user_1()
				ready_v = 1.0
				alarm[0] = 40.0
				hold = 0.0
				sped_claw = knopen_xspeed[seg]
				# ORIG-BUG: 原版 abs(sped_claw > 2.8)，括号放错，等于 sped_claw > 2.8（向左快速时不算），照搬
				if absf(1.0 if sped_claw > 2.8 else 0.0) > 0.5:
					if G.bg_level == "sky" and G.modo_noche == 1.0:
						if G.powerup == -78.0:
							for inst in GM.with_list(A.obj_mario):
								inst.vspeed = -4.0
						else:
							for inst in GM.with_list(A.obj_mario):
								inst.vspeed = -3.5
					elif G.powerup == -78.0:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -5.0
					else:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -4.6
				elif G.bg_level == "sky" and G.modo_noche == 1.0:
					if G.powerup == -78.0:
						if GM.gm_round((sped_claw / 2.0)) == 0.0:
							for inst in GM.with_list(A.obj_mario):
								inst.vspeed = -3.65
						else:
							for inst in GM.with_list(A.obj_mario):
								inst.vspeed = -3.75
					elif GM.gm_round((sped_claw / 2.0)) == 0.0:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -3.05
					else:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -3.15
				elif G.powerup == -78.0:
					if GM.gm_round((sped_claw / 2.0)) == 0.0:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -4.65
					else:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -4.75
				elif GM.gm_round((sped_claw / 2.0)) == 0.0:
					for inst in GM.with_list(A.obj_mario):
						inst.vspeed = -4.15
				else:
					for inst in GM.with_list(A.obj_mario):
						inst.vspeed = -4.25
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = knopen_xspeed[seg]
				GM.audio_play_sound(Scr.scr_jump(self), 0.0, false)
				for inst in GM.with_list(A.obj_mario):
					inst.jumpnow = 1.0
					inst.s_hen = 1.0
					inst.state = 2.0
					inst.inclown = 0.0
					inst.gp_limit = 8.0
			if GM.keyboard_check_pressed(G.saltar_spin) and (not GM.keyboard_check_pressed(G.saltar)) and G.apariencia > 1.0 and obj_mario_inst.holding == 0.0 and G.yoshi == 0.0:
				_user_1()
				ready_v = 1.0
				alarm[0] = 40.0
				hold = 0.0
				sped_claw = knopen_xspeed[seg]
				for inst in GM.with_list(A.obj_mario):
					inst.image_index = 0.0
				if absf(sped_claw) > 2.8:
					if G.bg_level == "sky" and G.modo_noche == 1.0:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -2.3
					else:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -3.3
				elif G.bg_level == "sky" and G.modo_noche == 1.0:
					if GM.gm_round((sped_claw / 2.0)) == 0.0:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -2.3
					else:
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = -2.3
				elif GM.gm_round((sped_claw / 2.0)) == 0.0:
					for inst in GM.with_list(A.obj_mario):
						inst.vspeed = -3.3
				else:
					for inst in GM.with_list(A.obj_mario):
						inst.vspeed = -3.3
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = knopen_xspeed[seg]
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_mario):
					inst.jumpnow = 1.0
					inst.s_hen = 1.0
					inst.inclown = 0.0
					inst.state = 2.0
					inst.isduck = 0.0
					inst.y -= 1.0
					inst.stompstyle = 1.0
					GM.audio_play_sound(Scr.scr_snd_spinjump(inst), 0.0, false)
					inst.alarm[7] = 10.0
				GM.other = _o
			if GM.keyboard_check_pressed(G.abajo):
				_user_1()
				ready_v = 1.0
				alarm[0] = 40.0
				hold = 0.0
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = knopen_xspeed[seg]
				for inst in GM.with_list(A.obj_mario):
					inst.inclown = 0.0
			m = GM.instance_find(A.obj_mario, 0)
			solidtop = collision_rectangle((m.bbox_left + 4.0), m.bbox_bottom, (m.bbox_right - 4.0), (m.bbox_bottom + 1.0), A.obj_solidtop, false, false)
			solidphy = collision_rectangle((m.bbox_left + 4.0), m.bbox_bottom, (m.bbox_right - 4.0), (m.bbox_bottom + 1.0), A.obj_physicssolid, false, false)
			solidbullet = collision_rectangle((m.bbox_left + 4.0), m.bbox_bottom, (m.bbox_right - 4.0), (m.bbox_bottom + 1.0), A.obj_bullebill_base, false, false)
			if (solidtop != null and solidtop.vspeed < 0.0) or (solidphy != null and solidphy.vspeed < 0.0) or (solidbullet != null and solidbullet.vspeed < 0.0):
				_user_1()
				ready_v = 1.0
				alarm[0] = 60.0
				hold = 0.0
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = knopen_xspeed[seg]
				for inst in GM.with_list(A.obj_mario):
					inst.inclown = 0.0
		else:
			hold = 0.0
	elif hold == 1.0:
		if GM.instance_exists(hold_obj):
			hold_obj.x = (x - posx)
			hold_obj.y = (y + posy)
			for inst in GM.with_list(hold_obj):
				inst.vspeed = 0.0
				inst.hspeed = 0.0
				inst.gravity = 0.0
			var obj_mario_inst = GM.instance_find(A.obj_mario, 0)
			if release == 0.0 and GM.instance_exists(A.obj_mario) and (obj_mario_inst.y + 16.0) > y and obj_mario_inst.x > (x - 24.0) and obj_mario_inst.x < (x + 24.0) and (not place_meeting(x, y, A.obj_solid)) and ((not place_meeting(x, y, A.obj_physicssolid)) or hold_obj.object_index == A.obj_muncher or hold_obj.object_index == A.obj_muncher_b) and (not place_meeting(x, y, A.obj_bullebill_base)):
				_user_1()
				if enemy == 0.0 or hold_obj.object_index == A.obj_spiny_ball or hold_obj.object_index == A.obj_magikoopa or hold_obj.object_index == A.obj_spike or hold_obj.object_index == A.obj_rocky or hold_obj.object_index == A.obj_lakitu or (hold_obj.object_index == A.obj_cheepcheep and hold_obj.hspeed == 0.0) or (hold_obj.object_index == A.obj_cheepcheep2 and hold_obj.hspeed == 0.0):
					hold_obj.hspeed = knopen_xspeed[seg]
				elif hold_obj.object_index == A.obj_bonybeetle or hold_obj.object_index == A.obj_bonybeetle_b:
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(hold_obj):
						inst.event_user(7)
					GM.other = _o
				else:
					for inst in GM.with_list(hold_obj):
						inst.alarm[10] = 2.0
				if hold_obj.object_index == A.obj_rocangrejo:
					hold_obj.claw = 0.0
				if hold_obj.object_index == A.obj_spike_ball or hold_obj.object_index == A.obj_spike_ball_b:
					hold_obj.set("angle", 0.0)  # obj_spike_ball / obj_spike_ball_b 还没移植（空壳）
				ready_v = 3.0
				alarm[0] = 40.0
				hold_obj = A.obj_lighting
				enemy = 0.0
				hold = 0.0
		# PORT: hold_obj 可能刚被换成占位 A.obj_lighting（int），这时 hold_obj.visible 按 GML 的 obj.var 读第一个实例
		var _ho = hold_obj if typeof(hold_obj) == TYPE_OBJECT else GM.instance_find(int(hold_obj), 0)
		if Scr.outside_view(self) <= 0.5 and (((not GM.instance_exists(hold_obj))) or (GM.variable_instance_exists(hold_obj, "held") and hold_obj.held == 1.0) or (GM.instance_exists(hold_obj) and _ho.visible == false)):
			_user_1()
			ready_v = 3.0
			alarm[0] = 40.0
			hold_obj = A.obj_lighting
			enemy = 0.0
			hold = 0.0


# from objects/obj_claw/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 0.0


# from objects/obj_claw/Alarm_1.gml
func _alarm_1() -> void:
	release = 0.0


# from objects/obj_claw/Collision_obj_egg.gml
func _collision_obj_egg(other: GMObject) -> void:
	var spd
	if hold == 0.0 and ready_v == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		posx = GM.sprite_get_xoffset(hold_obj.sprite_index)
		if posx != 0.0:
			posx = 0.0
		else:
			posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0  # PORT（用户定，2026-11-12）：原版拼成 sspd，spd 没赋值，下一步算术会出错；改回 spd，与其他碰撞事件一致
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and o.object_index != A.obj_grinder and o.visible == true and (o.hardness < 99.0 or o.object_index == A.obj_podoboo or o.object_index == A.obj_podoboo_b or o.object_index == A.obj_buzzy_ceiling) and o.stomp != 5.0 and (o.object_index != A.obj_buzzybeetle or (o.object_index == A.obj_buzzybeetle and o.inup == 0.0)) and (o.object_index != A.obj_buzzybeetle_b or (o.object_index == A.obj_buzzybeetle_b and o.inup == 0.0)) and (o.object_index != A.obj_spiny or (o.object_index == A.obj_spiny and o.inup == 0.0)) and (o.object_index != A.obj_jumppiranha or (o.object_index == A.obj_jumppiranha and o.inup == 0.0)) and o.object_index != A.obj_bulletbill and o.object_index != A.obj_bulletbull_red and o.object_index != A.obj_cannonball and o.object_index != A.obj_cannonball_red and o.object_index != A.obj_pokey and o.object_index != A.obj_foo and o.object_index != A.obj_piranhaplant and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		enemy = 1.0
		if o.object_index == A.obj_rocangrejo:
			o.claw = 1.0
		if o.paracaidas == 1.0:
			o.paracaidas = 0.0
			if o.object_index == A.obj_galoomba or o.object_index == A.obj_galoomba2 or o.object_index == A.obj_koopa or o.object_index == A.obj_koopa_red or o.object_index == A.obj_koopa_b or o.object_index == A.obj_koopa_red_b or o.object_index == A.obj_bobomb or o.object_index == A.obj_bobomb_ready:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(7)
				GM.other = _o
		posx = 0.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	var o = other
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and o.held == 0.0 and o.inup == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		posx = GM.sprite_get_xoffset(hold_obj.sprite_index)
		if posx != 0.0:
			posx = 0.0
		else:
			posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	var spd: float
	if hold == 0.0 and (ready_v == 0.0 or ready_v == 3.0) and o.inclown == 0.0 and G.powerup != -82.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)) and (not place_meeting(x, y, A.obj_bumper)):
		_user_0()
		hold = 2.0
		o.inclown = 2.0
		if G.apariencia == 3.0:
			if G.powerup == 0.0:
				posyy = 6.0
			else:
				posyy = 2.0
		else:
			posyy = 9.0
		knopen_x[int(segmenten)] = other.x
		if other.y > (y + 4.0):
			knopen_y[int(segmenten)] = (other.y + posyy)
		o.yview = (other.y + 32.0)
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.stompstyle = 0.0
			inst.isduck = 0.0
			inst.isduckhold = 0.0
			inst.isup = 0.0
			inst.isuphold = 0.0
			inst.groundpount = 0.0
			inst.dash_atack = 0.0
			inst.dash_cont = 0.0
			inst.arrow = 0.0
			inst.arrow_ready = 0.0
			inst.airspin = 0.0
			inst.airspin_count = 0.0
			inst.event_user(15)
		GM.other = _o


# from objects/obj_claw/Collision_obj_muncher.gml
func _collision_obj_muncher(other: GMObject) -> void:
	var o = other
	var muncher
	var spd: float
	muncher = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_physicssolid, false, false)
	if muncher != null and muncher.object_index != other.object_index:
		return
	# obj_muncher 还没移植（空壳）：mebelow 读到 0.0，== null 为假，这个分支在 obj_muncher 移植前不会进
	if hold == 0.0 and ready_v == 0.0 and o.mebelow == null and other.vspeed != 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		posx = GM.sprite_get_xoffset(hold_obj.sprite_index)
		if posx != 0.0:
			posx = 0.0
		else:
			posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_podoboo.gml
func _collision_obj_podoboo(other: GMObject) -> void:
	var o = other
	var spd: float
	if hold == 0.0 and ready_v == 0.0:
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		enemy = 1.0
		o.rotacion = 180.0
		o.rot = 2.0
		posx = 0.0
		posy = 16.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_powerupparent.gml
func _collision_obj_powerupparent(other: GMObject) -> void:
	var o = other
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and other.object_index != A.obj_cap and other.object_index != A.obj_propellershroom and other.object_index != A.obj_pballon and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		if other.object_index != A.obj_superflower and other.object_index != A.obj_fireflower and other.object_index != A.obj_link_res:
			enemy = 1.0
		if o.paracaidas == 1.0:
			o.paracaidas = 0.0
		if other.object_index == A.obj_megamushroom:
			posx = 0.0
		else:
			posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_shell_drybones_held.gml
func _collision_obj_shell_drybones_held(other: GMObject) -> void:
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = GM.instance_create(other.x, other.y, A.obj_shell_drybones)
		posx = 0.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_claw/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	var o = other
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		if other.sprite_index == A.spr_SMB_shell_empty or other.sprite_index == A.spr_SMB_shell_empty_night or other.sprite_index == A.spr_SMB3_shell_empty or other.sprite_index == A.spr_SMB3_shell_empty_night or other.sprite_index == A.spr_shell_buzzy_empty or other.sprite_index == A.spr_NSMBU_shell_buzzy_empty:
			hold_obj = GM.instance_create(other.x, other.y, A.obj_shell_empty)
		elif other.sprite_index == A.spr_SMB_shell_empty_spiny or other.sprite_index == A.spr_SMB3_shell_spiny_empty or other.sprite_index == A.spr_shell_spiny_empty or other.sprite_index == A.spr_NSMBU_shell_spiny_empty:
			hold_obj = GM.instance_create(other.x, other.y, A.obj_spiny_empty)
		else:
			hold_obj = GM.instance_create(other.x, other.y, A.obj_shell)
			hold_obj.sprite_index = other.sprite_index
			hold_obj.koopainside = o.koopainside
			hold_obj.flip = o.flip
			if G.apariencia == 2.0:
				if o.koopainside != 0.0:
					hold_obj.koopainside = o.koopainside
					hold_obj.alarm[3] = 540.0
					hold_obj.alarm[4] = 600.0
			elif o.koopainside != 0.0:
				hold_obj.koopainside = o.koopainside
				hold_obj.alarm[3] = 540.0
				hold_obj.alarm[4] = 640.0
		posx = GM.sprite_get_xoffset(hold_obj.sprite_index)
		if posx != 0.0:
			posx = 0.0
		else:
			posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_claw/Collision_obj_snow_ball_held.gml
func _collision_obj_snow_ball_held(other: GMObject) -> void:
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		if other.sprite_height <= 30.0:
			hold_obj = GM.instance_create(other.x, other.y, A.obj_snow_ball)
		else:
			hold_obj = GM.instance_create(other.x, other.y, A.obj_snow_ball_b)
		for inst in GM.with_list(hold_obj):
			inst.alarm[2] = 4.0
		posx = 0.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_claw/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	var spd: float
	# obj_spike_ball 还没移植（空壳）：paracaidas 读到 0.0；fisica 写入空壳
	if hold == 0.0 and ready_v == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		enemy = 1.0
		if other.get("paracaidas") == 1.0:
			other.set("paracaidas", 0.0)
		if G.apariencia < 2.0:
			other.set("fisica", 1.0)
		posx = 0.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_spring_land.gml
func _collision_obj_spring_land(other: GMObject) -> void:
	var o = other
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and o.mebelow == null and other.vspeed != 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_yoshi_abandon.gml
func _collision_obj_yoshi_abandon(other: GMObject) -> void:
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = 0.0
		posx = GM.sprite_get_xoffset(hold_obj.sprite_index)
		if posx != 0.0:
			posx = 0.0
		else:
			posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Collision_obj_yoshi_runaway.gml
func _collision_obj_yoshi_runaway(other: GMObject) -> void:
	var spd: float
	if hold == 0.0 and ready_v == 0.0 and (not place_meeting(x, y, A.obj_solid)) and (not place_meeting(x, y, A.obj_physicssolid)) and (not place_meeting(x, y, A.obj_bullebill_base)):
		_user_0()
		hold = 1.0
		hold_obj = other
		hold_speed = other.hspeed
		posx = GM.sprite_get_xoffset(hold_obj.sprite_index)
		if posx != 0.0:
			posx = 0.0
		else:
			posx = 8.0
		posy = 9.0
		release = 1.0
		alarm[1] = 30.0
		if other.hspeed > 3.0:
			spd = 3.0
		elif other.hspeed < -3.0:
			spd = -3.0
		else:
			spd = other.hspeed
		knopen_xspeed[int(segmenten)] = spd
		for inst in GM.with_list(other):
			inst.gravity = 0.0
			inst.speed = 0.0


# from objects/obj_claw/Other_10.gml
func _user_0() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB_clawin)
			GM.audio_play_sound(A.snd_SMB_clawin, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_clawin)
			GM.audio_play_sound(A.snd_SMB3_clawin, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_clawin)
			GM.audio_play_sound(A.snd_clawin, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_clawin)
			GM.audio_play_sound(A.snd_NSMBU_clawin, 0.0, false)


# from objects/obj_claw/Other_11.gml
func _user_1() -> void:
	match G.apariencia:
		0.0:
			GM.audio_stop_sound(A.snd_SMB_clawout)
			GM.audio_play_sound(A.snd_SMB_clawout, 0.0, false)
		1.0:
			GM.audio_stop_sound(A.snd_SMB3_clawout)
			GM.audio_play_sound(A.snd_SMB3_clawout, 0.0, false)
		2.0:
			GM.audio_stop_sound(A.snd_clawout)
			GM.audio_play_sound(A.snd_clawout, 0.0, false)
		3.0:
			GM.audio_stop_sound(A.snd_NSMBU_clawout)
			GM.audio_play_sound(A.snd_NSMBU_clawout, 0.0, false)


# from objects/obj_claw/Draw_0.gml
func _gm_draw() -> void:
	i = 0
	while i <= segmenten:
		if i == 0:
			GM.draw_sprite(s_claw_chain, 0.0, knopen_x[i], (knopen_y[i] - 2.0))
		elif i == segmenten:
			GM.draw_sprite(s_claw, hold, knopen_x[i], knopen_y[i])
		else:
			GM.draw_sprite(s_claw_chain, 1.0, knopen_x[i], knopen_y[i])
		i += 1
