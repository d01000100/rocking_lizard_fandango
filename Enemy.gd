extends KinematicBody2D

const MOVE_SPEED = 50

onready var raycast = $RayCast2D

var player = null
var redState = false

func _ready():
	add_to_group("enemies")
	$Timer.start();

# Make the Sprite flash to red color based on Timer
func FlashRed(var duration):
	if $Timer.time_left == 0:
		redState = !redState
		$Timer.set_wait_time(duration)
		$Timer.start();
	if redState:
		$AnimatedSprite.set_modulate(Color(1, 0, 0))		
	else:
		$AnimatedSprite.set_modulate(Color(1, 1, 1))		
	

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)

	FlashRed(0.5)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func kill():
	queue_free()

func set_player(p):
	player = p