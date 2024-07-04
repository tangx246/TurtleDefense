extends Node3D

@export var levels : Array[Level]
@onready var environment : NavigationRegion3D = %Environment
@onready var trapCounts : TrapCounts = %TrapCounts

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

	trapCounts.traps = level.trapCounts
	trapCounts.do_button_visibility_checks()
	trapCounts.update_counts()
