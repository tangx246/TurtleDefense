extends Container

@export var levels : Levels
@onready var levelDisplayer : PackedScene = load("res://scenes/level selector/level_displayer.tscn")

func _ready():
	for child in get_children():
		remove_child(child)
		child.queue_free()
	for level in levels.levels:
		var instance = levelDisplayer.instantiate() as LevelDisplayer
		add_child(instance)
		instance.display(level)
