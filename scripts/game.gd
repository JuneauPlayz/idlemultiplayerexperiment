extends Node2D

const LOGIN_MENU = preload("res://main scenes/login_menu.tscn")
const MAIN_MENU = preload("res://main scenes/main_menu.tscn")
const COMBAT = preload("res://main scenes/combat.tscn")

var current_scene
var account_name = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_scene(LOGIN_MENU)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_scene(scene):
	if current_scene != null:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	self.add_child(current_scene)
