extends "res://tests/test_enemies.gd"
## 第 8 批快速截图入口。必须使用真实渲染器，不带 --headless。
## godot --path port res://tests/shot_bosses.tscn -- <绝对输出目录> [画风 0..3]
## 每种画风只载入一次，逐个摆放并手动推进两步，等待真实绘制完成后保存。
## 普通对象按 scr_edit_to_play 映射；壳和死亡对象的配套状态来自原版创建事件。

const BossTests = preload("res://tests/test_bosses.gd")
const DEATH_NAMES: Array[String] = ["obj_bowser_dead", "obj_bowser_dead_castle", "obj_bowserjr_dead_castle", "obj_enemy_dead_castle"]

var _out: String = ""
var _baseline: Array[GMObject] = []
var _shots: int = 0


func _clear_samples() -> void:
	for inst: GMObject in GM.instances.duplicate():
		if is_instance_valid(inst) and not inst._destroyed and not _baseline.has(inst):
			GM.instance_destroy(inst)


func _live(name: String, m: GMObject) -> GMObject:
	var b: GMObject = GM.instance_create(m.x + 128.0, 368.0, GM.asset_get_index(name))
	BossTests.apply_resource_defaults(b, name)
	if b.sprite_index >= 0:
		b.y += 383.0 - b.bbox_bottom
	b.yprevious = b.y
	return b


func _sample(style: int, name: String, m: GMObject) -> GMObject:
	if name == "obj_bowserjr_shell":
		# from obj_bowserjr/Alarm_7: carry fire HP, HP, wings and key into the new shell.
		var j: GMObject = _live("obj_NSMBU_bowserjr" if style == 3 else "obj_bowserjr", m)
		var previous: GMObject = GM.other
		GM.other = j
		j.call("_alarm_7")
		GM.other = previous
		return GM.instance_find(A.obj_bowserjr_shell, 0)
	if not DEATH_NAMES.has(name):
		return _live(name, m)
	var source_name: String = BossTests.names_for(style, "bowser")[0]
	if name == "obj_bowserjr_dead_castle":
		source_name = "obj_NSMBU_bowserjr" if style == 3 else "obj_bowserjr"
	elif name == "obj_enemy_dead_castle":
		source_name = "obj_NSMBU_boomboom" if style == 3 else "obj_boomboom"
	var source: GMObject = _live(source_name, m)
	if name == "obj_bowser_dead":
		# from each Bowser/Other_10: let the actual event provide sprite, direct and launch speed.
		var previous: GMObject = GM.other
		GM.other = m
		source.call("_user_0")
		GM.other = previous
		return source.get("imdead")
	# from obj_axe_smw/Other_10: castle corpses copy sprite, frame and direct from the live source.
	var corpse: GMObject = GM.instance_create(source.x, source.y, GM.asset_get_index(name))
	corpse.sprite_index = source.sprite_index
	corpse.image_index = source.image_index
	corpse.set("direct", source.get("direct"))
	GM.instance_destroy(source)
	return corpse


func _save(style: int, name: String, m: GMObject) -> void:
	var b: GMObject = _sample(style, name, m)
	ok(b != null, "%s style %d：截图对象已创建" % [name, style])
	if b == null:
		return
	var waiting_for_sprite: bool = b.sprite_index < 0
	# The first frame updates the world SubViewport; the next displays its texture in Draw GUI.
	for frame: int in 3:
		if frame < 2:
			GM.tick()
		# The _b Junior has no YY sprite and first selects it in inherited Step End.
		# Once selected, align this isolated preview object with the preview ground.
		if waiting_for_sprite and b.sprite_index >= 0:
			b.y += 383.0 - b.bbox_bottom
			b.yprevious = b.y
			waiting_for_sprite = false
		var camera: int = GM.view_get_camera(0)
		GM.camera_set_view_target(camera, null)
		GM.camera_set_view_pos(camera, 224.0, 192.0)
		GM._phase_draw()
		await get_tree().process_frame
		await RenderingServer.frame_post_draw
	ok(b.sprite_index >= 0, "%s style %d：推进后有精灵" % [name, style])
	var img: Image = get_viewport().get_texture().get_image()
	var colours: Dictionary = {}
	for row: int in 12:
		for col: int in 24:
			var px: int = mini(img.get_width() - 1, col * img.get_width() / 24)
			var py: int = mini(img.get_height() - 1, row * img.get_height() / 12)
			colours[img.get_pixel(px, py).to_rgba32()] = true
	ok(colours.size() > 3, "%s style %d：截图有场景颜色（非黑图）" % [name, style])
	var path: String = _out.path_join("boss_s%d_%s.png" % [style, name])
	var err: Error = img.save_png(path)
	ok(err == OK, "%s 写入成功" % path)
	_shots += 1
	print("SHOT ", path)


func _ready() -> void:
	GM.auto_tick = false
	var args: PackedStringArray = OS.get_cmdline_user_args()
	if args.is_empty() or not args[0].is_absolute_path():
		printerr("shot_bosses requires an absolute output directory")
		get_tree().quit(2)
		return
	_out = args[0]
	DirAccess.make_dir_recursive_absolute(_out)
	var styles: Array[int] = [0, 1, 2, 3]
	if args.size() > 1:
		styles = [clampi(int(args[1]), 0, 3)]
	for style: int in styles:
		var m: GMObject = _start(style)
		ok(m != null, "style %d：真实载入链有 Mario" % style)
		if m == null:
			continue
		_baseline.assign(GM.instances)
		var names: Array[String] = BossTests.names_for(style, "all")
		if style == 3:
			names.append("obj_NSMBU_bowserjr_b")
		names.append("obj_bowserjr_shell")
		names.append_array(DEATH_NAMES)
		for name: String in names:
			_clear_samples()
			m.x = 320.0
			m.y += 383.0 - m.bbox_bottom
			m.hspeed = 0.0
			m.vspeed = 0.0
			await _save(style, name, m)
	print("boss shots: %d images, %d checks, %d failed" % [_shots, _checks, _fails])
	get_tree().quit(1 if _fails > 0 else 0)
