extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):

	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("forward", "backward")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
