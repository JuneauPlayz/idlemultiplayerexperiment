extends Node2D
@onready var allies_group: Node2D = $Allies
@onready var enemy : Unit = $Enemy
@onready var combat_timer: Timer = $CombatTimer

@onready var tank: Unit = $Allies/Tank
@onready var physical_dps: Unit = $Allies/PhysicalDPS
@onready var magic_dps: Unit = $Allies/MagicDPS
@onready var healer: Unit = $Allies/Healer

var allies = []
var units = []

var game

var combat_end = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = get_tree().get_first_node_in_group("game")


func load_fight(fight, loadouts):
	set_arrays()
	enemy.load_enemy_stats(fight)
	tank.loadout = loadouts[0]
	physical_dps.loadout = loadouts[1]
	magic_dps.loadout = loadouts[2]
	healer.loadout = loadouts[3]
	tank.update_stats()
	physical_dps.update_stats()
	magic_dps.update_stats()
	healer.update_stats()
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
		
