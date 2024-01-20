extends Node3D

# projectile scene variable
@export var projectile_scene : PackedScene
@export var projectile_speed : float = 60.0
@export var fire_delay_seconds : float = 0.1

var scene_root
var accumulated_time = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	scene_root = get_tree().get_root()
	pass # Replace with function body.


func is_fire_pressed():
	return Input.is_action_pressed("fire") or Input.is_action_pressed("fire_gamepad")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# fire on mouse click
	if accumulated_time < fire_delay_seconds:
		accumulated_time += delta
	if is_fire_pressed() and accumulated_time > fire_delay_seconds:
		accumulated_time = 0.0
		fire()
		


func fire():
	var projectile = projectile_scene.instantiate()
	scene_root.add_child(projectile)
	projectile.global_transform = $hotspot.global_transform
	
    # get hotspot's forward vector in global space
	var forward = $hotspot.global_transform.basis.z
	var impulse_vector = projectile_speed * forward

	# apply velocity
	projectile.apply_impulse(impulse_vector, Vector3(0,0,0))
