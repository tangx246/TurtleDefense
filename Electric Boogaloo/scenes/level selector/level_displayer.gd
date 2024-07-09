class_name LevelDisplayer
extends Control

@export var levels : Levels
@export var gameScene : PackedScene
@onready var nameLabel : Button = %Name

var level : Level

func display(incomingLevel : Level):
	self.level = incomingLevel
	nameLabel.text = "Level %d" % levels.levels.find(incomingLevel)

func launch_level():
	LevelLoadRequest.level = level
	get_tree().change_scene_to_packed(gameScene)
