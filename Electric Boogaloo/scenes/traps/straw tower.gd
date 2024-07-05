extends Node3D

@onready var area : Area3D = %Area3D
@onready var turtleKiller : TurtleKiller = %TurtleKiller

func fire_straw():
	var closestDistance : float = INF
	var closestTurtle : Node3D
	for body in area.get_overlapping_bodies():
		var bodyParent = body.get_parent()
		if bodyParent.is_in_group("Turtle"):
			var distance : float = global_position.distance_squared_to(body.global_position)
			if distance < closestDistance:
				closestDistance = distance
				closestTurtle = bodyParent
		
	if closestTurtle:
		turtleKiller.kill_turtle(closestTurtle)
