@tool
extends MarginContainer

signal pressed_item(item: PlacedItem)

@export var item : PlacedItem
@export var icon : Texture2D
@export var label : String
@export var topdownItemPlacer : TopdownItemPlacer
@export var click : AudioStreamPlayer

@onready var textureRect : TextureRect = %TextureRect
@onready var button : PlacedItemButton = %Button

func _ready():
	button.item = item
	button.tooltip_text = label
	textureRect.texture = icon

func _on_button_pressed_item(_item: PlacedItem):
	pressed_item.emit(item)
	topdownItemPlacer.place_item_requested(item)
	click.play()
