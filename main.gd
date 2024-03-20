extends Node

var player_ball_stopped: bool = false
var justify_player_position_button: PackedScene = load("res://justify_player_position_btn.tscn")

signal ready_to_swing

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.ball_stopped.connect(_on_player_ball_stopped)
	
	
func _input(event):
	if self.player_ball_stopped:
		if Input.is_anything_pressed():
			$Player.justify_position()
			$CameraPivot.set_position($Player/Ball.get_global_position())
			$button.kill()
			self.player_ball_stopped = false
			$Player.club_ready_to_swing = true
	elif event.is_action_pressed("swing"):
		if $Player.is_club_ready_to_swing():
			$Player.swing_club()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_left"):
		if $Player.is_club_ready_to_swing():
			$Player.orbit_left()
			$CameraPivot.orbit_left()
	if Input.is_action_pressed("move_right"):
		if $Player.is_club_ready_to_swing():
			$Player.orbit_right()
			$CameraPivot.orbit_right()


func _on_player_ball_stopped():
	self.player_ball_stopped = true
	var scene = load("res://justify_player_position_btn.tscn")
	var button = scene.instantiate()
	button.name = 'button'
	self.add_child(button, true)
