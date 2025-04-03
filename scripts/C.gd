extends Node

var starting_items = [
	# Starter gear
	["Starter Hat", 1],
	["Starter Chestpiece", 1],
	["Starter Leggings", 1],
	["Starter Boots", 1],
	
	# Tank
	["Block", 1],
	["Shields Up", 1],
	["Wooden Shield", 1],
	
	# Physical DPS
	["Basic Strike", 1],
	["Slash", 1],
	["Wooden Sword", 1],
	
	# Magic DPS
	["Basic Spell", 1],
	["Fireball", 1],
	["Wooden Wand", 1],
	
	# Healer
	["Basic Heal", 1],
	["Healing Aura", 1],
	["Wooden Staff", 1]
]

# Add all items in a loop

# Character Types
var TANK = "Tank"
var PHYS = "PhysicalDPS"
var MAG = "MagicDPS"
var HEAL = "Healer"

# Equipment Types
var BASIC = "BasicGem"
var ABILITY = "AbilityGem"
var HEAD = "Headpiece"
var CHEST = "Chestpiece"
var LEG = "Leggings"
var BOOTS = "Boots"
var WEAPON = "Weapon"
var ACC = "Accessory"

# Tank Equipment
var TANK_BASIC = "TankBasicGem"
var TANK_ABILITY = "TankAbilityGem"
var TANK_HEAD = "TankHeadpiece"
var TANK_CHEST = "TankChestpiece"
var TANK_LEG = "TankLeggings"
var TANK_BOOTS = "TankBoots"
var TANK_WEAPON = "TankWeapon"
var TANK_ACC = "TankAccessory"

# Physical DPS Equipment
var PHYS_BASIC = "PhysicalDPSBasicGem"
var PHYS_ABILITY = "PhysicalDPSAbilityGem"
var PHYS_HEAD = "PhysicalDPSHeadpiece"
var PHYS_CHEST = "PhysicalDPSChestpiece"
var PHYS_LEG = "PhysicalDPSLeggings"
var PHYS_BOOTS = "PhysicalDPSBoots"
var PHYS_WEAPON = "PhysicalDPSWeapon"
var PHYS_ACC = "PhysicalDPSAccessory"

# Magic DPS Equipment
var MAG_BASIC = "MagicDPSBasicGem"
var MAG_ABILITY = "MagicDPSAbilityGem"
var MAG_HEAD = "MagicDPSHeadpiece"
var MAG_CHEST = "MagicDPSChestpiece"
var MAG_LEG = "MagicDPSLeggings"
var MAG_BOOTS = "MagicDPSBoots"
var MAG_WEAPON = "MagicDPSWeapon"
var MAG_ACC = "MagicDPSAccessory"

# Healer Equipment
var HEAL_BASIC = "HealerBasicGem"
var HEAL_ABILITY = "HealerAbilityGem"
var HEAL_HEAD = "HealerHeadpiece"
var HEAL_CHEST = "HealerChestpiece"
var HEAL_LEG = "HealerLeggings"
var HEAL_BOOTS = "HealerBoots"
var HEAL_WEAPON = "HealerWeapon"
var HEAL_ACC = "HealerAccessory"

var BASICN = 0
var ABILITYN = 1
var HEADN = 2
var CHESTN = 3
var LEGN = 4
var BOOTSN = 5
var WEAPONN = 6
var ACCN = 7

const DUNGEON_1 = preload("res://fights/dungeon1/Dungeon1.tres")
