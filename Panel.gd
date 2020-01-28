extends Panel

var JSONLoader

func _ready():
	get_node("Button").connect("pressed", self, "onButtonPressed")
	JSONLoader = get_node("/root/JSONLoader")
	
func onButtonPressed():
	var things = JSONLoader.LoadJSON("data.json")
	if (!things): return false
	var message = ""
	if (things.has("size")):
		message = "Size: " + str(things["size"])
	if (things.has("velocity")):
		message += " Vel: " + str(things["velocity"])
	get_node("Label").text = message