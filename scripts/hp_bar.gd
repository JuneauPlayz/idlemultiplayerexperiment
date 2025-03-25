extends Control
@onready var hp_bar: ProgressBar = $HPBar
@onready var hp_label: Label = $HPBar/HPLabel
@onready var mana_bar: ProgressBar = $ManaBar
@onready var mana_label: Label = $ManaBar/ManaLabel
@onready var auto_bar: ProgressBar = $AutoBar
@onready var auto_label: Label = $AutoBar/AutoLabel

var health
var max_health
var mana
var max_mana
var time_left
var starting_time 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_hp(health):
	self.health = health
	hp_bar.value = health
	update_hp_label()

func set_max_hp(health):
	self.max_health = health
	hp_bar.max_value = health
	update_hp_label()

func set_mana(mana):
	self.mana = mana
	mana_bar.value = mana
	update_mana_label()

func set_max_mana(mana):
	self.max_mana = mana
	mana_bar.max_value = mana
	update_mana_label()

func set_auto_time(time):
	self.time_left = time
	auto_bar.value = time
	update_auto_label()
	
func set_starting_auto_time(time):
	self.starting_time = time
	auto_bar.max_value = time

func update_hp_label():
	hp_label.text = str(health) + " / " + str(max_health)

func update_mana_label():
	mana_label.text = str(mana) + " / " + str(max_mana)

func update_auto_label():
	auto_label.text = str(snapped(time_left, 0.1)) + "s"
