extends Control
class_name WorldNodeSelect

@onready var worlds: Array = [$WorldNode, $WorldNode2, $WorldNode3, $WorldNode4, $WorldNode5, $WorldNode6, $WorldNode7]

var current_world: int = 0

func _ready():
	$LevelSelectIcon.global_position = worlds[current_world].global_position

func _input(event):
	if event.is_action_pressed("ui_right") and current_world < worlds.size() - 1:
		current_world += 1
		$LevelSelectIcon.global_position = worlds[current_world].global_position
	if event.is_action_pressed("ui_left") and current_world > 0:
		current_world -= 1
		$LevelSelectIcon.global_position = worlds[current_world].global_position
	if event.is_action_pressed("ui_accept"):
		if worlds[current_world].level_path:
			LoadingFunctions.load_screen_to_scene(worlds[current_world].level_path);
		
	
