extends "res://player/player.gd"

var dumb_ai: bool = false


func _ready():
	#if player_type == 0:
		#self.script = preload("res://player/player.gd")
	player_type = 1
		
	dribble_and_sprite = $Node2D
	$Camera2D.enabled = false
	$SubViewportContainer.visible = false
	add_collision_exception_with(Global.ball)

func _physics_process(delta):
	#if player_type == 0:
		#self.script = preload("res://player/player.gd")
	if !dumb_ai:
		return
	if Global.ball.dribbling and Global.ball.player_dribbling == self:
		global_position = global_position.move_toward(get_parent().get_node("Marker2D").global_position, 5)
		if global_position == Global.game.get_node("Marker2D").global_position:
			Global.shoot_strength = 3
			Global.ball.dribbling = false
			Global.ball.shooting = true
			Global.ball.has_shot = true
			Global.ball.high_shot = false
			
	else:
		global_position = global_position.move_toward(Global.ball.global_position, 5)
	#var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
