class_name ShoreLine
extends Node3D

signal turtle_escaped

func _on_area_3d_body_entered(body : Node3D):
	var turtle = body.get_parent() as Turtle
	if not turtle:
		return
	
	turtle_escaped.emit()
	turtle.queue_free()
