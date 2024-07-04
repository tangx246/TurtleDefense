class_name VictoryFailureConditions
extends Node

@export var turtles_alive : int

func turtle_escaped():
	print("Failure")
	
func all_turtles_killed():
	print("Victory")
