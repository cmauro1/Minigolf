extends Node

var club_ready_to_swing: bool = true

signal ball_stopped


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Ball.stopped.connect(_on_ball_stopped)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func is_club_ready_to_swing():
	return self.club_ready_to_swing
	

func orbit_left():
	if is_club_ready_to_swing():
		$ClubPivot.orbit_left()
		$Ball.rotate_left()
	
	
func orbit_right():
	$ClubPivot.orbit_right()
	$Ball.rotate_right()
	
	
func swing_club():
	self.club_ready_to_swing = false
	$Ball.start_timer()
	$ClubPivot.swing_club()


func justify_position():
	$ClubPivot.set_position($Ball.get_position())
	$Ball.set_transform($ClubPivot.get_transform()) # yay it works!


func get_ball_position():
	return self.ball_position


func _on_ball_stopped():
	self.ball_stopped.emit()

