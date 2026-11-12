# from objects/obj_arrow_big（第 7 批移植，已核对）
extends GMObject

var jugador: int = 0  ## sprite 编号
var can_anim: float = 0.0
var anim: float = 0.0  # PORT: 原版 Create 里没赋值，Step 里第一次走 else 分支才赋 0；can_anim 初值 0 所以先赋值后累加，声明成 0.0 等价


# from objects/obj_arrow_big/Create_0.gml
func _create() -> void:
	if G.apariencia == 0.0 or GM.room == A.rm_title:
		sprite_index = A.spr_SMB_arrow_big
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_arrow_big
	jugador = A.spr_SMB3_mario_small_walk
	can_anim = 0.0
	alarm[0] = 90.0


# from objects/obj_arrow_big/Step_0.gml
func _step() -> void:
	# UNSURE: scr_bg_snow() 返回的是 background 资源编号，却传给 layer_background_get_sprite（它要 layer 元素 id）；兼容层按 id 查 _bgs，查不到返回 -1（假）
	if GM.layer_background_get_sprite(Scr.scr_bg_snow(self)) > 0.5:  # PORT: GML 真值 > 0.5
		image_index = 1.0
	else:
		image_index = 0.0
	if GM.room == A.rm_title:
		depth = 0.0
	if can_anim == 1.0:
		anim += 0.3
	else:
		anim = 0.0


# from objects/obj_arrow_big/Alarm_0.gml
func _alarm_0() -> void:
	if can_anim == 0.0:
		can_anim = 1.0
	else:
		can_anim = 0.0
	alarm[0] = 90.0
