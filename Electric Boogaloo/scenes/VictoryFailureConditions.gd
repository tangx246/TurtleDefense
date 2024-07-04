class_name VictoryFailureConditions
extends Node

@export var turtles_alive : int

const tag : StringName = "VictoryFailureConditions"

func _ready():
	add_to_group(tag)

func turtle_escaped():
	print("Failure")
	
func all_turtles_killed():
	print("Victory")

func kill_turtle():
	turtles_alive = turtles_alive - 1
	print("%d turtles alive" % turtles_alive)
	if turtles_alive <= 0:
		all_turtles_killed()
