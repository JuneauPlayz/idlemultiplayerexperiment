extends Node2D
@onready var create_account_b: Button = $Main/CreateAccountB
@onready var back_to_login: Button = $CreateAccount/BackToLogin
@onready var main: Node2D = $Main
@onready var create_account: Node2D = $CreateAccount
@onready var create_email: TextEdit = $CreateAccount/DetailsContainer2/VBoxContainer/HBoxContainer/Email
@onready var create_password: TextEdit = $CreateAccount/DetailsContainer2/VBoxContainer/HBoxContainer2/Password
@onready var login_email: TextEdit = $Main/DetailsContainer/VBoxContainer/HBoxContainer/Email
@onready var login_password: TextEdit = $Main/DetailsContainer/VBoxContainer/HBoxContainer2/Password
@onready var login_confirm: Button = $Main/LoginConfirm
@onready var create_acc_confirm: Button = $CreateAccount/CreateAccConfirm
@onready var choose_name_group: Node2D = $ChooseName

@onready var name_entered: TextEdit = $ChooseName/Name



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main.visible = true
	create_account.visible = false
	choose_name_group.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_create_account_b_pressed() -> void:
	main.visible = false
	create_account.visible = true


func _on_back_to_login_pressed() -> void:
	main.visible = true
	create_account.visible = false


func _on_create_acc_confirm_pressed() -> void:
	create_acc_confirm.text = "creating account..."
	create_acc_confirm.disabled = true
	var response = await LL_WhiteLabel.SignUp.new(create_email.text, create_password.text).send()
	if(!response.success) :
		DamageNumbers.display_text(create_acc_confirm.global_position + Vector2(0,100), "none", "Error, Password must be atleast 8 chars", 48)
		pass
	else:
		DamageNumbers.display_text(create_acc_confirm.global_position + Vector2(0,100), "none", "Success!", 48)
		pass
	


func _on_login_confirm_pressed() -> void:
	login_confirm.text = "finding account..."
	login_confirm.disabled = true
	var response = await LL_WhiteLabel.LoginAndStartSession.new(login_email.text, login_password.text).send()
	if(!response.success) :
		DamageNumbers.display_text(login_confirm.global_position + Vector2(0,100), "none", "Couldn't find account", 48)
		pass
	else:
		# Request succeeded, use response as applicable in your game logic
		var response2 = await LL_Players.GetPlayersActiveName.new().send()
		if(!response2.success):
			DamageNumbers.display_text(login_confirm.global_position + Vector2(0,100), "none", "Error", 48)
			choose_name()
			pass
		else:
			var game = get_tree().get_first_node_in_group("game")
			if response2.name != "":
				game.account_name = response2.name
				game.new_scene(game.MAIN_MENU)
			else: # if name not empty
				game.account_name = response2.name
				choose_name()
			
				

func choose_name():
	main.visible = false
	create_account.visible = false
	choose_name_group.visible = true
	
	

func _on_name_confirm_pressed() -> void:
	var response = await LL_Players.SetPlayerName.new(name_entered.text).send()
	if(!response.success) :
		DamageNumbers.display_text(login_confirm.global_position + Vector2(0,100), "none", "Name taken", 48)
		pass
	else:
		var game = get_tree().get_first_node_in_group("game")
		game.account_name = name_entered.text
		game.new_scene(game.MAIN_MENU)
