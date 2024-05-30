extends Node2D

@onready var cooldown_timer: Timer = $CooldownTimer

@export var projectile_scene: PackedScene

@export var base_cooldown_time := 5.0

func _ready() -> void:
	cooldown_timer.wait_time = base_cooldown_time

func _process(delta: float) -> void:
	pass

func _on_cooldown_timer_timeout() -> void:
	var target = find_target()
	if target:
		look_at(target.position)
		spawn_projectile()
	cooldown_timer.wait_time = base_cooldown_time - (Globals.player_cooldown_mult * base_cooldown_time)
	cooldown_timer.start()

func find_target() -> Node2D:
	var closest_distance := 1000.0
	var closest_enemy: Node2D = null
	var all_enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in all_enemies:
		var distance_to_current_enemy = global_position.distance_to(enemy.position)
		
		if closest_enemy == null or distance_to_current_enemy < closest_distance:
			closest_enemy = enemy
			closest_distance = distance_to_current_enemy
	
	return closest_enemy

func spawn_projectile() -> void:
	var new_projectile = projectile_scene.instantiate()
	add_child(new_projectile)
	new_projectile.global_position = global_position
