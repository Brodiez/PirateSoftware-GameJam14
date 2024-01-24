extends RigidBody3D

var life_time : float = 0.0
const KILL_TIME : float = 2
const DAMAGE : float = 34.0

# Called when the node enters the scene tree for the first time.
func _ready():
	life_time = KILL_TIME


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	life_time -= delta
	if life_time <= 0.0:
		# destroy the object
		queue_free()


func _on_body_entered(body:Node):
	# check if body has health component
	if body.has_method("apply_damage"):
		body.apply_damage(DAMAGE)
		# destroy the object
		queue_free()

