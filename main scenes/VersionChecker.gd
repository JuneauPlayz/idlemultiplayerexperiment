extends Node

const VERSION_URL = "https://raw.githubusercontent.com/JuneauPlayz/idlemultiplayerexperiment/refs/heads/main/version.txt"
const CURRENT_VERSION = "0.0.1"

func check_version():
	var http = HTTPRequest.new()
	add_child(http)
	
	# Required for GitHub raw content
	var headers = [
		"Accept: text/plain",
		"User-Agent: GodotEngine"  # GitHub requires user-agent
	]
	
	var error = http.request(VERSION_URL, headers)
	if error != OK:
		return {"status": "error", "message": "Request failed"}
	
	var result = await http.request_completed
	http.queue_free()
	
	if result[1] != 200:
		return {"status": "error", "code": result[1]}
	
	var remote_version = result[3].get_string_from_utf8().strip_edges()
	
	if remote_version != CURRENT_VERSION:
		print("tehre is a new version")
		return {
			"status": "update", 
			"current": CURRENT_VERSION,
			"available": remote_version
		}
	else:
		print("you have the current version")
		return {"status": "current"}
