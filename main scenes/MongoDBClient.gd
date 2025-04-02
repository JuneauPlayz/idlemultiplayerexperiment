extends Node

const BASE_URL = "http://localhost:3000/api"  # Local Node.js server

static func make_request(
	endpoint: String, 
	method: int, 
	data: Dictionary = {}, 
	custom_headers: Dictionary = {}
) -> Dictionary:
	var http_request = HTTPRequest.new()
	var parent = Engine.get_main_loop().root
	parent.add_child(http_request)
	
	var url = BASE_URL + endpoint
	var headers = PackedStringArray(["Content-Type: application/json"])
	
	# Add custom headers (e.g., Authorization)
	if custom_headers.has("Authorization"):
		headers.append("Authorization: %s" % custom_headers["Authorization"])
	
	var body = JSON.stringify(data) if not data.is_empty() else ""
	
	# Correct 4-argument version for Godot 4:
	var error = http_request.request(url, headers, method, body)
	
	if error != OK:
		http_request.queue_free()
		return { 
			"success": false, 
			"error": "HTTP request failed to start", 
			"code": error 
		}
	
	var result = await http_request.request_completed
	http_request.queue_free()
	
	var response_code = result[1]
	var response_body = result[3]
	
	if response_body.size() == 0:
		return { 
			"success": false, 
			"error": "Empty response", 
			"status": response_code 
		}
	
	var json = JSON.new()
	var parse_error = json.parse(response_body.get_string_from_utf8())
	
	if parse_error != OK:
		return { 
			"success": false, 
			"error": "JSON parse error", 
			"raw": response_body.get_string_from_utf8() 
		}
	
	var response_data = json.get_data()
	response_data["status"] = response_code  # Include HTTP status
	return response_data
