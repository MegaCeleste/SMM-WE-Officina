# from objects/obj_mario_transform2/（第 3 批移植，已逐事件核对）
# 吃蘑菇/受伤时的变身过场。外部（obj_mario、obj_mushroom、obj_powerupparent）在 Create 之后写
# c_powerup、small、powerdown、cap、sprite_powerup；obj_mario / obj_levelmanager 读 m_hspeed、powerdown。
extends GMObject

var powerup_actual: float = 0.0
var powerup_nuevo: float = 0.0
var sprite_powerup = null  # 外部写入 sprite 编号
var small: float = 0.0
var cap: float = 0.0
var c_powerup: float = 0.0
var powerdown: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var invincible_restart: float = 0.0  # 只在 obj_mario 存在时赋值
var m_sprite = null
var m_index = null
var m_hspeed = null
var m_vspeed = null
var m_x = null
var m_y = null
var m_state = null
var m_skidnow = null
var cap_speed = null
var bg_speed = null
var back = null
var timeline_running: float = 0.0  # NEED-GM: timeline_running（GMS 内置实例变量，原版只在这里写、没人读）


# from objects/obj_mario_transform2/Create_0.gml
func _create() -> void:
	powerup_actual = 0.0
	powerup_nuevo = 0.0
	sprite_powerup = 0.0
	small = 0.0
	cap = 0.0
	c_powerup = 0.0
	powerdown = 0.0
	ready_v = 0.0
	if GM.instance_exists(A.obj_mario):
		var mario = GM.instance_find(A.obj_mario, 0)
		if mario.alarm[3] != -1.0:
			invincible_restart = 1.0
		else:
			invincible_restart = 0.0
		if GM.instance_exists(A.obj_mario_pballon):
			for inst in GM.with_list(A.obj_mario_pballon):
				inst.visible = false
		if GM.instance_exists(A.obj_smoke_cap):
			for inst in GM.with_list(A.obj_smoke_cap):
				inst.visible = false
		if GM.instance_exists(A.obj_spinner):
			for inst in GM.with_list(A.obj_spinner):
				inst.instance_destroy()
		if GM.instance_exists(A.obj_kuriboshoe):
			for inst in GM.with_list(A.obj_kuriboshoe):
				inst.visible = false
		if GM.instance_exists(A.obj_yoshi2):
			for inst in GM.with_list(A.obj_yoshi2):
				inst.visible = false
		if GM.instance_exists(A.obj_helmet):
			for inst in GM.with_list(A.obj_helmet):
				inst.visible = false
		if G.apariencia == 3.0:
			if mario.skidnow == 1.0:
				m_sprite = Scr.scr_NSMBU_skid(self)
			elif mario.state == 1.0:
				m_sprite = Scr.scr_NSMBU_walk(self, mario.isswim)
			elif mario.state == 0.0:
				m_sprite = Scr.scr_NSMBU_idle(self, mario.isswim)
			else:
				m_sprite = mario.sprite_index
		elif mario.skidnow == 1.0:
			m_sprite = Scr.scr_marioskid(self)
		elif mario.state == 1.0:
			m_sprite = Scr.scr_mariowalk(self)
		elif mario.state == 0.0:
			m_sprite = Scr.scr_marioidle(self)
		else:
			m_sprite = mario.sprite_index
		m_index = mario.image_index
		m_hspeed = mario.hspeed
		m_vspeed = mario.vspeed
		m_x = mario.x
		m_y = mario.y
		m_state = mario.state
		m_skidnow = mario.skidnow
		for inst in GM.with_list(A.obj_mario):
			inst.hspeed = 0.0
		if mario.link_transform == 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.image_speed = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
		for inst in GM.with_list(A.obj_mario):
			inst.disablecontrols = 1.0
			inst.invincible = 1.0
			inst.gravity = 0.0
			if inst.link_transform == 0.0:
				inst.image_speed = 0.0
				inst.image_index = self.m_index
			inst.x = self.m_x
			inst.y = self.m_y
			inst.alarm[1] = -1.0
			inst.alarm[3] = -1.0
			inst.image_alpha = 1.0
	if GM.instance_exists(A.obj_cap_mario):
		for inst in GM.with_list(A.obj_cap_mario):
			inst.image_speed = 0.0
		cap_speed = GM.instance_find(A.obj_cap_mario, 0).image_speed  # 原版先写 0 再读，所以恒为 0
	bg_speed = Scr.__background_get(self, 11.0, 0.0)  # 11 << 0
	Scr.__background_set(self, 11.0, 0.0, GM.c_black)  # 11 << 0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_rainmaker):
		inst.event_user(0)
	GM.other = _o
	alarm[0] = 1.0


