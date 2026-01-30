extends CharacterBody2D


const SPEED :int= 100
const JUMP_VELOCITY :int= -400
const MAX_FALL_SPEED :int= 200
const MAX_JUMP_QUEUE_MSEC :int= 100
const MAX_C_TIME_MSEC :int= 100
const MIN_TIME_SCALE :float= 0.5

var movement_speed :int= 200
var move_right :bool= true
var last_queued_jump :int= 0
var last_object_collision :int= 0
var on_wall :bool= false
var on_floor :bool= false
@export var hp :float= 10
func queue_jump():
		last_queued_jump = Time.get_ticks_msec()
		pass

func record_last_object_collision():
	if on_floor and is_on_floor() == false:
		on_floor = false
		last_object_collision = Time.get_ticks_msec()

	if on_wall and is_on_wall() == false:
		on_wall = false
		last_object_collision = Time.get_ticks_msec()

func record_object_collisions():
	if is_on_floor():
		on_floor = true
	
	if is_on_wall():
		on_wall = true
		

func ease_in_cubic(x: float) -> float:
	return x * x * x

var time_scale_timer = 1
		
func handle_time_scaling(delta):

	if Input.is_action_pressed("Slow"):
		time_scale_timer = move_toward(time_scale_timer, MIN_TIME_SCALE, delta)
		Engine.time_scale = ease_in_cubic(time_scale_timer)
	else:
		time_scale_timer = move_toward(time_scale_timer, 1, delta)
		Engine.time_scale = ease_in_cubic(time_scale_timer)

func handle_air_movement():
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif (Time.get_ticks_msec() - last_queued_jump) < MAX_JUMP_QUEUE_MSEC and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("Jump") and (Time.get_ticks_msec() - last_object_collision) < MAX_C_TIME_MSEC and is_on_floor() == false:
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("Jump"):
		queue_jump()

	if Input.is_action_pressed("Jump") and is_on_wall():
		velocity.y = JUMP_VELOCITY
	elif (Time.get_ticks_msec() - last_queued_jump) < MAX_JUMP_QUEUE_MSEC and is_on_wall():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("Jump") and (Time.get_ticks_msec() - last_object_collision) < MAX_C_TIME_MSEC and is_on_wall() == false:
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("Jump"):
		queue_jump()



func handle_gravity(delta):
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y = move_toward(velocity.y, velocity.y + MAX_FALL_SPEED, 1000 * delta)
		else:
			velocity.y = move_toward(velocity.y, velocity.y + MAX_FALL_SPEED, 1500 * delta)
		#velocity += get_gravity() * delta


func move():
	if is_on_wall():
		move_right = !move_right

	if move_right:
		velocity.x = movement_speed

	if !move_right:
		velocity.x = -movement_speed
	
	pass
	
var last_time_ms := Time.get_ticks_msec()

func _process(delta: float) -> void:		
	var current_time_ms := Time.get_ticks_msec()	
	var unscaled_delta = (current_time_ms - last_time_ms) / 1000.0
	last_time_ms = current_time_ms
	handle_time_scaling(unscaled_delta)	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	

	handle_gravity(delta)
	record_object_collisions()
	record_last_object_collision()	
	handle_air_movement()
	move()

	move_and_slide()

	
