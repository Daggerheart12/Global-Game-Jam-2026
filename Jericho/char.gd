class_name Char
extends Node2D

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func play_anim(anim_name: String) -> void:
	animation_player.play(anim_name)


func _ready() -> void:
	play_anim("RUN")
