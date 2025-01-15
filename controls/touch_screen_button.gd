extends TouchScreenButton


# Called when the node enters the scene tree for the first time.
func _ready():
	bitmask = BitMap.new()
	bitmask.create_from_image_alpha(texture_normal.get_image(),0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
