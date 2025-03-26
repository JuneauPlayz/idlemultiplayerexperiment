extends Node

const VERSION_URL = "https://raw.githubusercontent.com/JuneauPlayz/idlemultiplayerexperiment/main/version.txt"
const CURRENT_VERSION = "1.0.1"

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
	
	if _is_version_newer(remote_version, CURRENT_VERSION):
		return {
			"status": "update", 
			"current": CURRENT_VERSION,
			"available": remote_version
		}
	else:
		return {"status": "current"}

func _is_version_newer(remote: String, local: String) -> bool:
	var remote_parts = remote.split(".")
	var local_parts = local.split(".")
	
	for i in 3:  # Major.Minor.Patch
		var r = remote_parts[i].to_int() if i < remote_parts.size() else 0
		var l = local_parts[i].to_int() if i < local_parts.size() else 0
		if r > l: return true
		if r < l: return false
	return false
