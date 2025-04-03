extends Node2D

@onready var version_checker: Node = $VersionChecker
@onready var inventory_manager: Node = $Inventory

var inventory
var loadout

const LOGIN_MENU = preload("res://main scenes/login_menu.tscn")
const MAIN_MENU = preload("res://main scenes/main_menu.tscn")
const UPDATE_AVAILABLE = preload("res://update_available.tscn")
const CHANGE_EQUIPMENT = preload("res://change_equipment.tscn")
const COMBAT = preload("res://main scenes/combat.tscn")
const DUNGEON_CHOICE = preload("res://main scenes/dungeon_choice.tscn")

var current_scene
var account_name = ""
var player_id: String

var items = {}

var tank_gear = [null, null, null, null, null, null, null, null]
var physdps_gear = [null, null, null, null, null, null, null, null]
var magicdps_gear = [null, null, null, null, null, null, null, null]
var healer_gear = [null, null, null, null, null, null, null, null]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var result = await version_checker.check_version()
	items = load_resources()
	if result.get_or_add("status") == "update":
		new_scene(UPDATE_AVAILABLE, null)
	elif result.get_or_add("status") == "current":
		new_scene(LOGIN_MENU, null)
	
	


func new_scene(scene, extra):
	if current_scene != null:
		current_scene.queue_free()
	if scene == MAIN_MENU:
		await load_inventory()
		await load_loadout()
		load_gear(loadout)
		
	current_scene = scene.instantiate()
	if (extra != null):
		current_scene.update(extra)
	self.add_child(current_scene)

func load_combat(fight):
	if current_scene != null:
		current_scene.queue_free()
		
	current_scene = COMBAT.instantiate()
	self.add_child(current_scene)
	current_scene.load_fight(fight, [tank_gear, physdps_gear, magicdps_gear, healer_gear])
	

func load_inventory():
	inventory = await inventory_manager.fetch_inventory(player_id)

func load_loadout():
	loadout = await fetch_loadout(player_id)
func get_items(type: String) -> Array:
	var result = []
	for item in inventory:
		if item["res"].type == type:
			result.append(item)
	return result
	

func update_equipment(char, item):
	# First determine the slot index
	var slot = -1
	
	if item.type in [C.BASIC, C.TANK_BASIC, C.PHYS_BASIC, C.MAG_BASIC, C.HEAL_BASIC]:
		slot = C.BASICN
	elif item.type in [C.ABILITY, C.TANK_ABILITY, C.PHYS_ABILITY, C.MAG_ABILITY, C.HEAL_ABILITY]:
		slot = C.ABILITYN
	elif item.type in [C.HEAD, C.TANK_HEAD, C.PHYS_HEAD, C.MAG_HEAD, C.HEAL_HEAD]:
		slot = C.HEADN
	elif item.type in [C.CHEST, C.TANK_CHEST, C.PHYS_CHEST, C.MAG_CHEST, C.HEAL_CHEST]:
		slot = C.CHESTN
	elif item.type in [C.LEG, C.TANK_LEG, C.PHYS_LEG, C.MAG_LEG, C.HEAL_LEG]:
		slot = C.LEGN
	elif item.type in [C.BOOTS, C.TANK_BOOTS, C.PHYS_BOOTS, C.MAG_BOOTS, C.HEAL_BOOTS]:
		slot = C.BOOTSN
	elif item.type in [C.WEAPON, C.TANK_WEAPON, C.PHYS_WEAPON, C.MAG_WEAPON, C.HEAL_WEAPON]:
		slot = C.WEAPONN
	elif item.type in [C.ACC, C.TANK_ACC, C.PHYS_ACC, C.MAG_ACC, C.HEAL_ACC]:
		slot = C.ACCN
	
	if slot == -1:
		return  # Unknown item type
	
	# Now assign to the appropriate gear array
	match char:
		C.TANK:
			tank_gear[slot] = item
		C.PHYS_DPS:
			physdps_gear[slot] = item
		C.MAG_DPS:
			magicdps_gear[slot] = item
		C.HEALER:
			healer_gear[slot] = item

func load_resources():
	var dir = DirAccess.open("res://resources")
	var result = {}
	var items = []
	items = get_all_files_from_directory("res://resources", "")
	for filename in items:
		var item = load(filename)
		result[item.name] = item
	print(result)
	return result

func get_all_files_from_directory(path: String, file_ext: String = "", files: Array = []) -> Array:
	var resources = ResourceLoader.list_directory(path)  # Changed to list_files_in_directory to skip folders
	for res in resources:
		var full_path = path.path_join(res)
		# If it's a directory, recurse (but ResourceLoader.list_files_in_directory may not return dirs)
		if res.ends_with("/"):
			get_all_files_from_directory(full_path, file_ext, files)
		else:
			# Only add if extension matches (or no filter)
			if file_ext == "" or res.get_extension() == file_ext:
				files.append(full_path)
	return files

func fetch_loadout(player_id: String) -> Array:
	var response = await MongoDBClient.make_request(
		"/players/%s/loadout" % player_id,
		HTTPClient.METHOD_GET
	)
	
	if response == null:
		push_error("Null response from server")
		return [[],[],[],[]]
	
	if not response.get("success", false):
		var error_msg = response.get("error", "Failed to fetch loadout")
		push_error("Loadout error: ", error_msg)
		return [[],[],[],[]]
	
	var loadout_data = response.get("loadout", {})
	
	# Convert to array format and handle null/empty strings
	var loadouts = [
		loadout_data.get("tank", []),
		loadout_data.get("physDps", []),
		loadout_data.get("magDps", []),
		loadout_data.get("healer", [])
	]
	
	# Convert empty strings back to null if needed
	for char_loadout in loadouts:
		for i in char_loadout.size():
			if char_loadout[i] == "":
				char_loadout[i] = null
	
	return loadouts

func load_gear(loadouts):
	for n in loadouts.size():
		var loadout = loadouts[n]
		match n:
			0:
				for i in loadout.size():
					var item = loadout[i]
					if item != null:
						tank_gear[i] = items[item]
			1:
				for i in loadout.size():
					var item = loadout[i]
					if item != null:
						physdps_gear[i] = items[item]
			2:
				for i in loadout.size():
					var item = loadout[i]
					if item != null:
						magicdps_gear[i] = items[item]
			3:
				for i in loadout.size():
					var item = loadout[i]
					if item != null:
						healer_gear[i] = items[item]
			
