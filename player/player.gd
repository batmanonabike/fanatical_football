extends CharacterBody2D


const SPEED: float = 300.0

var direction_x: float
var direction_y: float

@onready var dribble_and_sprite = $Node2D
func _ready():
	add_collision_exception_with(Global.ball)

func _physics_process(delta):
	direction_x = Input.get_axis("left", "right")
	direction_y = Input.get_axis("forward", "backward")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = 0
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = 0
		#velocity.y = move_toward(velocity.y, 0, SPEED)
	velocity = velocity.normalized() * SPEED
	if velocity.x and not velocity.y:
		dribble_and_sprite.rotation = deg_to_rad(270) if velocity.x > 0 else deg_to_rad(90)
	elif velocity.y and not velocity.x:
		dribble_and_sprite.rotation = deg_to_rad(0) if velocity.y > 0 else deg_to_rad(180)
	elif velocity.y and velocity.x:
		if velocity.y > 0:
			dribble_and_sprite.rotation = deg_to_rad(45) if velocity.x < 0 else deg_to_rad(-45)
		else:
			dribble_and_sprite.rotation = deg_to_rad(90 + 35) if velocity.x < 0 else deg_to_rad(245)
			
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
