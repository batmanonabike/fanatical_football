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
	if bodies_colliding.size() == 1 and not shooting:
		dribbling = true
		player_dribbling = bodies_colliding[0]
	if !dribbling:
		return
	global_position = player_dribbling.get_node("Node2D/DribbleLocation").global_position
	if Input.is_action_pressed("shoot"):
		dribbling = false
		print("teehee")
		_shoot(10, player_dribbling.rotation)
						
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
	global_position.move_toward(target_position, strength * 10)
	shooting = false
	
	
	
	
	
	
	
	
	
	
	
	
