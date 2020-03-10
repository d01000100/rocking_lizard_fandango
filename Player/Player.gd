extends KinematicBody2D

var MOVE_SPEED = 300
var SCALE = 1.0
var JSONLoader

onready var raycast = $RayCast2D

# Reads the file "data.json" where the cowboy specification
# are defined. For example, the speed in which the cowboy
# moves.
func initFromJSON():
	JSONLoader = get_node("/root/JSONLoader")
	var things = JSONLoader.LoadJSON("config/player.json")
	if (!things): 
		print("Error reading JSON")
		return false
	if (things.has("size")):
		SCALE = things["size"]
	else:
		print("No size found!")
		return false	
	if (things.has("velocity")):
		MOVE_SPEED = things["velocity"]
	else:
		print("No velocity found!")
		return false
	return true

# Switch to Fire Spite while shooting
func ShowFireSpite():
	$Sprite_idle.visible = false
	$Sprite_fire.visible = true
	$FireSpiteTimer.wait_time = 0.2
	$FireSpiteTimer.start()

# To check whether Fire Spite time is up
func CheckFireSpiteTimer():
	if $FireSpiteTimer.is_stopped():
		$Sprite_idle.visible = true
		$Sprite_fire.visible = false
	
func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("enemies", "set_player", self)
	initFromJSON()

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	CheckFireSpiteTimer()
	
	if Input.is_action_just_pressed("shoot"):
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			coll.kill()
		ShowFireSpite()
		

func kill():
	get_tree().reload_current_scene()