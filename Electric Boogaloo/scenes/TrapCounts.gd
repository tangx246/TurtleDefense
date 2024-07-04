class_name TrapCounts
extends Node

## PlacecItem to int expected
@export var traps : Array[TrapCount]

func get_count(item: PlacedItem) -> int:
	for trap in traps:
		if trap.trap == item:
			return trap.count
			
	return 0

func use(item: PlacedItem):
	for trap in traps:
		if trap.trap == item:
			trap.count = trap.count - 1
			update_counts()

func _button_visibility_check(button: PlacedItemButton):
	button.get_parent().visible = get_count(button.item) > 0
	
func do_button_visibility_checks():
	var buttons : Array[Node] = get_tree().get_nodes_in_group("PlacedItemButton")
	for button in buttons:
		_button_visibility_check(button)

func update_counts():
	var buttons : Array[Node] = get_tree().get_nodes_in_group("PlacedItemButton")
	for button : PlacedItemButton in buttons:
		var count : Label = button.get_parent().get_node("Count")
		count.text = str(get_count(button.item))
