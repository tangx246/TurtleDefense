class_name Egg
extends Node3D

@export var turtle : PackedScene
@export var eggCrack : PackedScene
@onready var text : Label3D = %CountdownText
@onready var timer : Timer = %Timer

func _process(delta : float):
	if timer.is_stopped():
		text.text = "%.1f" % timer.wait_time
	else:
		text.text = "%.1f" % timer.time_left

func hatch():
	var parent = get_parent()
	var instantiated = turtle.instantiate()
	
	parent.add_child(instantiated)
	instantiated.global_position = global_position
	instantiated.global_rotation = global_rotation
	
	var eggCrackEffect : Node3D = eggCrack.instantiate()
	parent.add_child(eggCrackEffect)
	eggCrackEffect.global_position = global_position
	eggCrackEffect.global_rotation = global_rotation
	
	parent.remove_child(self)
	queue_free()
