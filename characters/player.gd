extends CharacterBody3D

var is_gamepad = false
var wordlspace : PhysicsDirectSpaceState3D 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

var cached_aim_direction : Quaternion = Quaternion()


func get_aim_direction() -> Quaternion:
	var aim_direction = self.global_transform.basis.get_rotation_quaternion()
	# calculates look direction
	if is_gamepad:
		# gamepad logic
		var input_vector = Vector3()
		input_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
		input_vector.z = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
		print(input_vector)
		if input_vector.length_squared() > 0.0:
			input_vector = input_vector.normalized()
			input_vector = Vector3(input_vector.x, 0, input_vector.z)
			aim_direction = Quaternion(Vector3.FORWARD, input_vector)
			cached_aim_direction = aim_direction
		else:
			aim_direction = cached_aim_direction
	else:
		# mouse logic
		var mouse_position = get_viewport().get_mouse_position()
		var ray = PhysicsRayQueryParameters3D.new()
		
		ray.from = $CameraPivot/Camera3D.project_ray_origin(mouse_position)
		ray.to = ray.from + $CameraPivot/Camera3D.project_ray_normal(mouse_position) * 2000
		
		var hit_result = wordlspace.intersect_ray(ray)
		
		if hit_result:
			var _hit_position = hit_result.position
			_hit_position.y = self.global_position.y
			var _direction = self.global_transform.origin.direction_to(_hit_position)
			aim_direction = Quaternion(Vector3.FORWARD, _direction)
		
	return aim_direction

func _ready():
	# reset camera Y rotation
	$CameraPivot.rotation_degrees.y = 0
	
	wordlspace = get_world_3d().get_direct_space_state()

func _physics_process(delta):
	if get_tree().current_scene.scene_file_path == "res://WorldMap/WorldMap.tscn":
		return
		
	# Set player look direction.
	self.set_quaternion(get_aim_direction())
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("fire"):
		is_gamepad = false
	if Input.is_action_just_pressed("fire_gamepad"):
		is_gamepad = true
	
