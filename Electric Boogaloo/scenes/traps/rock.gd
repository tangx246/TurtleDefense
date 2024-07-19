extends Node3D

func _on_area_3d_body_entered(body):
	var turtle = body.get_parent() as Turtle
	if turtle:
		print("Turtle in rock. Teleporting turtle")
		turtle.teleport_towards_closest_shoreline()
