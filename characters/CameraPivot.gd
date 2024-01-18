extends Node3D


var root
var LERP_FACTOR = 10
var OFFSET_FACTOR = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get position of tree root
	root = get_parent()
	
	if root:
		var root_pos = root.global_position + root.velocity * OFFSET_FACTOR
		# interpolate position of camera
		var new_pos = self.global_position.lerp(root_pos, delta * LERP_FACTOR)
		# set position of self
		self.global_position = new_pos
