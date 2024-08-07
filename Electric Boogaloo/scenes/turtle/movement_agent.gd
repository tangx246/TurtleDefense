class_name MovementAgent
extends CharacterBody3D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

var tween : Tween
var forced_velocity : Vector3 = Vector3.ZERO

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	if tween:
		tween.kill()
	if safe_velocity.normalized().dot(Vector3.UP) < 0.9 and safe_velocity.abs().length() > 0.1:
		var old_rotation = rotation
		look_at(global_position + safe_velocity)
		var new_rotation = rotation
		rotation = old_rotation
		tween = create_tween()
		tween.tween_property(self, "rotation", new_rotation, 0.1)
	velocity = safe_velocity + forced_velocity
	move_and_slide()
