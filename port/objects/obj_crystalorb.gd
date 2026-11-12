# from objects/obj_crystalorb（第 7 批移植，已核对）
extends GMObject

var index_soporte: float = 0.0
var show: float = 0.0
var soporte = null


# from objects/obj_crystalorb/Create_0.gml
func _create() -> void:
	if (G.bg_level == "castle") or ((G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0))):
		# UNSURE: 原工程（openwe-ref）里没有 spr_SMB2_crystalorb_night 这个 sprite（obj_crystalorb.yy 的 spriteId 也是 null），原版这里会因读未赋值的变量报错。用 asset_get_index 取，取不到（-1）时不改 sprite_index
		var _spr_night: int = GM.asset_get_index("spr_SMB2_crystalorb_night")
		if _spr_night >= 0:
			sprite_index = _spr_night
		index_soporte = 1.0
	else:
		index_soporte = 0.0
	show = 1.0
	image_speed = 0.15
	GM.instance_create((x + 64.0), (y - 32.0), A.obj_hawmask)
	soporte = GM.instance_create((x - 16.0), (y + 16.0), A.obj_solid)
	for inst in GM.with_list(soporte):
		inst.image_xscale = 3.0


# from objects/obj_crystalorb/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_hawmask):
		for inst in GM.with_list(A.obj_hawmask):
			inst.instance_destroy()
	if GM.instance_exists(soporte):
		for inst in GM.with_list(soporte):
			inst.instance_destroy()


# from objects/obj_crystalorb/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if (G.condiciones == 0.0) or ((G.condiciones == 1.0) and ((G.condiciones_clear == 1.0) and (show == 1.0))):
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_player_goal_smb2)):
			var _m = GM.instance_find(A.obj_mario, 0)  # obj_mario.vspeed / obj_mario.direct（第一个实例）
			inst.vspeed = _m.vspeed
			inst.direct = _m.direct
		GM.audio_stop_sound(Scr.scr_snd_switchsong(self))
		GM.audio_stop_sound(Scr.scr_snd_starman(self))
		alarm[0] = 270.0
		if GM.room != A.rm_editor:
			var _p = GM.instance_find(A.obj_persistent, 0)  # obj_persistent.modo_android（第一个实例）
			if (_p.modo_android == 1.0) and (G.controles_tactiles == 1.0):
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(A.obj_persistent):
					inst.event_user(4)
					inst.event_user(5)
				GM.other = _o
		var _o2: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
		GM.other = self
		for inst in GM.with_list(A.obj_levelmanager):
			inst.event_user(3)
			inst.alarm[2] = 0.0
			inst.alarm[4] = -1.0
		GM.other = _o2
		G.checkpoint = -4.0
		if GM.instance_exists(A.obj_hawmask):
			for inst in GM.with_list(A.obj_hawmask):
				inst.alarm[0] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.instance_destroy()
		GM.instance_create(x, y, A.obj_smoke)
		show = 0.0
	GM.instance_destroy(A.obj_mario)
	GM.instance_destroy(A.obj_mario_temp)
	if GM.instance_exists(A.obj_meteorites):
		GM.instance_destroy(A.obj_meteorites)
	if GM.instance_exists(A.obj_meteorites_big):
		GM.instance_destroy(A.obj_meteorites_big)


# from objects/obj_crystalorb/Draw_0.gml
func _gm_draw() -> void:
	if show == 1.0:
		draw_self()
	# UNSURE: 原工程里没有 spr_SMB2_crystalorbplatform 这个 sprite，原版这里会因读未赋值的变量报错。用 asset_get_index 取，取不到（-1）时不画
	var _spr_platform: int = GM.asset_get_index("spr_SMB2_crystalorbplatform")
	if _spr_platform >= 0:
		GM.draw_sprite(_spr_platform, index_soporte, (x - 16.0), (y + 16.0))
