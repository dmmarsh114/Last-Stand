extends Control

@export var main_level: PackedScene

@onready var controls_button: Button = %ControlsButton
@onready var instruction_label: Label = %InstructionLabel

var index: int = 0
var game_instructions := ["WASD to move", "Your gun fires automatically", "Survive 5 minutes to win", "Good Luck!"]
var button_text := ["Gotcha.", "Okay...", "What else?", "Thanks..."]

func _on_controls_button_pressed() -> void:
	if index < game_instructions.size():
		instruction_label.text = game_instructions[wrap(index, 0, game_instructions.size())]
		controls_button.text = button_text[wrap(index, 0, game_instructions.size())]
		instruction_label.label_settings.font_color = Color.WHITE
		index += 1
	else:
		instruction_label.label_settings.font_color = Color.BLACK
		instruction_label.text = "placeholder"
		controls_button.text = "How do I play?"
		index = 0

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_level)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
