extends Resource
class_name Skill

@export var name : String
@export var value : int
@export_enum("physical", "water", "fire", "earth", "wind", "light", "dark") var element : String
@export var damaging : bool
@export var healing : bool
@export var shielding : bool
