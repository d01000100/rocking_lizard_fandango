extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var has_run_already = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func doPipelinePreparation(pathToExe):
	if(!has_run_already):
		var output = []
		var array = ["c:\\temp\\test.txt"]
		var args = PoolStringArray(array)
		OS.execute('cmd', ['/C', 'cd %TEMP% && cd Assets && python .\\pipeline.py'], true, output)
		print("done converting assets!")
		has_run_already = true;