# from objects/obj_mario_transform2/Destroy_0.gml
func _destroy() -> void:
	if ready_v == 1.0:
		GM.sprite_delete(back)
	ready_v = 0.0
	Scr.__background_set(self, Scr.e__BG.HSpeed, 0.0, bg_speed)
	if G.modo_noche == 1.0 and (GM.veq(G.bg_level, "ghost") or GM.veq(G.bg_level, "underwater")):
		if not GM.instance_exists(A.obj_lighting):
			GM.instance_create(x, y, A.obj_lighting)
	G.instance_deactivate = 1.0
	GM.instance_activate_all()
	GM.instance_activate_object(A.obj_parent_save)
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		for inst in GM.with_list(A.obj_parent_save):
			inst.visible = true
	timeline_running = 1.0
	if GM.instance_exists(A.obj_levelmanager):
		for inst in GM.with_list(A.obj_levelmanager):
			inst.alarm[2] = 60.0
	if GM.instance_exists(A.obj_mario):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.invincible = 0.0
			inst.helice_fly = 0.0
			inst.groundpount = 0.0
			inst.link_transform = 0.0
			inst.dash_atack = 0.0
			inst.dash_cont = 0.0
			inst.down_atack = 0.0
			inst.down_cont = 0.0
			inst.arrow = 0.0
			inst.arrow_ready = 0.0
			if inst.stuntime == 0.0:
				if GM.instance_exists(A.obj_kuribo_drybones):
					if GM.instance_find(A.obj_kuribo_drybones, 0).invincible == 0.0:
						inst.disablecontrols = 0.0
				else:
					inst.disablecontrols = 0.0
			inst.hspeed = self.m_hspeed
			inst.vspeed = self.m_vspeed
			if self.powerdown == 1.0 or self.invincible_restart == 1.0:
				inst.event_user(6)
		GM.other = _o
	if cap == 1.0:
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.image_speed = self.cap_speed
	elif cap == 2.0:
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.instance_destroy()
	if G.powerup == -82.0 and GM.instance_exists(A.obj_mario_pballon):
		for inst in GM.with_list(A.obj_mario_pballon):
			inst.visible = true
	if GM.instance_exists(A.obj_autoscroll):
		for inst in GM.with_list(A.obj_autoscroll):
			inst.hspeed = inst.velocidad
	var _o2: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_rainmaker):
		inst.event_user(0)
	GM.other = _o2


# from objects/obj_mario_transform2/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.disablecontrols = 1.0
			inst.gravity = 0.0
			inst.hspeed = 0.0
			if inst.link_transform == 0.0:
				inst.sprite_index = self.m_sprite
				inst.image_speed = 0.0
				inst.image_index = self.m_index
			inst.x = self.m_x
			inst.y = self.m_y
			inst.state = self.m_state
			inst.skidnow = self.m_skidnow
	if GM.instance_exists(A.obj_cap_mario):
		for inst in GM.with_list(A.obj_cap_mario):
			inst.image_speed = 0.0
	if ready_v == 1.0 or ready_v == 2.0:
		timeline_running = 0.0
		if GM.instance_exists(A.obj_smoke_cap):
			for inst in GM.with_list(A.obj_smoke_cap):
				inst.visible = true
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.cap_invisible = 0.0
		if GM.instance_exists(A.obj_kuriboshoe):
			for inst in GM.with_list(A.obj_kuriboshoe):
				inst.visible = true
		if GM.instance_exists(A.obj_yoshi2):
			for inst in GM.with_list(A.obj_yoshi2):
				inst.visible = true
		if GM.instance_exists(A.obj_helmet):
			for inst in GM.with_list(A.obj_helmet):
				inst.visible = true
		if GM.instance_exists(A.obj_autoscroll):
			for inst in GM.with_list(A.obj_autoscroll):
				inst.hspeed = 0.0


