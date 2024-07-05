extends Node3D

func _on_area_3d_body_entered(body : Node3D):
	var bodyParent = body.get_parent()
	if bodyParent.is_in_group("Turtle"):
		var victoryFailureConditions : VictoryFailureConditions = get_tree().get_first_node_in_group(VictoryFailureConditions.tag)
		victoryFailureConditions.kill_turtle()
		bodyParent.queue_free()
