extends Node3D

func _on_area_3d_body_entered(body : Node3D):
	var bodyParent = body.get_parent()
	if bodyParent.is_in_group("Turtle"):
		(bodyParent as Turtle).kill()
