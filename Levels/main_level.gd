extends Node2D

@onready var victory_screen: Control = $GameScreens/VictoryScreen
@onready var game_over_screen: Control = $GameScreens/GameOverScreen
@onready var level_up_screen: Control = $GameScreens/LevelUpScreen
@onready var time_left_label: Label = $GameScreens/HUD/TimeLeftLabel
@onready var game_timer: Timer = $GameTimer

func _process(delta: float) -> void:
	time_left_label.text = "Time Left: " + _format_seconds(game_timer.time_left, true)

func _on_game_timer_timeout() -> void:
	victory_screen.open_victory_screen()

func _on_player_player_died() -> void:
	game_over_screen.open_game_over_screen()

func _on_player_leveled_up() -> void:
	level_up_screen.open_level_up()

func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)

	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]

	var milliseconds := fmod(time, 1) * 100

	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
