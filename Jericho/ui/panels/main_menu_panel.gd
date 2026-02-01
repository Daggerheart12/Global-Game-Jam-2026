class_name MainMenuPanel
extends PanelContainer

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://cjb3p7p726yth")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
