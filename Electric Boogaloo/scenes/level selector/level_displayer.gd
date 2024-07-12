class_name LevelDisplayer
extends Control

@export var levels : Levels
@export var gameScene : PackedScene
@onready var nameLabel : Button = %Name

var level : Level

func display(incomingLevel : Level):
	self.level = incomingLevel
	nameLabel.text = "Level %d" % levels.levels.find(incomingLevel)
	
	var levelIndex = levels.levels.find(incomingLevel)
	nameLabel.disabled = levelIndex > LevelProgress.getCurrentProgress()
		

func launch_level():
	LevelLoadRequest.level = level
	get_tree().change_scene_to_packed(gameScene)
