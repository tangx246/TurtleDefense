extends Node3D

@export var active : bool = true
@export var area : Area3D

func _on_area_3d_body_entered(body):
	if !active:
		return

	var bodyParent : Node3D = body.get_parent() as Turtle
	if bodyParent:
		push_turtles.call_deferred()

func push_turtles():
	var overlappingBodies = area.get_overlapping_bodies()
	for overlappingBody in overlappingBodies:
		if overlappingBody.get_parent() is Turtle:
			var turtleBody : MovementAgent = overlappingBody
			var tween = create_tween()
			tween.tween_property(turtleBody, "position", position + basis * Vector3.BACK * 5, 0.2)
			active = false
