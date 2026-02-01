class_name GameOverPanel
extends PanelContainer

## Scene to instance after pressing Restart
@export var main_level_scene: PackedScene
## Scene to instance after pressing Main Menu
@export var main_menu_scene: PackedScene

func _ready():
	pass

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_level_scene)

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)