# from objects/obj_mario_transform2/Alarm_0.gml
func _alarm_0() -> void:
	var c = GM.instance_find(A.obj_creator_jugar_editar, 0)
	if GM.instance_exists(A.obj_creator_jugar_editar) and c.alarm[0] != -1.0 and c.alarm[7] != -1.0:
		instance_destroy()
		return
	var sx: float = GM.instance_find(A.obj_persistent, 0).s
	back = Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, (G.gw * sx), (G.gh * sx), false, false)
	if GM.instance_exists(A.obj_lighting):
		for inst in GM.with_list(A.obj_lighting):
			inst.instance_destroy()
	ready_v = 1.0
	G.instance_deactivate = 0.0
	GM.instance_deactivate_all(true, self)
	GM.instance_activate_object(A.obj_persistent)
	GM.instance_activate_object(A.obj_mario)
	GM.instance_activate_object(A.obj_cap_mario)
	GM.instance_activate_object(A.obj_kuriboshoe)
	GM.instance_activate_object(A.obj_helmet)
	GM.instance_activate_object(A.obj_yoshi2)
	GM.instance_activate_object(A.obj_smoke_cap)
	GM.instance_activate_object(A.obj_autoscroll)
	GM.instance_activate_object(A.obj_rainmaker)
	if G.yoshi == 0.0:
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_mario):
				inst.visible = true
	if GM.instance_exists(A.obj_kuriboshoe):
		for inst in GM.with_list(A.obj_kuriboshoe):
			inst.visible = true
	if GM.instance_exists(A.obj_yoshi2):
		for inst in GM.with_list(A.obj_yoshi2):
			inst.visible = true
	if GM.instance_exists(A.obj_levelmanager):
		for inst in GM.with_list(A.obj_levelmanager):
			inst.alarm[2] = 0.0
	if c_powerup == 1.0:
		if small == 2.0:
			powerup_actual = G.powerup
			powerup_nuevo = 0.0
		else:
			powerup_actual = G.powerup
			powerup_nuevo = Scr.scr_sprite_get_constant(self, sprite_powerup)
		G.powerup = powerup_nuevo
	if cap != 0.0:
		GM.instance_activate_object(A.obj_cap_mario)
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.cap_invisible = 0.0
				inst.visible = true
	alarm[1] = 6.0


# from objects/obj_mario_transform2/Alarm_1.gml
func _alarm_1() -> void:
	if cap != 0.0:
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.visible = false
	if c_powerup == 1.0:
		G.powerup = powerup_actual
	alarm[2] = 7.0


# from objects/obj_mario_transform2/Alarm_2.gml
func _alarm_2() -> void:
	if cap != 0.0:
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.visible = true
	if c_powerup == 1.0:
		G.powerup = powerup_nuevo
	alarm[3] = 7.0


# from objects/obj_mario_transform2/Alarm_3.gml
func _alarm_3() -> void:
	if cap != 0.0:
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.visible = false
	if c_powerup == 1.0:
		G.powerup = powerup_actual
	alarm[4] = 7.0


# from objects/obj_mario_transform2/Alarm_4.gml
func _alarm_4() -> void:
	if cap != 0.0:
		if GM.instance_exists(A.obj_cap_mario):
			for inst in GM.with_list(A.obj_cap_mario):
				inst.visible = true
	if c_powerup == 1.0:
		G.powerup = powerup_nuevo
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).link_transform == 1.0:
		alarm[10] = 14.0
	else:
		alarm[10] = 7.0


