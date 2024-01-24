extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_node("../Player")

const SPEED = 3.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

func update_target_location(target: Node3D):
	nav_agent.target_location = target.global_transform.origin

func update_heading(target: Vector3):
	# rotate self to face target
	var _direction = (target - self.global_transform.origin).normalized()
	_direction.y = 0
	self.set_quaternion(Quaternion(Vector3.FORWARD, _direction))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	update_target_location(player)
	var current_location = self.global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	new_velocity = new_velocity.move_toward(velocity, SPEED * delta)
	
	
	nav_agent.velocity = new_velocity
	update_heading(next_location)
	move_and_slide()


func _on_navigation_agent_3d_velocity_computed(safe_velocity:Vector3):
	velocity = safe_velocity
