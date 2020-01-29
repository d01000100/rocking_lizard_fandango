extends Node

# Reads "filename", parses it as a JSON and returns
# the parsed values.
# It checks if the root JSON node is an object.
# Returns false on error
static func LoadJSON(filename):
	var dataFile = File.new()
	if (dataFile.open("res://" + filename, File.READ) != OK):
		print("Can't find json file")
		return false
	var dataText = dataFile.get_as_text()
	dataFile.close()
	var parsedJSON = JSON.parse(dataText)
	if parsedJSON.error != OK:
		print("Couldn't parse json file")
		return false
	if typeof(parsedJSON.result) != TYPE_DICTIONARY:
		print("The JSON root object is not a object")
		return false
	return parsedJSON.result
