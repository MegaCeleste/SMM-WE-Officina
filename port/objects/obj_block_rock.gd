# from objects/obj_block_rock（第 5 批移植，已核对）
extends "res://objects/obj_rockparent.gd"

var sprite_wings: int = 0  ## sprite 编号
# shard 已声明在 obj_rockparent
var wings: float = 0.0
var wings_anim: float = 0.0


# from objects/obj_block_rock/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_block_rock
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 5.0
					else:
						image_index = 4.0
				"underwater":
					image_index = 3.0
				"castle":
					image_index = 2.0
				"airship":
					image_index = 2.0
				"ghost":
					image_index = 1.0
				"underground":
					image_index = 1.0
				_:
					image_index = 0.0
			sprite_wings = A.spr_SMB_wings_16x16
			shard = A.spr_SMB_shard_rock
		1.0:
			sprite_index = A.spr_SMB3_block_rock
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 4.0
					else:
						image_index = 3.0
				"castle":
					image_index = 2.0
				"ghost":
					image_index = 1.0
				"mountain":
					if G.modo_noche == 0.0:
						image_index = 0.0
					else:
						image_index = 2.0
				"underground":
					image_index = 1.0
				_:
					image_index = 0.0
			sprite_wings = A.spr_SMB3_wings2
			shard = A.spr_SMB3_shard_rock
		2.0:
			match G.bg_level:
				"ghost":
					sprite_index = A.spr_madera
					shard = A.spr_shard_th
				"airship":
					sprite_index = A.spr_madera
					shard = A.spr_shard_th
				_:
					sprite_index = A.spr_block_rock
					shard = A.spr_shard_g
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_block_rock
			match G.bg_level:
				"ghost":
					image_index = 5.0
				"airship":
					image_index = 4.0
				"sky":
					image_index = 4.0
				"mountain":
					if G.modo_noche == 0.0:
						image_index = 4.0
					else:
						image_index = 2.0
				"underwater":
					image_index = 3.0
				"castle":
					image_index = 2.0
				"underground":
					image_index = 1.0
				_:
					image_index = 0.0
			sprite_wings = A.spr_NSMBU_wings_items
			shard = A.spr_NSMBU_shardhard
		4.0:
			sprite_index = A.spr_SMB_block_rock
			if (G.bg_level == "castle") or ((G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0))):
				image_index = 1.0
			else:
				image_index = 0.0
			shard = A.spr_SMB_shard_rock  # 原版缩进像是 else 分支，但实际无条件执行
	wings = 0.0
	wings_anim = 0.0
