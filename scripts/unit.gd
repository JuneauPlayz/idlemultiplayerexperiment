extends Node2D
class_name Unit


var max_mana : int
var mana : int
@export var max_health : int
var health : int

var basic_time_left
var basic_starting_time

@export var basic_atk : Basic_ATK
@export var ability : Ability

@onready var hp_bar: Control = $HPBar
var combat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mana = 0
	max_mana = ability.mana_cost
	health = max_health
	basic_time_left = basic_atk.cast_timer
	basic_starting_time = basic_atk.cast_timer
	update_hp_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func decrease_basic_atk_time(amt):
	basic_time_left = basic_time_left - amt
	if basic_time_left <= 0:
		basic_time_left = basic_starting_time
		use_basic_atk()
	hp_bar.set_auto_time(basic_time_left)

func use_basic_atk():
	combat = get_tree().get_first_node_in_group("combat")
	if self != combat.enemy:
		if basic_atk.damaging == true:
			combat.enemy.take_damage(basic_atk.value)
	else:
		for ally in combat.allies:
			ally.take_damage(basic_atk.value)
	gain_mana(basic_atk.mana_gen)

func use_ability():
	combat = get_tree().get_first_node_in_group("combat")
	if self != combat.enemy:
		if ability.damaging == true:
			combat.enemy.take_damage(ability.value)
	else:
		for ally in combat.allies:
			ally.take_damage(ability.value)
			
func take_damage(amt):
	health -= amt
	hp_bar.set_hp(health)

func gain_mana(amt):
	mana += amt
	if mana >= max_mana:
		use_ability()
		mana -= max_mana
	hp_bar.set_mana(mana)
	
func update_hp_bar():
	hp_bar.set_max_hp(max_health)
	hp_bar.set_hp(health)
	hp_bar.set_max_mana(max_mana)
	hp_bar.set_mana(mana)
	hp_bar.set_starting_auto_time(basic_starting_time)
	hp_bar.set_auto_time(basic_time_left)
