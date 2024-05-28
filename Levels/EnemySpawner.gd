extends Node2D

@export var enemy_scene: PackedScene
@onready var enemy_spawn_points: Node2D = $"../EnemySpawnPoints"

func _on_spawn_cooldown_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:	
	var enemy_container = get_parent()
	var new_enemy = enemy_scene.instantiate()
	enemy_container.add_child(new_enemy)
	var spawn_point: Node2D = enemy_spawn_points.get_children().pick_random()
	new_enemy.global_position = spawn_point.global_position
