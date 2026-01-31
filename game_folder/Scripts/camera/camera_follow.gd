extends Camera2D

#@onready var player := get_node("../Player") as CharacterBody2D
@export var player :CharacterBody2D

var deadzone :int= 100
var target_y :int= 0
var lerp_timer :float= 0



 

func camera_follow(delta):
	#Camera above the player
	var move_down :bool= false
	var move :bool= false

	if abs(self.position.y) > abs(player.position.y) + deadzone:
		move_down = true
		move = true
	elif abs(self.position.y) < abs(player.position.y) - deadzone:
		move_down = false
		move = true

	if abs(player.position.y) + deadzone <= abs(self.position.y) and abs(self.position.y) <= abs(player.position.y) + deadzone + 1:
		move = false

	if move and move_down:
		self.position.y = lerp(self.position.y, player.position.y - deadzone, 0.9 * delta)

	elif move and !move_down:
		self.position.y = lerp(self.position.y, player.position.y - deadzone, 0.9 * delta)


	#Camera below player
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_follow(delta)
	
