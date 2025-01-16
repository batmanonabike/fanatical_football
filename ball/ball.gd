extends RigidBody2D

var original_scale: Vector2 = scale

var dribbling: bool = false
var player_dribbling: CharacterBody2D

var bodies_colliding: Array[Node2D]
var areas_colliding: Array[Area2D]

var shooting: bool = false
var high_shot: bool = false
var double_tapping: bool = false
var has_shot: bool = false
const TIME_TILL_UNSHOOT: float = 1
var time_till_unshoot: float = 1

@export_category("Visuals")
@export var y_increase_per_iteration: float = 0.05
@export var delay_per_iteration: float = 0.016
var y: float = 1

var exit_thread := false
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ball = self
	pass # Replace with function body.

func _integrate_forces(state):
	if shooting:	
		state.linear_velocity = Vector2.ZERO	
		
	
		if high_shot:
			state.apply_force(Vector2(200 + Global.shoot_strength * 1200, 0).rotated(player_dribbling.get_node("Node2D").rotation + deg_to_rad(90)))
			_ascend_descend(1)
		else:
			state.apply_force(Vector2(200 + Global.shoot_strength * 1200, 0).rotated(player_dribbling.get_node("Node2D").rotation + deg_to_rad(90)))
		Global.shoot_strength = 0
	if double_tapping and has_shot and is_equal_approx(y, 1):	
		state.apply_force(Vector2(2000, 0).rotated(player_dribbling.get_node("Node2D").rotation + deg_to_rad(90)))
	shooting = false
	double_tapping = false
	# Increase friction if on ground
	if is_equal_approx(y, 1):
		state.linear_velocity = (state.linear_velocity.length() * state.linear_velocity.normalized() * 0.994)
	else:
		state.linear_velocity = (state.linear_velocity.length() * state.linear_velocity.normalized() * 0.997)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#simulate_y_level(1)
	if dribbling and player_dribbling:
		
		global_position = player_dribbling.get_node("Node2D/DribbleLocation").global_position
		# Shoot on release
		if Input.is_action_just_released("shoot"):
			dribbling = false
			shooting = true
			has_shot = true
			high_shot = false
			
		elif Input.is_action_just_released("high_shot"):
			dribbling = false
			shooting = true
			has_shot = true
			high_shot = true
			
		elif Input.is_action_just_pressed("pass"):
			pass # haha.
	areas_colliding = $Area2D.get_overlapping_areas()
	if areas_colliding and player_dribbling and not dribbling:
		# Return if the character body is not the body who initiated a dribble.
		
		if areas_colliding[0].get_parent() != player_dribbling: return
		if Input.is_action_just_pressed("shoot"):
			dribbling = false
			double_tapping = true
			print("tap")
	bodies_colliding = $Area2D.get_overlapping_bodies()	
	if bodies_colliding.size() >= 1 and not shooting and is_equal_approx(y,1):
		
		dribbling = true
		if bodies_colliding[0]:
			# Update player dribbling if the player is an instance of the Player scene
			if not has_shot or has_shot and bodies_colliding[0] != player_dribbling:
				player_dribbling = bodies_colliding[0] if is_instance_of(bodies_colliding[0], CharacterBody2D) else null
	if has_shot:
		time_till_unshoot -= delta
		if time_till_unshoot <= 0:
			time_till_unshoot = TIME_TILL_UNSHOOT
			has_shot = false


# minimum y = 1.0



# 1 = stadium
# 10 = camera
#
func simulate_y_level(ylevel: float):
	scale = original_scale * ylevel
	$Shadow.position = Vector2(0, (ylevel - 1) * 20)
	y = ylevel


func add_exception(node: Node2D):
	add_collision_exception_with(node)
	



func _ascend_descend(length: float = 1):
	$Ball.z_index = 999
	var time_taken: float = 0.0
	while time_taken < length:
		print(time_taken)
		if time_taken < length / 2:
			simulate_y_level(y + y_increase_per_iteration)
		elif time_taken > length / 2:
			simulate_y_level(y - y_increase_per_iteration)
		await get_tree().create_timer(delay_per_iteration, true, true).timeout
		time_taken += delay_per_iteration
	simulate_y_level(1)
	$Ball.z_index = 2
















	
