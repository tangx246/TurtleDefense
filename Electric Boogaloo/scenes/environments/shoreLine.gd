class_name ShoreLine
extends Node3D

signal turtle_escaped

func _on_area_3d_body_entered(body : Node3D):
	if not body.get_parent() is Turtle:
		return
	
	turtle_escaped.emit()
	body.get_parent().queue_free()
