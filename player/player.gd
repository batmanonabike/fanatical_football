extends CharacterBody2D

@export_category("Stats")
@export var SPEED: float = 200.0
@export var DECELERATION: float = 500.0

@export_category("Roles")
@export_enum("Striker", "Midfield", "Defense", "Goalie") var role: int
@export_enum("Left", "Centre", "Right") var side: int

@export_category("Misc")
@export_enum ("Team One", "Team Two") var team: int
@export_enum("Player Character", "Nonplayer Character") var player_type: int

var direction: Vector2
var dribble_and_sprite: Node2D

func _ready():
	# Set to NPC if NPC is on
	if player_type == 1:
		self.script = preload("res://player/npc.gd")
	dribble_and_sprite = $Node2D
	add_collision_exception_with(Global.ball)

func _physics_process(delta):
	if player_type == 1:
		self.script = preload("res://player/npc.gd")
	direction = Input.get_vector("left", "right", "forward", "backward")
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, DECELERATION * delta)
		
	if velocity.x and not velocity.y:
		dribble_and_sprite.rotation = deg_to_rad(270) if velocity.x > 0 else deg_to_rad(90)
	elif velocity.y and not velocity.x:
		dribble_and_sprite.rotation = deg_to_rad(0) if velocity.y > 0 else deg_to_rad(180)
	elif velocity.y and velocity.x:
		if velocity.y > 0:
			dribble_and_sprite.rotation = deg_to_rad(45) if velocity.x < 0 else deg_to_rad(-45)
		else:
			dribble_and_sprite.rotation = deg_to_rad(90 + 35) if velocity.x < 0 else deg_to_rad(245)
			
	# Joystick check for mobile players
	if Global.joystick and Global.joystick.is_pressed:
		dribble_and_sprite.rotation = Global.joystick.output.angle() - deg_to_rad(90)
		velocity = Global.joystick.output * SPEED
	else:
		#Decelerate
		velocity = velocity.move_toward(Vector2(0,0), DECELERATION * delta)
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
