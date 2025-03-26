extends Node

# Configuration

var session_token := ""

# Signals
signal inventory_loaded(items: Array)
signal inventory_error(message: String)

# Nodes
@onready var http_request := HTTPRequest.new()

func _ready():
	add_child(http_request)
	#http_request.request_completed.connect(_on_request_completed)

## Call this after player authentication
func fetch_inventory():
	var url = "https://api.lootlocker.io/game/v1/player/inventory/list"  # Updated endpoint
	var headers = [
		"Content-Type: application/json",
		"x-session-token: %s" % LL.session_token
	]

	
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)
	if error != OK:
		push_error("Failed to start inventory request")
		return []
	
	var result = await http_request.request_completed
	var response = JSON.parse_string(result[3].get_string_from_utf8())
	
	if result[1] != 200:  # Check HTTP status code
		push_error("Inventory error: ", response.get("message", "Unknown error"))
		return []
	
	var inventory_items = []
	for asset in response['inventory']:
		inventory_items.append(asset['asset'])
	return inventory_items

# Helper function to find specific file types
func _find_file_url(item: Dictionary, file_type: String) -> String:
	var files = item.get("asset", {}).get("files", [])
	for file in files:
		if file_type in file.get("url", ""):
			return file["url"]
	return ""
