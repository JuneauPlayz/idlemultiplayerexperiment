extends Resource
class_name Skill

@export var sprite : Texture2D
@export_enum("TankBasicGem", "TankAbilityGem", "PhysicalDPSBasicGem", "PhysicalDPSAbilityGem", "MagicDPSBasicGem", "MagicDPSAbilityGem", "HealerBasicGem", "HealerAbilityGem") var type : String
@export var name : String
@export var value : int
@export_enum("physical", "water", "fire", "earth", "wind", "light", "dark") var element : String
@export var damaging : bool
@export var healing : bool
@export var shielding : bool
