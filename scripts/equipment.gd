extends Resource
class_name Equipment

@export var sprite : Texture2D
@export_enum(
	# Basic Equipment
	"Headpiece", "Chestpiece", "Leggings", "Boots", "Weapon", "Accessory",
	
	# Tank Equipment
	"TankHeadpiece", "TankChestpiece", "TankLeggings", "TankBoots", "TankWeapon", "TankAccessory",
	
	# Physical DPS Equipment
	"PhysicalDPSHeadpiece", "PhysicalDPSChestpiece", "PhysicalDPSLeggings", "PhysicalDPSBoots", "PhysicalDPSWeapon", "PhysicalDPSAccessory",
	
	# Magic DPS Equipment
	"MagicDPSHeadpiece", "MagicDPSChestpiece", "MagicDPSLeggings", "MagicDPSBoots", "MagicDPSWeapon", "MagicDPSAccessory",
	
	# Healer Equipment
	"HealerHeadpiece", "HealerChestpiece", "HealerLeggings", "HealerBoots", "HealerWeapon", "HealerAccessory"
) var type: String
@export var name : String
@export var health : int
@export var power : int
