extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_open_releases_page_pressed() -> void:
	OS.shell_open("https://github.com/JuneauPlayz/idlemultiplayerexperiment/releases")
	get_tree().quit()
