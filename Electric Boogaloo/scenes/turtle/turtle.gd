class_name Turtle
extends Node3D

@export var turtleDeathSounds : Array[AudioStream]
@onready var agent : MovementAgent = %MovementAgent

func _ready():
	var shortestDistance : float = INF
	var closestShoreline : Node3D
	for shoreline : Node3D in get_tree().get_nodes_in_group("ShoreLine"):
		var distance = global_position.distance_squared_to(shoreline.global_position)
		if distance < shortestDistance:
			shortestDistance = distance
			closestShoreline = shoreline
			
	agent.set_movement_target(closestShoreline.global_position)

func kill():
	var victoryFailureConditions : VictoryFailureConditions = get_tree().get_first_node_in_group(VictoryFailureConditions.tag)
	victoryFailureConditions.kill_turtle()
	queue_free()
	
	var player = AudioStreamPlayer3D.new()
	player.finished.connect(func(): player.queue_free())
	get_parent().add_child(player)
	player.global_position = global_position
	player.stream = turtleDeathSounds[randi_range(0, turtleDeathSounds.size() - 1)]
	player.play()
