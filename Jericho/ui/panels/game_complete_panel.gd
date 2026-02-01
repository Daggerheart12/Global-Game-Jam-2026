class_name GameCompletePanel
extends PanelContainer

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://cjb3p7p726yth")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://bpvq5oowjtbgm")
