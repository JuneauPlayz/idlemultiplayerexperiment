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
var player_id: String

var tank_gear = [null, null, null, null, null, null, null, null]
var physdps_gear = [null, null, null, null, null, null, null, null]
var magicdps_gear = [null, null, null, null, null, null, null, null]
var healer_gear = [null, null, null, null, null, null, null, null]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var result = await version_checker.check_version()
	if result.get_or_add("status") == "update":
		new_scene(UPDATE_AVAILABLE, null)
	elif result.get_or_add("status") == "current":
		new_scene(LOGIN_MENU, null)
	
	


func new_scene(scene, extra):
	if current_scene != null:
		current_scene.queue_free()
	if scene == MAIN_MENU:
		await load_inventory()
		print(player_id)
		inventory_manager.add_item(player_id, "54", "burger", 1)
		for item in inventory:
			print(item.get("name"))
			print(item.get("quantity"))
			
	current_scene = scene.instantiate()
	if (extra != null):
		current_scene.update(extra)
	self.add_child(current_scene)

func load_inventory():
	inventory = await inventory_manager.fetch_inventory(player_id)
	
func get_items(type: String) -> Array:
	var result = []
	for item in inventory:
		if item["context"] == type:
			result.append(item)
	return result
	

func update_equipment(char, item):
	pass
