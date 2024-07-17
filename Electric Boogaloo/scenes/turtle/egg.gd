class_name Egg
extends Node3D

@export var turtle : PackedScene
@export var eggCrack : PackedScene
@export var eggHatchSound : AudioStream
@onready var text : Label3D = %CountdownText
@onready var timer : Timer = %Timer
@onready var anim : AnimationPlayer = %AnimationPlayer

func _process(_delta):
	if timer.is_stopped():
		text.text = "%.1f" % timer.wait_time
	else:
		text.text = "%.1f" % timer.time_left
		if timer.time_left < 0.5 and not anim.is_playing():
			anim.play(&"Anim-Egg-Shake/Shake")
			var player = AudioStreamPlayer3D.new()
			player.finished.connect(func(): player.queue_free())
			get_parent().add_child(player)
			player.global_position = global_position
			player.stream = eggHatchSound
			player.play()
			

func hatch():
	var parent = get_parent()
	var instantiated = turtle.instantiate()
	
	instantiated.position = position
	instantiated.rotation = rotation
	parent.add_child(instantiated)
	
	var eggCrackEffect : Node3D = eggCrack.instantiate()
	parent.add_child(eggCrackEffect)
	eggCrackEffect.global_position = global_position
	eggCrackEffect.global_rotation = global_rotation
	
	parent.remove_child(self)
	queue_free()
