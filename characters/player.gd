extends CharacterBody3D


var wordlspace : PhysicsDirectSpaceState3D 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const SPEED = 10.0
const JUMP_VELOCITY = 4.5


func get_aim_direction() -> Quaternion:
	# calculates look direction
	# mouse logic
	var aim_direction = self.global_transform.basis.get_rotation_quaternion()
	var mouse_position = get_viewport().get_mouse_position()
	var ray = PhysicsRayQueryParameters3D.new()
	
	ray.from = $CameraPivot/Camera3D.project_ray_origin(mouse_position)
	ray.to = ray.from + $CameraPivot/Camera3D.project_ray_normal(mouse_position) * 2000
	
	var hit_result = wordlspace.intersect_ray(ray)
	
	if hit_result:
		var _direction = self.global_transform.origin.direction_to(hit_result.position)
		_direction.y = 0
		aim_direction = Quaternion(Vector3.FORWARD, _direction)
		
	# TODO: gamepad logic
	return aim_direction

func _ready():
	wordlspace = get_world_3d().get_direct_space_state()

func _physics_process(delta):
	# Set player look direction.
	$Capsule.set_quaternion(get_aim_direction())
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
