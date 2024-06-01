extends Node2D

@export var enemy_scene: PackedScene
@onready var enemy_spawn_points: Node2D = $"../EnemySpawnPoints"
@onready var spawn_cooldown: Timer = $SpawnCooldown
@onready var main_level: Node2D = $"../.."

func _on_spawn_cooldown_timeout() -> void:
	spawn_enemy()
	spawn_cooldown.wait_time = main_level.get_enemy_spawn_time()

func spawn_enemy() -> void:
	var enemy_container = get_parent()
	var new_enemy = enemy_scene.instantiate()
	enemy_container.add_child(new_enemy)
	var spawn_point: Node2D = enemy_spawn_points.get_children().pick_random()
	new_enemy.global_position = spawn_point.global_position
	new_enemy.move_speed = main_level.get_enemy_speed()
