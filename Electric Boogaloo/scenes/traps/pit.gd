extends Node3D

func _on_area_3d_body_entered(body : Node3D):
	var bodyParent = body.get_parent() as Turtle
	if bodyParent:
		bodyParent.kill()
