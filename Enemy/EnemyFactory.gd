extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemyScene = preload("res://Enemy/Enemy.tscn")
var JSONLoader

# Enemy "Factory". It recieves a map with "x" and "y" values
# to add enemies to the scene
func createEnemy(enemyData):
	var z = enemyScene.instance()
	z.set_global_position(Vector2(enemyData["x"], enemyData["y"]))
	return z

# Called when the node enters the scene tree for the first time.
func _ready():
	JSONLoader = get_node("/root/JSONLoader")
	var enemiesDefs = JSONLoader.LoadJSON("config/enemies.json")
	for s in enemiesDefs["enemies"]:
		add_child(createEnemy(s))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
