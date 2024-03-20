extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	var TRANSPARENT = Color(0,0,0,0)
	#set_color(TRANSPARENT)
	set_anchors_preset(Control.PRESET_FULL_RECT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func kill():
	self.queue_free()
