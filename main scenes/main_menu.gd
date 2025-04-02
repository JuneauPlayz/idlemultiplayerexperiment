extends Node2D
@onready var name_label: Label = $Name

var game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = get_tree().get_first_node_in_group("game")
	name_label.text = "Name: " + game.account_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tank_gear_pressed() -> void:
	game.new_scene(game.CHANGE_EQUIPMENT, C.TANK)


func _on_phys_gear_pressed() -> void:
	game.new_scene(game.CHANGE_EQUIPMENT, C.PHYS)


func _on_mag_gear_pressed() -> void:
	game.new_scene(game.CHANGE_EQUIPMENT, C.MAG)


func _on_heal_gear_pressed() -> void:
	game.new_scene(game.CHANGE_EQUIPMENT, C.HEAL)
