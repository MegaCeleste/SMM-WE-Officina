# from objects/obj_block_ice（第 5 批移植，已核对）
extends "res://objects/obj_rockparent.gd"

# shard 已声明在 obj_rockparent
var sprite_wings: int = 0  ## sprite 编号
var wings: float = 0.0
var wings_anim: float = 0.0


# from objects/obj_block_ice/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_blockice
			shard = A.spr_SMB_shard_ice
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_index = A.spr_SMB3_block_ice
			shard = A.spr_SMB3_shard_ice
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_index = A.spr_block_ice
			shard = A.spr_shard_ice
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_block_ice
			shard = A.spr_NSMBU_shardice
			sprite_wings = A.spr_NSMBU_wings_items
	wings = 0.0
	wings_anim = 0.0
