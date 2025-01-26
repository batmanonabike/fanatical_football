extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# areas parent is always ball due to layer 3 only being used for goalpost and ball

func _on_goal_box_area_entered(area: Area2D):
	if area.get_parent().y >= 1.5:
		return
	
	pass # Replace with function body.
