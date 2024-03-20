extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	set_one_shot(true)
	wait_time = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
