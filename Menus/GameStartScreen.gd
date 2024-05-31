extends Control

@onready var hud: Control = $"../HUD"

func _ready() -> void:
	get_tree().paused = true

func _on_start_button_pressed() -> void:
	visible = false
	hud.visible = true
	get_tree().paused = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
