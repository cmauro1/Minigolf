extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	set_anchors_and_offsets_preset(Control.PRESET_CENTER_BOTTOM)
	set_text('Press any key')



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
