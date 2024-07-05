extends Node3D

func _on_area_3d_body_entered(body : Node3D):
	var bodyParent : Node3D = body.get_parent()
	if bodyParent.is_in_group("Turtle"):
		var moveAgent : MovementAgent = bodyParent.get_node(^"%MovementAgent")
		moveAgent.movement_speed = moveAgent.movement_speed / 4


func _on_area_3d_body_exited(body : Node3D):
	var bodyParent : Node3D = body.get_parent()
	if bodyParent.is_in_group("Turtle"):
		var moveAgent : MovementAgent = bodyParent.get_node(^"%MovementAgent")
		moveAgent.movement_speed = moveAgent.movement_speed * 4
