extends Node2D

@onready var cooldown_timer: Timer = $CooldownTimer

@export var projectile_scene: PackedScene


func _process(delta: float) -> void:
	var target = find_target()
	if target:
		look_at(target.position)
	else:
		rotation = 0

func _on_cooldown_timer_timeout() -> void:
	spawn_projectile()
	cooldown_timer.start()

func find_target() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest_enemy: Node2D
	for enemy in enemies:
		if closest_enemy:
			if position.distance_to(enemy.position) < position.distance_to(closest_enemy.position):
				closest_enemy = enemy
		else:
			closest_enemy = enemy
	
	if closest_enemy:
		return closest_enemy
	return null

func spawn_projectile() -> void:
	var new_projectile = projectile_scene.instantiate()
	add_child(new_projectile)
	new_projectile.global_position = global_position
