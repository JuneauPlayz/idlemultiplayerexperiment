extends Node2D
const INVENTORY_ITEM = preload("res://inventory_item.tscn")
@onready var item_showcase: GridContainer = $PanelContainer/MarginContainer/ItemShowcase
@onready var basic_gem: TextureButton = $Equipped/FirstColumn/BasicGemContainer/BasicGem
@onready var headpiece: TextureButton = $Equipped/FirstColumn/HeadpieceContainer/Headpiece
@onready var chestpiece: TextureButton = $Equipped/FirstColumn/ChestpieceContainer/Chestpiece
@onready var weapon: TextureButton = $Equipped/FirstColumn/WeaponContainer/Weapon
@onready var ability_gem: TextureButton = $Equipped/SecondColumn/AbilityGemContainer/AbilityGem
@onready var leggings: TextureButton = $Equipped/SecondColumn/LeggingsContainer/Leggings
@onready var boots: TextureButton = $Equipped/SecondColumn/BootsContainer/Boots
@onready var accessory: TextureButton = $Equipped/SecondColumn/AccessoryContainer/Accessory

const QUYESTIONMARK = preload("res://quyestionmark.png")

var game
var type
var currently_equipping

func _ready() -> void:
	game = get_tree().get_first_node_in_group("game")

func show_items(type, general):
	for item in item_showcase.get_children():
		item.queue_free()
	for item in game.get_items(type):
		var new_item = INVENTORY_ITEM.instantiate()
		item_showcase.add_child(new_item)
		new_item.update(QUYESTIONMARK, item['name'], item)
	if general != null:
		for item in game.get_items(general):
			var new_item = INVENTORY_ITEM.instantiate()
			item_showcase.add_child(new_item)
			new_item.update(QUYESTIONMARK, item['name'], item)

func update(type):
	match type:
		C.TANK:
			self.type = C.TANK
		C.PHYS:
			self.type = C.PHYS
		C.MAG:
			self.type = C.MAG
		C.HEAL:
			self.type = C.HEAL

func update_equip(item, image):
	match currently_equipping:
		C.BASIC:
			update_all(basic_gem, image)
			game.update_equipment(self.type, item)
		C.ABILITY:
			update_all(ability_gem, image)
			game.update_equipment(self.type, item)
		C.HEAD:
			update_all(headpiece, image)
			game.update_equipment(self.type, item)
		C.CHEST:
			update_all(chestpiece, image)
			game.update_equipment(self.type, item)
		C.WEAPON:
			update_all(weapon, image)
			game.update_equipment(self.type, item)
		C.LEG:
			update_all(leggings, image)
			game.update_equipment(self.type, item)
		C.BOOTS:
			update_all(boots, image)
			game.update_equipment(self.type, item)
		C.ACC:
			update_all(accessory, image)
			game.update_equipment(self.type, item)
			
func update_all(button, image):
	button.texture_normal = image
	button.texture_pressed = image
	button.texture_hover = image
	button.texture_disabled = image
	button.texture_focused = image
	button.texture_click_mask = image

func _on_headpiece_pressed() -> void:
	var equip_type = type + C.HEAD
	show_items(equip_type, C.HEAD)
	currently_equipping = C.HEAD
	
func _on_chestpiece_pressed() -> void:
	var equip_type = type + C.CHEST
	show_items(equip_type, C.CHEST)
	currently_equipping = C.CHEST

func _on_weapon_pressed() -> void:
	var equip_type = type + C.WEAPON
	show_items(equip_type, C.WEAPON)
	currently_equipping = C.WEAPON

func _on_basic_gem_pressed() -> void:
	var equip_type = type + C.BASIC
	show_items(equip_type, C.BASIC)
	currently_equipping = C.BASIC

func _on_ability_gem_pressed() -> void:
	var equip_type = type + C.ABILITY
	show_items(equip_type, C.ABILITY)
	currently_equipping = C.ABILITY

func _on_leggings_pressed() -> void:
	var equip_type = type + C.LEG
	show_items(equip_type, C.LEG)
	currently_equipping = C.LEG

func _on_boots_pressed() -> void:
	var equip_type = type + C.BOOTS
	show_items(equip_type, C.BOOTS)
	currently_equipping = C.BOOTS

func _on_accessory_pressed() -> void:
	var equip_type = type + C.ACC
	show_items(equip_type, C.ACC)
	currently_equipping = C.ACC

func _on_back_pressed() -> void:
	game.new_scene(game.MAIN_MENU, null)
	
