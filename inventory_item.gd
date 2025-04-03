extends Control

@onready var image: TextureButton = $Image
@onready var item_name: RichTextLabel = $ItemName

var game
var item
var current_image


func _ready() -> void:
	game = get_tree().get_first_node_in_group("game")
	
func update(image, name, item):
	update_all(image)
	self.current_image = image
	self.item_name.text = name
	self.item = item

func _on_image_pressed() -> void:
	game.current_scene.update_equip(item, current_image)
	
func update_all(new_image):
	self.image.texture_normal = new_image
	self.image.texture_pressed = new_image
	self.image.texture_hover = new_image
	self.image.texture_disabled = new_image
	self.image.texture_focused = new_image
	self.image.texture_click_mask = new_image
