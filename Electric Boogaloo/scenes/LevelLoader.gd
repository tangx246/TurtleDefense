extends Node3D

@export var levels : Array[Level]
@onready var environment : NavigationRegion3D = %Environment
@onready var trapCounts : TrapCounts = %TrapCounts
@onready var victoryFailureCondition : VictoryFailureConditions = %VictoryFailureConditions

@export var currentLevelIndex : int = 0

func _ready():
	loadLevel(levels[currentLevelIndex])

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

	trapCounts.traps = level.trapCounts
	trapCounts.do_button_visibility_checks()
	trapCounts.update_counts()
