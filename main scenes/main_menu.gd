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
