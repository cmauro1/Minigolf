extends CharacterBody3D

var acceleration: float = 0.0
var last_acceleration: float = 0.0
const MAX_ACCELERATION: float = 10.0
const MIN_ACCELERATION: float = 0.0

var fall_acceleration: int = 75
var target_velocity: Vector3 = Vector3.ZERO

signal stopped



# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	acceleration = MAX_ACCELERATION
	

func start_timer(speed=-1):
	$Timer.start(speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var direction = Vector3.ZERO
	if acceleration > 0:
		direction.z += 1
		
		if direction != Vector3.ZERO:
			direction = direction.normalized()
		
		
		#Wall bounce must be calculated before the global transform is applied
		#otherwise the direction will flip back towards the wall every other frame
		if is_on_wall():
			calculate_rotation_after_wall_bounce()
			
		# Apply rotation to the direction
		direction = global_transform.basis * direction
		
		# Ground Velocity
		target_velocity.x = direction.x * acceleration
		target_velocity.z = direction.z * acceleration
		
			# Vertical Velocity
		if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
			target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
		velocity = target_velocity
		move_and_slide()
		calculate_loss_of_acceleration()

		if acceleration == 0: # When ball finishes rolling
			stopped.emit()


func oscillate_acceleration():
	if acceleration > last_acceleration or acceleration == MIN_ACCELERATION:
		increase_acceleration(0.25)
	if acceleration < last_acceleration or acceleration == MAX_ACCELERATION:
		decrease_acceleration(0.25)


func increase_acceleration(delta):
	last_acceleration = acceleration
	acceleration += delta


func decrease_acceleration(delta):
	last_acceleration = acceleration
	acceleration -= delta


func calculate_loss_of_acceleration():
	# Calculates loss of acceleration over time
	# while ball is in motion.  Loss is more rapid
	# at higher speeds and curbs as the ball slows down.
	
	if acceleration >= MAX_ACCELERATION * 0.9:		# 90% or more of max acceleration
		acceleration -= acceleration * 0.1
	elif acceleration >= MAX_ACCELERATION * 0.25:	# 25% to 89% of max acceleration
		acceleration -= acceleration * 0.08
	elif acceleration >= MAX_ACCELERATION * 0.02:	# 24% or less of max acceleration
		acceleration -= acceleration * 0.05
	else:											# Set acceleration to 0 when it gets too low
		acceleration = MIN_ACCELERATION
		
		
func calculate_rotation_after_wall_bounce():
	var wall_normal: Vector3 = self.get_wall_normal()
	var position_delta: Vector3 = self.get_position_delta()

	if wall_normal.x < 0 and position_delta.z < 0:
		self.rotate_object_local(Vector3(0,1,0), 1.57)
	elif wall_normal.x < 0 or position_delta.z < 0:
		self.rotate_object_local(Vector3(0,-1,0), 1.57)
	elif wall_normal.x > 0 or position_delta.z > 0:
		self.rotate_object_local(Vector3(0,1,0), 1.57)
		

func rotate_right():
	rotate_y(PI/32) #magic 32, just picked a random number while I fine tune this


func rotate_left():
	rotate_y(-PI/32) #magic 32, just picked a random number while I fine tune this


#func set_rotation(new_rotation):
	
