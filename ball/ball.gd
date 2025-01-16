extends Area2D

var original_scale: Vector2 = scale

var dribbling: bool = false
var player_dribbling: CharacterBody2D

var bodies_colliding: Array[Node2D]

var shooting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ball = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bodies_colliding = get_overlapping_bodies()
	
	if dribbling:
		global_position = player_dribbling.get_node("Node2D/DribbleLocation").global_position
		if Input.is_action_pressed("shoot"):
			dribbling = false
			print("teehee")
			_shoot(2, player_dribbling.get_node("Node2D").rotation + deg_to_rad(90))
		
	if bodies_colliding.size() == 1 and not shooting:
		dribbling = true
		if bodies_colliding[0]:
			# Update player dribbling if the player is an instance of the Player scene
			player_dribbling = bodies_colliding[0] if is_instance_of(bodies_colliding[0], CharacterBody2D) else  player_dribbling
# minimum y = 1.0
# 1 = stadium
# 10 = camera
func simulate_y_level(y: float):
	scale = original_scale * y


var target_position: Vector2
func _shoot(strength: float, rotation: float):
	shooting = true
	target_position = global_position + (Vector2(strength, 0).rotated(rotation) * 100)
	print(target_position)
	# Start a blocking loop to prevent characters from starting a dribble while the ball is still movin in physics proces
	var i: int = 1
	while global_position != target_position:
		if i <= 10:
			simulate_y_level(i / 2)
		else:
			simulate_y_level(((i * -1) + 22) / 2)
		global_position = global_position.move_toward(target_position, strength * 5)
		# Wait x amount of time (physics frames)
		await get_tree().create_timer(0.032, false).timeout
		i += 1
	simulate_y_level(1)
	shooting = false
	
	
	
	
	
	
	
	
	
	
	
	