# from objects/obj_mario_transform2/Alarm_10.gml
func _alarm_10() -> void:
	instance_destroy()


# from objects/obj_mario_transform2/Other_10.gml
func _user_0() -> void:
	if GM.instance_exists(A.obj_physicsparent):
		for inst in GM.with_list(A.obj_physicsparent):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_holdparent):
		for inst in GM.with_list(A.obj_holdparent):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_spike):
		for inst in GM.with_list(A.obj_spike):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_key_appear):
		for inst in GM.with_list(A.obj_key_appear):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_magikoopa):
		for inst in GM.with_list(A.obj_magikoopa):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_boomboom):
		for inst in GM.with_list(A.obj_boomboom):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_icecoin):
		for inst in GM.with_list(A.obj_icecoin):
			inst.image_speed = 0.0
			inst.image_index = 0.0
	if GM.instance_exists(A.obj_pink_coin):
		for inst in GM.with_list(A.obj_pink_coin):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_key):
		for inst in GM.with_list(A.obj_key):
			inst.speed = 0.0
			inst.image_index = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_egg):
		for inst in GM.with_list(A.obj_egg):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[2] = -1.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_cheepcheep):
		for inst in GM.with_list(A.obj_cheepcheep):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_cheepcheep2):
		for inst in GM.with_list(A.obj_cheepcheep):  # ORIG-BUG: 判断的是 obj_cheepcheep2，却 with (obj_cheepcheep)
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_chain_chomp_free):
		for inst in GM.with_list(A.obj_chain_chomp_free):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_1up):
		for inst in GM.with_list(A.obj_1up):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_torbellino):
		for inst in GM.with_list(A.obj_torbellino):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_bullebill_base):
		for inst in GM.with_list(A.obj_bullebill_base):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_galoomba):
		for inst in GM.with_list(A.obj_galoomba):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_plant_fire):
		for inst in GM.with_list(A.obj_plant_fire):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[2] = -1.0
	if GM.instance_exists(A.obj_jumppiranha):
		for inst in GM.with_list(A.obj_jumppiranha):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_hammerbro):
		for inst in GM.with_list(A.obj_hammerbro):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_sledgebro):
		for inst in GM.with_list(A.obj_sledgebro):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[3] = -1.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_bobomb_ready):
		for inst in GM.with_list(A.obj_bobomb_ready):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_banzaibill):
		for inst in GM.with_list(A.obj_banzaibill):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_smoke):
		for inst in GM.with_list(A.obj_smoke):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_rotten_signal):
		for inst in GM.with_list(A.obj_rotten_signal):
			inst.vspeed = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_blockparent):
		for inst in GM.with_list(A.obj_blockparent):
			inst.image_speed = 0.0
			inst.speed = 0.0
	if GM.instance_exists(A.obj_cap):
		for inst in GM.with_list(A.obj_cap):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_coin):
		for inst in GM.with_list(A.obj_coin):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.speed = 0.0
	if GM.instance_exists(A.obj_coin10):
		for inst in GM.with_list(A.obj_coin10):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_drybones):
		for inst in GM.with_list(A.obj_drybones):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_clown):
		for inst in GM.with_list(A.obj_clown):
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_bumper):
		for inst in GM.with_list(A.obj_bumper):
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_checkpoint):
		for inst in GM.with_list(A.obj_checkpoint):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_pinchos):
		for inst in GM.with_list(A.obj_pinchos):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_cinta):
		for inst in GM.with_list(A.obj_cinta):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_meteorites):
		for inst in GM.with_list(A.obj_meteorites):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_meteorites_big):
		for inst in GM.with_list(A.obj_meteorites_big):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.image_speed = 0.0


# from objects/obj_mario_transform2/Draw_0.gml
func _gm_draw() -> void:
	if ready_v == 1.0 and GM.sprite_exists(int(back)):
		GM.gpu_set_blendenable(0.0)
		var sx: float = 0.5
		GM.draw_sprite_ext(int(back), 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), sx, sx, 0.0, GM.c_white, 1.0)
		GM.gpu_set_blendenable(1.0)
