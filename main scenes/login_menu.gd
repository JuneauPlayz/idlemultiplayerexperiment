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

var game
var player_id: String

func _ready() -> void:
	main.visible = true
	create_account.visible = false
	choose_name_group.visible = false

func _on_create_account_b_pressed() -> void:
	main.visible = false
	create_account.visible = true

func _on_back_to_login_pressed() -> void:
	main.visible = true
	create_account.visible = false

func _on_create_acc_confirm_pressed() -> void:
	create_acc_confirm.text = "creating account..."
	create_acc_confirm.disabled = true
	
	# Validate input
	if create_password.text.length() < 8:
		show_error(create_acc_confirm, "Password must be at least 8 characters")
		return
	
	var headers = ["Content-Type: application/json"]
	var response = await MongoDBClient.make_request(
		"/players",
		HTTPClient.METHOD_POST,
		{
			"email": create_email.text,
			"password": create_password.text,
			"name": ""
		},
		headers
	)
	
	if !response.success:
		show_error(create_acc_confirm, response.error)
	else:
		show_success(create_acc_confirm, "Account created!")
		player_id = response.player_id
		choose_name()

func _on_login_confirm_pressed() -> void:
	login_confirm.text = "finding account..."
	login_confirm.disabled = true
	
	var headers = ["Content-Type: application/json"]
	var response = await MongoDBClient.make_request(
		"/sessions",
		HTTPClient.METHOD_POST,
		{
			"email": login_email.text,
			"password": login_password.text
		},
		headers
	)
	
	if !response.success:
		show_error(login_confirm, "Invalid email or password")
	else:
		player_id = response.player_id
		
		# Get player data
		var player_data = await MongoDBClient.make_request(
			"/players/" + player_id,
			HTTPClient.METHOD_GET,
			{},
			headers
		)
		
		if player_data.success:
			if player_data.name == "":
				choose_name()
			else:
				game.account_name = player_data.name
				game.new_scene(game.MAIN_MENU, null)

func choose_name():
	main.visible = false
	create_account.visible = false
	choose_name_group.visible = true

func _on_name_confirm_pressed() -> void:
	if name_entered.text.length() < 3:
		show_error(name_entered, "Name must be at least 3 characters")
		return
	
	var headers = ["Content-Type: application/json"]
	var response = await MongoDBClient.make_request(
		"/players/" + player_id + "/name",
		headers,
		HTTPClient.METHOD_PUT,
		{ "name": name_entered.text },
	)
	
	if !response.success:
		show_error(name_entered, "Name already taken")
	else:
		game.account_name = name_entered.text
		game.new_scene(game.MAIN_MENU, null)

# Helper functions
func show_error(node: Control, message: String):
	DamageNumbers.display_text(node.global_position + Vector2(0, 100), "none", message, 48)
	node.text = "Try Again"
	node.disabled = false

func show_success(node: Control, message: String):
	DamageNumbers.display_text(node.global_position + Vector2(0, 100), "none", message, 48)
	node.text = "Success!"
