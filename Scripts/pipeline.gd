extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

static func doPipelinePreparation(pathToExe):
	var output = []
	var array = ["c:\\temp\\test.txt"]
	var args = PoolStringArray(array)
#	OS.execute("C:\\Windows\\System32\\notepad.exe", args, true)
	OS.execute('', [], true, output)
	print(output)
