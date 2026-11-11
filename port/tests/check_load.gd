extends Node
## 逐个 load() res://objects 和 res://scripts 下的全部 .gd，用来查编译错误。
## 编译失败时 load() 也可能返回非空，所以要看日志里有没有 "SCRIPT ERROR" / "Parse Error"。
## 用法：Godot --headless --path port res://tests/check_load.tscn 2>&1 | grep -B2 -A6 "ERROR"
## 可选参数：-- obj_koopa obj_mario（只查这几个文件名，不带 .gd）


func _ready() -> void:
	var only: PackedStringArray = OS.get_cmdline_user_args()
	var n: int = 0
	for dir: String in ["res://objects", "res://scripts"]:
		for f: String in DirAccess.get_files_at(dir):
			if not f.ends_with(".gd"):
				continue
			if not only.is_empty() and not only.has(f.get_basename()):
				continue
			print("LOAD ", dir, "/", f)
			var s: Variant = load(dir + "/" + f)
			if s == null:
				print("LOAD-FAILED ", f)
			n += 1
	print("check_load: ", n, " files")
	get_tree().quit()
