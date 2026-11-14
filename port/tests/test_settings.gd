extends Node
## Run with APPDATA/LOCALAPPDATA redirected to a disposable test directory.

var checks: int = 0
var failures: int = 0

func check(value: bool, message: String) -> void:
	checks += 1
	if not value:
		failures += 1
		printerr("FAIL: ", message)

func _ready() -> void:
	GM.auto_tick = false
	var path: String = "user://settings.cfg"
	if FileAccess.file_exists(path):
		printerr("Refusing to overwrite existing settings in test user directory")
		get_tree().quit(1)
		return
	var p = GM.instance_create(0.0, 0.0, A.obj_persistent)
	p._game_start()
	check(p.fullscreen == 0.0 and p.filter == 1.0, "window defaults")
	check(G.derecha == 68.0 and G.saltar == 38.0 and G.pause == 32.0, "key defaults")
	p.fullscreen = 1.0
	p.filter = 0.0
	var n: float = 10.0
	for key: String in p.SETTINGS_NUMBERS:
		G.set(key, n)
		n += 1.0
	G.last_level = "关卡.swe"
	G.name_user = "玩家"
	G.my1 = "作者"
	p._user_7()
	check(FileAccess.file_exists(path), "settings saved")
	p.fullscreen = 0.0
	p.filter = 1.0
	for key: String in p.SETTINGS_NUMBERS:
		G.set(key, -1.0)
	G.last_level = ""
	G.name_users = ""
	G.my1 = 0.0
	p._load_settings()
	check(p.fullscreen == 1.0 and p.filter == 0.0, "window settings restored")
	n = 10.0
	for key: String in p.SETTINGS_NUMBERS:
		check(G.get(key) == n, "restored " + key)
		n += 1.0
	check(G.last_level == "关卡.swe", "level name restored")
	check(G.name_users == "玩家", "original name_user to name_users mapping")
	check(G.my1 == "作者", "author restored")
	DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
	print("settings tests: %d checks, %d failed" % [checks, failures])
	get_tree().quit(1 if failures else 0)
