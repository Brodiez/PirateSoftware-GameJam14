@tool
extends Control

@export var world_index: int = 1

func _ready():
	updateLevelLabelText()

func _process(delta):
	if Engine.is_editor_hint():
		updateLevelLabelText()

func updateLevelLabelText():
	$Label.text = "Level " + str(world_index)
	
	
