# 第 4 批移植，已核对。
extends GMObject

var direct: float = 0.0
var yview: float = 0.0


# from objects/obj_mario_temp/Create_0.gml
func _create() -> void:
	if G.apariencia == 3.0:
		sprite_index = Scr.scr_NSMBU_idle(self, 0.0)
	else:
		sprite_index = Scr.scr_marioidle(self)
	image_speed = 0.0
	image_index = 0.0
	direct = 1.0
	yview = (y + 32.0)
	alarm[0] = 2.0


# from objects/obj_mario_temp/Alarm_0.gml
func _alarm_0() -> void:
	var marioU: int = 0
	if G.apariencia == 3.0:
		marioU = A.obj_marioU
	else:
		marioU = A.obj_mario
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(GM.instance_create(x, y, marioU)):
		inst.direct = self.direct
		inst.event_user(6)
	GM.other = _o
	_user_0()
	instance_destroy()


# from objects/obj_mario_temp/Other_10.gml
# PORT: 原文是 32 个 place_meeting 用 && 连成的一个条件（偏移 16…272，没有 80），这里写成等价的循环
func _user_0() -> void:
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			var ok: bool = G.bg_level != "underwater"
			var d: float = 16.0
			while ok and d <= 272.0:
				# GML 原文逐个写出 16,32,48,64,96,112,...,272（没有 80）
				if d != 80.0:
					if inst.place_meeting(inst.x, (inst.y + d), A.obj_solidtop) or inst.place_meeting(inst.x, (inst.y + d), A.obj_slopeparent):
						ok = false
				d += 16.0
			if ok:
				GM.instance_create((inst.x - 24.0), (inst.y + 32.0), A.obj_platform_help)


# from objects/obj_mario_temp/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), (y + 1.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
