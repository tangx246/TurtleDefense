extends Panel

@export var levelSelectorScene : String = "res://scenes/level selector/level_selector.tscn"
@onready var victoryFailureConditions : VictoryFailureConditions = %VictoryFailureConditions
@onready var victoryPanel : Control = %VictoryVBoxContainer
@onready var defeatPanel : Control = %DefeatVBoxContainer
@onready var gameCompletePanel : Control = %GameCompletePanel
@onready var levelLoader : LevelLoader = %LevelLoader

func _ready():
	victoryFailureConditions.game_end.connect(on_game_end)

func on_game_end(victory : bool):
	visible = true
	defeatPanel.visible = !victory
	var hasNextLevel : bool = levelLoader.hasNextLevel()
	victoryPanel.visible = victory and hasNextLevel
	gameCompletePanel.visible = victory and !hasNextLevel

func load_level_selector():
	get_tree().change_scene_to_file(levelSelectorScene)
