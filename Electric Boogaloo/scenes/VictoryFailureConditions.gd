class_name VictoryFailureConditions
extends Node

@export var turtles_alive : int
signal game_end(victory : bool)

const tag : StringName = "VictoryFailureConditions"

var locked : bool = false

func _ready():
	add_to_group(tag)

func turtle_escaped():
	if locked:
		return
	
	print("Failure")
	game_end.emit(false)
	locked = true
	
func all_turtles_killed():
	print("Victory")
	game_end.emit(true)
	locked = true

func reset():
	locked = false

func kill_turtle():
	if locked:
		return
		
	turtles_alive = turtles_alive - 1
	print("%d turtles alive" % turtles_alive)
	if turtles_alive <= 0:
		all_turtles_killed()
