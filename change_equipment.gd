extends Node2D
const INVENTORY_ITEM = preload("res://inventory_item.tscn")
@onready var item_showcase: GridContainer = $PanelContainer/MarginContainer/ItemShowcase

var game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = get_tree().get_first_node_in_group("game")

func show_items(type):
	for item in item_showcase.get_children():
		item.queue_free()
	for item in game.get_items(type):
		var new_item = INVENTORY_ITEM.instantiate()
		item_showcase.add_child(new_item)
		new_item.update(new_item.image, item['name'])
		


func _on_button_pressed() -> void:
	show_items("PhysicalDPSWeapon")


func _on_button_2_pressed() -> void:
	show_items("MagicDPSHeadpiece")
