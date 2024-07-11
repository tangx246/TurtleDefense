extends Node3D

@onready var trapCounts : TrapCounts = %TrapCounts
@onready var environment : NavigationRegion3D = %Environment

signal item_successfully_placed

func on_placed_item(item : PlacedItem, global_pos : Vector3, global_rot : Vector3):
	if trapCounts.get_count(item) > 0:
		trapCounts.use(item)
		var instantiated : Node3D = item.placed_scene.instantiate()
		add_child(instantiated)
		instantiated.global_position = global_pos
		instantiated.global_rotation = global_rot
		environment.bake_navigation_mesh()
		item_successfully_placed.emit()
	
func start_egg_hatching():
	for egg in get_tree().get_nodes_in_group("Egg"):
		var timer : Timer = egg.get_node(^"%Timer")
		timer.start()
