class_name GameCompletePanel
extends PanelContainer

## Scene to instance after pressing Restart
@export var main_level_scene: PackedScene
## Scene to instance after pressing Main Menu
@export var main_menu_scene: PackedScene

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game_folder/scenes/game_scene.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Jericho/ui/panels/main_menu_panel.tscn")
