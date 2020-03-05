extends KinematicBody2D

const MOVE_SPEED = 50

onready var raycast = $RayCast2D

onready var collider = $CollisionShape2D

onready var sprite = $AnimatedSprite

var player = null
var redState = false

func _ready():
	add_to_group("enemies")

# Make the Sprite flash to red color based on Timer
func flashRed(var duration):
	$Timer.set_wait_time(duration)
	$Timer.start();
	$AnimatedSprite.set_modulate(Color(1, 0, 0))		

# Checks if the timer is done and changes the color
# back to the original
func checkTimer():
	if $Timer.time_left == 0:
		$AnimatedSprite.set_modulate(Color(1, 1, 1))

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)

	var collision = move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()
	
	checkTimer()
	
	if (collision):
		var colliderObj = collision.collider
		if (colliderObj.is_in_group("enemies")):
			flashRed(0.2)
			var collDir = (position - collision.position) * 0.5
			position += collDir
			colliderObj.position -= collDir
			colliderObj.flashRed(0.2)
			
func kill():
	queue_free()

func set_player(p):
	player = p