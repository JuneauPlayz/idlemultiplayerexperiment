extends Node

# Signals
signal inventory_updated(items: Array)
signal inventory_loaded(items: Array)  # Array of item dictionaries
signal inventory_error(message: String)

## Add item to player's inventory
func add_item(player_id: String, item_name: String, quantity: int = 1) -> void:
	var response = await MongoDBClient.make_request(
		"/players/%s/inventory" % player_id,
		HTTPClient.METHOD_POST,
		{
			"itemId": 0,
			"name": item_name,
			"quantity": quantity
		}
	)
	
	_handle_response(response)

## Get player's inventory
func fetch_inventory(player_id: String) -> Array:
	var game = get_tree().get_first_node_in_group("game")
	var response = await MongoDBClient.make_request(
		"/players/%s/inventory" % player_id,
		HTTPClient.METHOD_GET
	)
	
	if response.get("success", false):
		var inventory_items = []
		
		# Transform MongoDB items to dictionary format
		for item in response.get("inventory", []):
			inventory_items.append({
				"res": game.items[item.get("name", "Unknown")],
				"quantity": item.get("quantity", 1),
			})
		
		emit_signal("inventory_loaded", inventory_items)
		return inventory_items
	else:
		var error_msg = response.get("error", "Failed to fetch inventory")
		emit_signal("inventory_error", error_msg)
		push_error("Inventory error: ", error_msg)
		return []

## Helper function to get item icon path
func _get_item_icon(item_id: String) -> String:
	# Implement your own icon mapping logic
	return "res://assets/icons/items/%s.png" % item_id

## Update item quantity
func update_item(player_id: String, item_id: String, new_quantity: int) -> void:
	var response = await MongoDBClient.make_request(
		"/players/%s/inventory/%s" % [player_id, item_id],
		HTTPClient.METHOD_PATCH,
		{ "quantity": new_quantity }
	)
	_handle_response(response)

## Handle all responses
func _handle_response(response: Dictionary) -> void:
	if response.get("success", false):
		emit_signal("inventory_updated", response.get("inventory", []))
	else:
		var error_msg = response.get("error", "Unknown error occurred")
		emit_signal("inventory_error", error_msg)
		push_error("Inventory error: ", error_msg)
		if response.has("raw"):
			print("Raw response: ", response.raw)
