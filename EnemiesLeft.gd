extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
# "Constructor"
func _ready():
	pass # Replace with function body.

# "Observer". Has a global access to the scene and 
# gets information of the whole scene
func countZombies():
	var enemies = get_tree().get_nodes_in_group("zombies")
	return enemies.size()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_text("Enemies Left: " + str(countZombies()))