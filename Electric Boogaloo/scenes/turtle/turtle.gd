class_name Turtle
extends Node3D

@export var turtleDeathSounds : Array[AudioStream]
@export var desiredDistance : float = 1.5
@onready var agent : MovementAgent = %MovementAgent
@onready var navAgent : NavigationAgent3D = %NavigationAgent3D

var dead : bool = false

var queryParams : NavigationPathQueryParameters3D
var queryResult : NavigationPathQueryResult3D

func _ready():
	queryParams = NavigationPathQueryParameters3D.new()
	queryParams.map = navAgent.get_navigation_map()
	queryParams.metadata_flags = navAgent.path_metadata_flags
	queryParams.navigation_layers = navAgent.navigation_layers
	queryParams.path_postprocessing = navAgent.path_postprocessing
	queryParams.pathfinding_algorithm = navAgent.pathfinding_algorithm
	
	queryResult = NavigationPathQueryResult3D.new()

func _physics_process(_delta):
	var shortestDistance : float = INF
	var closestShoreline : Node3D
	for shoreline : Node3D in get_tree().get_nodes_in_group("ShoreLine"):
		var distance = global_position.distance_squared_to(shoreline.global_position)
		if distance < shortestDistance and has_path_to(shoreline.global_position):
			shortestDistance = distance
			closestShoreline = shoreline
			
	agent.set_movement_target(closestShoreline.global_position)

func has_path_to(targetPos : Vector3) -> bool:
	queryResult.reset()
	queryParams.start_position = agent.global_position
	queryParams.target_position = targetPos
	NavigationServer3D.query_path(queryParams, queryResult)
	
	var pathFoundDistanceToTarget = queryResult.path[-1].distance_to(targetPos)
	return pathFoundDistanceToTarget < desiredDistance

func kill():
	if dead:
		return
	dead = true
	
	var victoryFailureConditions : VictoryFailureConditions = get_tree().get_first_node_in_group(VictoryFailureConditions.tag)
	victoryFailureConditions.kill_turtle()
	agent.movement_speed = 0
	
	var player = AudioStreamPlayer3D.new()
	player.finished.connect(func(): player.queue_free())
	get_parent().add_child(player)
	player.global_position = global_position
	player.stream = turtleDeathSounds[randi_range(0, turtleDeathSounds.size() - 1)]
	player.play()
