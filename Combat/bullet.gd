extends RigidBody3D


var max_collisions : int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# detect collisions
	if get_contact_count() >= max_collisions:
		# destroy the object
		queue_free()

