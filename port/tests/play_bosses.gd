extends "res://tests/play_enemies.gd"
## 第 8 批试玩：一条平地，按原版画风映射摆放 Boss；_res 的默认值来自 test_bosses.gd。
## 运行：godot --path port res://tests/play_bosses.tscn -- [bowser|junior|boomboom] [画风 0..3]
## 截图：-- 组 画风 shot <输出目录>。控制键、F5 重开、Esc 退出同 play_enemies。

const TestBosses = preload("res://tests/test_bosses.gd")


func _groups() -> Dictionary:
	return {
		"bowser": TestBosses.names_for(_style, "bowser"),
		"junior": TestBosses.names_for(_style, "junior"),
		"boomboom": TestBosses.names_for(_style, "boomboom"),
	}


func _place() -> void:
	_sections = []
	var px: float = 320.0
	for boss_name: String in _groups()[_group]:
		_sections.append([boss_name, px])
		var boss: GMObject = GM.instance_create(px, GROUND_Y - 16.0, GM.asset_get_index(boss_name))
		TestBosses.apply_resource_defaults(boss, boss_name)
		px += 768.0
	print("play_bosses: %s style %d, %d bosses" % [_group, _style, _sections.size()])
