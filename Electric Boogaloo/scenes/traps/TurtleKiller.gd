class_name TurtleKiller
extends Node3D

func kill_turtle(turtle : Node3D):
	var victoryFailureConditions : VictoryFailureConditions = get_tree().get_first_node_in_group(VictoryFailureConditions.tag)
	victoryFailureConditions.kill_turtle()
	turtle.queue_free()
