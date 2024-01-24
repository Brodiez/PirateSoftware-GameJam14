extends RigidBody3D


var max_collisions : int = 2
var life_time : float = 0.0
const KILL_TIME : float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	life_time = KILL_TIME
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	life_time -= delta
	if get_contact_count() >= max_collisions or life_time <= 0.0:
		# destroy the object
		queue_free()

