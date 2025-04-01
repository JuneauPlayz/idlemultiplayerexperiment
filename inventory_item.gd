extends Control

@onready var image: TextureRect = $Image
@onready var item_name: RichTextLabel = $ItemName

func update(image, name):
	self.image = image
	self.item_name.text = name
