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
			var forced_velocity : Vector3 = basis * Vector3.BACK * strength
			turtleBody.forced_velocity = turtleBody.forced_velocity + forced_velocity
			turtleBody.movement_speed = turtleBody.movement_speed / 4
			var timer = Timer.new()
			turtleBody.add_child(timer)
			timer.timeout.connect(func(): 
				turtleBody.forced_velocity = turtleBody.forced_velocity - forced_velocity
				timer.queue_free()
			)
			timer.start(0.2)
			
			var newerTimer = Timer.new()
			turtleBody.add_child(newerTimer)
			newerTimer.timeout.connect(func():
				turtleBody.movement_speed = turtleBody.movement_speed * 4
				newerTimer.queue_free()
			)
			newerTimer.start(1.2)
			active = false
			
	var timer = Timer.new()
	add_child(timer)
	timer.start(3)
	timer.timeout.connect(func(): queue_free())
