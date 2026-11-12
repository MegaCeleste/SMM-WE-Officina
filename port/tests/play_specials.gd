extends "res://tests/play_enemies.gd"
## 第 7 批试玩关卡（调试用，非原版）：同 tests/play_enemies.gd，组取自 tests/test_specials.gd。
## 运行：godot --path port res://tests/play_specials.tscn [-- 组 [画风] [shot <目录>]]
##   组：helmet clown goal door platform gadget deco effect weather

const TestSpecials = preload("res://tests/test_specials.gd")


func _groups() -> Dictionary:
	return TestSpecials.GROUPS7
