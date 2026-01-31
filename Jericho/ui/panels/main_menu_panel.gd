class_name MainMenuPanel
extends PanelContainer

## Scene to instance after pressing Start
@export var main_level_scene: PackedScene

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_level_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
