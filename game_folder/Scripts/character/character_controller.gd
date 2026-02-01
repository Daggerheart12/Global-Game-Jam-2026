extends CharacterBody2D


const JUMP_VELOCITY :int= -400
const MAX_FALL_SPEED :int= 200
const MAX_JUMP_QUEUE_MSEC :int= 250
const MAX_C_TIME_MSEC :int= 250
const MIN_TIME_SCALE :float= 0.5

var movement_speed :int= 250
var move_right :bool= true
var last_queued_jump :int= 0
var last_object_collision :int= 0
var is_colliding :bool= false
var jump_reloaded :bool= false #Touched the ground after jumping
var can_use_queued_jump :bool= false

@export var tilemap_controller :Node2D
@export var s_collider :ShapeCast2D
@export var player_sprite :Char
@export var switch_sound :AudioStreamPlayer2D
@export var jump_sound :AudioStreamPlayer2D

func queue_jump():
		last_queued_jump = Time.get_ticks_msec()
		

func record_last_object_collision():
	if (is_colliding and !s_collider.is_colliding()):
		last_object_collision = Time.get_ticks_msec()
		is_colliding = false

func record_object_collisions():
	is_colliding = s_collider.is_colliding()


		

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

	"""
	if Input.is_action_just_pressed("Jump") and s_collider.is_colliding():
		velocity.y = JUMP_VELOCITY
	elif (Time.get_ticks_msec() - last_queued_jump) < MAX_JUMP_QUEUE_MSEC and s_collider.is_colliding():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("Jump") and (Time.get_ticks_msec() - last_object_collision) < MAX_C_TIME_MSEC and s_collider.is_colliding() == false:
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("Jump"):
		queue_jump()
"""


	var can_jump := false
	var on_ground := false
	var pressingJump := false
	
	if Input.is_action_just_pressed("Jump"):
		pressingJump = true


	if s_collider.is_colliding():
		jump_reloaded = true
		on_ground = true

	if on_ground and jump_reloaded:
		can_jump = true
	

	if (Time.get_ticks_msec() - last_queued_jump) < MAX_JUMP_QUEUE_MSEC:
		can_use_queued_jump = true
	else:
		can_use_queued_jump = false
	
	'''if (Time.get_ticks_msec() - last_object_collision) < MAX_C_TIME_MSEC and jump_reloaded: #c time
		can_jump = true'''
	

	if can_jump and pressingJump and jump_reloaded or can_use_queued_jump and on_ground:
		velocity.y = JUMP_VELOCITY
		jump_reloaded = false
		can_use_queued_jump = false
		last_queued_jump = 0
		jump_sound.play()
	elif pressingJump:
		queue_jump()



	

func var_jump(delta):
	if is_on_floor() == false:
		if velocity.y < 0 and Input.is_action_pressed("Jump") == false:
			velocity.y += 4000 * delta

var blue_level :bool= true
func switch_tilemaps():
	if Input.is_action_just_pressed("Switch"):
		switch_sound.play()
		blue_level = !blue_level

		if (blue_level):
			tilemap_controller.switch_to_blue()
			self.modulate = Color((50.0/255.0), (150.0 / 255.0), 1, 1)
		else:
			tilemap_controller.switch_to_red()
			self.modulate = Color(1, (50.0/255.0), (150.0 / 255.0), 1)


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
		player_sprite.sprite_2d.flip_h = false
	if move_right:
		velocity.x = movement_speed

	if !move_right:
		velocity.x = -movement_speed
		player_sprite.sprite_2d.flip_h = true
	

	pass
	
var last_time_ms := Time.get_ticks_msec()
	
func _process(delta: float) -> void:		


	var current_time_ms := Time.get_ticks_msec()	
	var unscaled_delta = (current_time_ms - last_time_ms) / 1000.0
	last_time_ms = current_time_ms
	handle_time_scaling(unscaled_delta)	
	switch_tilemaps()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	handle_gravity(delta)
	record_last_object_collision()	
	record_object_collisions()
	handle_air_movement()
	#var_jump(delta)

	move()

	move_and_slide()

	
func _ready() -> void:
	self.modulate = Color((50.0/255.0), (150.0 / 255.0), 1, 1)