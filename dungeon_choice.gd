extends Node2D

var game

func _ready():
	game = get_tree().get_first_node_in_group("game")
	
func _on_dungeon_1_pressed() -> void:
	game.load_combat(C.DUNGEON_1)
