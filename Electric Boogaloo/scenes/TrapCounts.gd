class_name TrapCounts
extends Node

## PlacedItem to int expected
var trapCount : Dictionary

func setTrapCount(traps : Array[TrapCount]):
	trapCount = {}
	for trap in traps:
		trapCount[trap.trap] = trap.count

func get_count(item: PlacedItem) -> int:
	var count = trapCount.get(item)
	if count == null:
		count = 0
		
	return count

func use(item: PlacedItem):
	var count = trapCount.get(item)
	if count == null:
		return
	else:
		trapCount[item] = count - 1
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
		var count : Label = button.get_parent().find_child("Count")
		count.text = str(get_count(button.item))
