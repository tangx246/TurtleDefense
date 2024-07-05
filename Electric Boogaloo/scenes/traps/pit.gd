extends Node3D

@onready var turtleKiller : TurtleKiller = %TurtleKiller

func _on_area_3d_body_entered(body : Node3D):
	var bodyParent = body.get_parent()
	if bodyParent.is_in_group("Turtle"):
		turtleKiller.kill_turtle(bodyParent)
