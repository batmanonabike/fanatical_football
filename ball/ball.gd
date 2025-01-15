extends Area2D

var original_scale: Vector2 = scale

var dribbling: bool = false
var player_dribbling: CharacterBody2D

var bodies_colliding: Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ball = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bodies_colliding = get_overlapping_bodies()
	if bodies_colliding.size() == 1:
		dribbling = true
		player_dribbling = bodies_colliding[0]
	if dribbling:
		global_position = player_dribbling.get_node("Node2D/DribbleLocation").global_position

# minimum y = 1.0
# 1 = stadium
# 10 = camera
func simulate_y_level(y: float):
	scale = original_scale * y

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
