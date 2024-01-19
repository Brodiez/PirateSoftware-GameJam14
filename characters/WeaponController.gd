extends Node

@export var default_weapon : PackedScene
@export var weapon_socket : NodePath
var equipped_weapon : Node = null


# equip new weapon method and remove old weapon
func equip_weapon(weapon : PackedScene):
	if equipped_weapon:
		equipped_weapon.queue_free()
	equipped_weapon = weapon.instantiate()
	# attach weapon to weapon socket
	get_node(weapon_socket).add_child(equipped_weapon)

# Called when the node enters the scene tree for the first time.
func _ready():
	if default_weapon:
		equip_weapon(default_weapon)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


