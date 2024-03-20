extends Marker3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func orbit_right():
	rotate_y(PI/32) #magic 32, just picked a random number while I fine tune this


func orbit_left():
	rotate_y(-PI/32) #magic 32, just picked a random number while I fine tune this


func swing_club():
	$AnimationPlayer.play("swing_club")
	$AnimationPlayer.queue("rest_club")
	
	
func justify_position(ball_position): #, ball_rotation): #takes a Vector3
	self.position = ball_position
	#self.rotation = ball_rotation
	
