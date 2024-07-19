extends Node3D

@export var active : bool = true
@export var area : Area3D
@export var strength : float = 50

signal turtles_pushed

func _on_area_3d_body_entered(body):
	if !active:
		return

	var bodyParent : Node3D = body.get_parent() as Turtle
	if bodyParent:
		push_turtles.call_deferred()

func push_turtles():
	turtles_pushed.emit()
	var overlappingBodies = area.get_overlapping_bodies()
	for overlappingBody in overlappingBodies:
		if overlappingBody.get_parent() is Turtle:
			var turtleBody : MovementAgent = overlappingBody
			var forced_velocity : Vector3 = position + basis * Vector3.BACK * strength
			turtleBody.forced_velocity = turtleBody.forced_velocity + forced_velocity
			var timer = Timer.new()
			turtleBody.add_child(timer)
			timer.timeout.connect(func(): 
				turtleBody.forced_velocity = turtleBody.forced_velocity - forced_velocity
				timer.queue_free()
			)
			timer.start(0.2)
			active = false
