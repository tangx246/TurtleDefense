class_name LevelLoader
extends Node3D

@export var levels : Levels
@onready var environment : NavigationRegion3D = %Environment
@onready var trapCounts : TrapCounts = %TrapCounts
@onready var victoryFailureCondition : VictoryFailureConditions = %VictoryFailureConditions
@onready var victoryDefeatUi : Control = %VictoryDefeat
@onready var helpTooltip : Control = %Help

@export var currentLevelIndex : int = 0

func _ready():
	if LevelLoadRequest.level != null:
		currentLevelIndex = levels.levels.find(LevelLoadRequest.level)
		LevelLoadRequest.level = null
	loadCurrentLevel()

func nextLevel():
	currentLevelIndex = currentLevelIndex + 1
	loadCurrentLevel()
	
func loadCurrentLevel():
	loadLevel(levels.levels[currentLevelIndex])
	
func hasNextLevel() -> bool:
	return currentLevelIndex < levels.levels.size() - 1

func loadLevel(level: Level):	
	for child in environment.get_children():
		environment.remove_child(child)
		child.queue_free()
		
	var newEnv = level.environment.instantiate()
	environment.add_child(newEnv)
	environment.bake_navigation_mesh()
	for shoreline : ShoreLine in get_tree().get_nodes_in_group("ShoreLine"):
		shoreline.turtle_escaped.connect(victoryFailureCondition.turtle_escaped)
	victoryFailureCondition.turtles_alive = get_tree().get_nodes_in_group("Egg").size()
	victoryFailureCondition.reset()

	trapCounts.setTrapCount(level.trapCounts)
	trapCounts.do_button_visibility_checks()
	trapCounts.update_counts()

	victoryDefeatUi.visible = false
	
	helpTooltip.visible = !level.helpTooltip.is_empty()
	helpTooltip.tooltip_text = level.helpTooltip


func _on_victory_failure_conditions_game_end(victory):
	if victory:
		LevelProgress.setCurrentProgress(currentLevelIndex + 1)
