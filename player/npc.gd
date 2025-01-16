extends "res://player/player.gd"
@export_category("Roles")
@export_enum("Striker", "Midfield", "Defense", "Goalie") var role: int
@export_enum("Left", "Centre", "Right") var side: int
func _ready():
	$Camera2D.enabled = false
	$SubViewportContainer.visible = false
	add_collision_exception_with(Global.ball)

func _physics_process(delta):
	
	if Global.ball.dribbling and Global.ball.player_dribbling == self:
		global_position = global_position.move_toward(get_parent().get_node("Marker2D").global_position, 5)
		if global_position == get_parent().get_node("Marker2D").global_position:
			Global.shoot_strength = 3
			Global.ball.dribbling = false
			Global.ball.shooting = true
			Global.ball.has_shot = true
			Global.ball.high_shot = false
			
	else:
		global_position = global_position.move_toward(Global.ball.global_position, 5)
	#var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
