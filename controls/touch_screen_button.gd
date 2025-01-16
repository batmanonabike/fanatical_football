extends TouchScreenButton

var shooting: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	bitmask = BitMap.new()
	bitmask.create_from_image_alpha(texture_normal.get_image(),0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if shooting and Global.shoot_strength < 3:
		Global.shoot_strength += 0.1
		print(Global.shoot_strength)
	pass


func _on_shoot_pressed():
	shooting = true


func _on_shoot_released():
	shooting = false
	
