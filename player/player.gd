extends CharacterBody2D


const SPEED: float = 300.0


func _physics_process(delta):

	var direction_x: float = Input.get_axis("left", "right")
	var direction_y: float = Input.get_axis("forward", "backward")
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
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	print(collision)
