extends RigidBody2D

var original_scale: Vector2 = scale

var dribbling: bool = false
var player_dribbling: CharacterBody2D

var bodies_colliding: Array[Node2D]
var areas_colliding: Array[Area2D]

var shooting: bool = false
var double_tapping: bool = false
var has_shot: bool = false
const TIME_TILL_UNSHOOT: float = 1
var time_till_unshoot: float = 1
var y: float = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ball = self
	pass # Replace with function body.

func _integrate_forces(state):
	if shooting:	
		state.linear_velocity = Vector2.ZERO	
		state.apply_force(Vector2(200 + Global.shoot_strength * 1000, 0).rotated(player_dribbling.get_node("Node2D").rotation + deg_to_rad(90)))
		Global.shoot_strength = 0

	if double_tapping:
	
		state.apply_force(Vector2(1000, 0).rotated(player_dribbling.get_node("Node2D").rotation + deg_to_rad(90)))
	shooting = false
	double_tapping = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if dribbling and player_dribbling:
		
		global_position = player_dribbling.get_node("Node2D/DribbleLocation").global_position
		# Shoot on release
		if Input.is_action_just_released("shoot"):
			dribbling = false
			shooting = true
			has_shot = true
	areas_colliding = $Area2D.get_overlapping_areas()
	if areas_colliding and player_dribbling:
		# Return if the character body is not the body who initiated a dribble.
		
		if areas_colliding[0].get_parent() != player_dribbling: return
		if Input.is_action_just_pressed("shoot"):
			dribbling = false
			double_tapping = true
	bodies_colliding = $Area2D.get_overlapping_bodies()	
	if bodies_colliding.size() >= 1 and not shooting and y == 1 and not has_shot:		
		
		dribbling = true
		if bodies_colliding[0]:
			# Update player dribbling if the player is an instance of the Player scene
			player_dribbling = bodies_colliding[0] if is_instance_of(bodies_colliding[0], CharacterBody2D) else null
	if has_shot:
		print("kek")
		time_till_unshoot -= delta
		if time_till_unshoot <= 0:
			time_till_unshoot = TIME_TILL_UNSHOOT
			has_shot = false


# minimum y = 1.0



# 1 = stadium
# 10 = camera
func simulate_y_level(y: float):
	scale = original_scale * y



func add_exception(node: Node2D):
	add_collision_exception_with(node)
	
	
	
	
	
	
	
	
	
