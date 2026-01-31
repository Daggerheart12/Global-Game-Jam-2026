extends Node2D

@export var blue_tilemap :TileMapLayer
@export var red_tilemap :TileMapLayer
@export var walls :TileMapLayer

var blue = Color((50.0/255.0), (150.0 / 255.0), 1, 1)
var background_blue = Color((50.0/255.0), (150.0 / 255.0), 1, 0.25)

var red = Color(1, (50.0/255.0), (150.0 / 255.0), 1)
var background_red = Color(1, (50.0/255.0), (150.0 / 255.0), 0.25)

func switch_to_blue():
	blue_tilemap.modulate = blue
	walls.modulate = blue
	blue_tilemap.collision_enabled = true

	red_tilemap.modulate = background_red
	red_tilemap.collision_enabled = false


func switch_to_red():
	red_tilemap.modulate = red
	walls.modulate = red
	red_tilemap.collision_enabled = true
	
	blue_tilemap.modulate = background_blue
	blue_tilemap.collision_enabled = false

	




	


func _ready() -> void:
	switch_to_blue()



func _process(delta: float) -> void:
	pass
