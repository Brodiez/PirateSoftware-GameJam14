extends Node3D

class_name WorldNodeSelect

@onready var worlds: Array = [$Level1, $Level2, $Level3, $Level4, $Level5, $Level6, $Level7]

var current_world: int = 0

func _ready():
	$Player.global_position = worlds[current_world].global_position

func _input(event):
	if event.is_action_pressed("ui_right") and current_world < worlds.size() - 1:
		current_world += 1
		$Player.global_position = worlds[current_world].global_position
	if event.is_action_pressed("ui_left") and current_world > 0:
		current_world -= 1
		$Player.global_position = worlds[current_world].global_position
	if event.is_action_pressed("ui_accept"):
		if worlds[current_world].level_path:
			LoadingFunctions.load_screen_to_scene(worlds[current_world].level_path);
