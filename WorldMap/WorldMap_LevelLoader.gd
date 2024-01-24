@tool
extends Node3D

@export var world_index: int = 1
@export_file("*.tscn") var level_path: String

func _ready():
	updateLevelLabelText()

func _process(delta):
	if Engine.is_editor_hint():
		updateLevelLabelText()

func updateLevelLabelText():
	$Label3D.text = "Level " + str(world_index)
	
	
