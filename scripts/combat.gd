extends Node2D
@onready var allies_group: Node2D = $Allies
@onready var enemy : Unit = $Enemy
@onready var combat_timer: Timer = $CombatTimer

var allies = []
var units = []

var combat_end = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_arrays()
	start_combat()



func start_combat():
	combat_timer.start()


# 0.1s
func _on_combat_timer_timeout() -> void:
	for unit in units:
		unit.decrease_basic_atk_time(combat_timer.wait_time)
	combat_timer.start() 


func set_arrays():
	for child in allies_group.get_children():
		allies.append(child)
		units.append(child)
	units.append(enemy)
		
