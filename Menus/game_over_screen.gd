extends Control

func open_game_over_screen() -> void:
	visible = true
	get_tree().paused = true

func _on_retry_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
