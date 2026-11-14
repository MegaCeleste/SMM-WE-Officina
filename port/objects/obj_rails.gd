extends GMObject

var type: float = 0.0
var size_x: float = 0.0
var size_y: float = 0.0
var sprite: int = 0
var index: float = 0.0
var drawX: float = 0.0
var railLength: float = 0.0
var railSprite: int = 0
var pathIndex: int = 0


# from objects/obj_rails/Create_0.gml
func _create() -> void:
	instance_destroy()
	type = 0.0
	size_x = 3.0
	size_y = 3.0
	sprite = 0
	index = 0.0
	drawX = 0.0
	railLength = size_x  # Assuming size_x represents the length of the rail
	railSprite = sprite  # Replace sprite with the actual sprite you want to use for the rail
	pathIndex = GM.path_add()  # create a new path


# from objects/obj_rails/Step_0.gml
func _step() -> void:
	#
	# path_add_point(pathIndex, x, y,1); // add points to the path (replace x and y with your desired coordinates)
	# path_add_point(pathIndex,railLength, y,1); // add more points as needed
	#
	# var pathLength = path_get_length(pathIndex); // get the length of the path
	# /*
	pass


# from objects/obj_rails/Draw_0.gml
func _gm_draw() -> void:
	railLength = size_x
	var h: float = 0.0
	while h < railLength:
		var index: float = 0.0
		if h == 0.0:
			index = 0.0
		elif h == railLength - 1.0:
			index = 2.0
		else:
			index = 1.0
		# Add points to the path in the forward direction
		GM.path_add_point(pathIndex, x + (h * 16.0), y, 0.1)
		# Draw the rail sprite at each point
		GM.draw_sprite(sprite, index, x + (h * 16.0), y)
		h += 1.0
	# Add points to the path in the reverse direction
	h = railLength - 2.0
	while h > 0.0:
		GM.path_add_point(pathIndex, x + (h * 16.0), y, 0.1)
		h -= 1.0
