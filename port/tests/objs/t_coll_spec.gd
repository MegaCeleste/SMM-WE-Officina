extends "res://tests/objs/t_base.gd"
## 同时有“对父类 t_coll_b”和“对子类 t_coll_b_child”两个碰撞事件（U5，同 obj_flagpole）


func _collision_t_coll_b(other: GMObject) -> void:
	rec("parent " + String(other.get("tag")))


func _collision_t_coll_b_child(other: GMObject) -> void:
	rec("child " + String(other.get("tag")))
