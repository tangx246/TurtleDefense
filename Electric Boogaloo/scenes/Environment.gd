extends Node3D

@onready var trapCounts : TrapCounts = %TrapCounts

func on_placed_item(item : PlacedItem, global_pos : Vector3, global_rot : Vector3):
	if trapCounts.get_count(item) > 0:
		trapCounts.use(item)
		var instantiated : Node3D = item.placed_scene.instantiate()
		add_child(instantiated)
		instantiated.global_position = global_pos
		instantiated.global_rotation = global_rot
	
