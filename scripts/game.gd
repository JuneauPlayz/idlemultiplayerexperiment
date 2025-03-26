extends Node2D

@onready var version_checker: Node = $VersionChecker
@onready var inventory_manager: Node = $Inventory

var inventory

const LOGIN_MENU = preload("res://main scenes/login_menu.tscn")
const MAIN_MENU = preload("res://main scenes/main_menu.tscn")
const UPDATE_AVAILABLE = preload("res://update_available.tscn")
const CHANGE_EQUIPMENT = preload("res://change_equipment.tscn")

var current_scene
var account_name = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var result = await version_checker.check_version()
	if result.get_or_add("status") == "update":
		new_scene(UPDATE_AVAILABLE)
	elif result.get_or_add("status") == "current":
		new_scene(LOGIN_MENU)
	
	


func new_scene(scene):
	if current_scene != null:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	self.add_child(current_scene)

func load_inventory():
	inventory = await inventory_manager.fetch_inventory()
	
func get_items(type: String) -> Array:
	var result = []
	match type:
		# Physical DPS (8 types)
		"PhysicalDPSWeapon":
			for item in inventory:
				if item["context"] == "PhysicalDPSWeapon":
					result.append(item)
		"PhysicalDPSBasicGems":
			for item in inventory:
				if item["context"] == "PhysicalDPSBasicGems":
					result.append(item)
		"PhysicalDPSAbilityGems":
			for item in inventory:
				if item["context"] == "PhysicalDPSAbilityGems":
					result.append(item)
		"PhysicalDPSHeadpiece":
			for item in inventory:
				if item["context"] == "PhysicalDPSHeadpiece":
					result.append(item)
		"PhysicalDPSChestpiece":
			for item in inventory:
				if item["context"] == "PhysicalDPSChestpiece":
					result.append(item)
		"PhysicalDPSLeggings":
			for item in inventory:
				if item["context"] == "PhysicalDPSLeggings":
					result.append(item)
		"PhysicalDPSBoots":
			for item in inventory:
				if item["context"] == "PhysicalDPSBoots":
					result.append(item)
		"PhysicalDPSAccessory":
			for item in inventory:
				if item["context"] == "PhysicalDPSAccessory":
					result.append(item)

		# Magic DPS (8 types)
		"MagicDPSWeapon":
			for item in inventory:
				if item["context"] == "MagicDPSWeapon":
					result.append(item)
		"MagicDPSBasicGems":
			for item in inventory:
				if item["context"] == "MagicDPSBasicGems":
					result.append(item)
		"MagicDPSAbilityGems":
			for item in inventory:
				if item["context"] == "MagicDPSAbilityGems":
					result.append(item)
		"MagicDPSHeadpiece":
			for item in inventory:
				if item["context"] == "MagicDPSHeadpiece":
					result.append(item)
		"MagicDPSChestpiece":
			for item in inventory:
				if item["context"] == "MagicDPSChestpiece":
					result.append(item)
		"MagicDPSLeggings":
			for item in inventory:
				if item["context"] == "MagicDPSLeggings":
					result.append(item)
		"MagicDPSBoots":
			for item in inventory:
				if item["context"] == "MagicDPSBoots":
					result.append(item)
		"MagicDPSAccessory":
			for item in inventory:
				if item["context"] == "MagicDPSAccessory":
					result.append(item)

		# Tank (8 types)
		"TankWeapon":
			for item in inventory:
				if item["context"] == "TankWeapon":
					result.append(item)
		"TankBasicGems":
			for item in inventory:
				if item["context"] == "TankBasicGems":
					result.append(item)
		"TankAbilityGems":
			for item in inventory:
				if item["context"] == "TankAbilityGems":
					result.append(item)
		"TankHeadpiece":
			for item in inventory:
				if item["context"] == "TankHeadpiece":
					result.append(item)
		"TankChestpiece":
			for item in inventory:
				if item["context"] == "TankChestpiece":
					result.append(item)
		"TankLeggings":
			for item in inventory:
				if item["context"] == "TankLeggings":
					result.append(item)
		"TankBoots":
			for item in inventory:
				if item["context"] == "TankBoots":
					result.append(item)
		"TankAccessory":
			for item in inventory:
				if item["context"] == "TankAccessory":
					result.append(item)

		# Healer (8 types)
		"HealerWeapon":
			for item in inventory:
				if item["context"] == "HealerWeapon":
					result.append(item)
		"HealerBasicGems":
			for item in inventory:
				if item["context"] == "HealerBasicGems":
					result.append(item)
		"HealerAbilityGems":
			for item in inventory:
				if item["context"] == "HealerAbilityGems":
					result.append(item)
		"HealerHeadpiece":
			for item in inventory:
				if item["context"] == "HealerHeadpiece":
					result.append(item)
		"HealerChestpiece":
			for item in inventory:
				if item["context"] == "HealerChestpiece":
					result.append(item)
		"HealerLeggings":
			for item in inventory:
				if item["context"] == "HealerLeggings":
					result.append(item)
		"HealerBoots":
			for item in inventory:
				if item["context"] == "HealerBoots":
					result.append(item)
		"HealerAccessory":
			for item in inventory:
				if item["context"] == "HealerAccessory":
					result.append(item)

	return result
