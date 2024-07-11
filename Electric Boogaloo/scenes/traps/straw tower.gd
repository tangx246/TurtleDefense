extends Node3D

@onready var area : Area3D = %Area3D
@export var strawFiringSource : Node3D
@export var strawModel : PackedScene

func fire_straw():
	var closestDistance : float = INF
	var closestTurtle : Turtle
	for body in area.get_overlapping_bodies():
		var bodyParent = body.get_parent() as Turtle
		if bodyParent and not bodyParent.dead:
			var distance : float = global_position.distance_squared_to(body.global_position)
			if distance < closestDistance:
				closestDistance = distance
				closestTurtle = bodyParent
		
	if closestTurtle:
		var straw : Node3D = strawModel.instantiate()
		add_child(straw)
		straw.global_position = strawFiringSource.global_position
		var tween = straw.create_tween()
		tween.tween_property(straw, "global_position", closestTurtle.get_node("%MovementAgent").global_position, 0.2)
		tween.tween_callback(straw.queue_free)
		tween.play()
		await tween.finished
		if is_instance_valid(closestTurtle):
			closestTurtle.kill()
