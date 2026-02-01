extends Area2D


func _ready():
    monitoring = true

func _on_body_entered(body):
    print("StaticBody is colliding with:", body.name)

func _on_body_exited(body):
    print("No longer colliding with:", body.name)