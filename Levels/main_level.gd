extends Node2D

@onready var victory_screen: Control = $GameScreens/VictoryScreen
@onready var game_over_screen: Control = $GameScreens/GameOverScreen
@onready var level_up_screen: Control = $GameScreens/LevelUpScreen
@onready var time_left_label: Label = $GameScreens/HUD/TimeLeftLabel
@onready var game_timer: Timer = $GameTimer

@export var enemy_spawn_time_curve: Curve
@export var enemy_move_speed_curve: Curve

func _ready() -> void:
	Globals.player_speed_mult = 0
	Globals.player_damage_mult = 0
	Globals.player_cooldown_mult = 0

func _process(_delta: float) -> void:
	time_left_label.text = "Time Left: " + _format_seconds(game_timer.time_left, false)

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

func game_progress_ratio() -> float:
	return 1.0 - (game_timer.time_left / game_timer.wait_time)

func get_enemy_spawn_time() -> float:
	return enemy_spawn_time_curve.sample(game_progress_ratio())

func get_enemy_speed() -> float:
	return enemy_move_speed_curve.sample(game_progress_ratio())
