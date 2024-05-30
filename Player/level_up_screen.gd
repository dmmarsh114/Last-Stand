extends Control

func open_level_up() -> void:
	visible = true
	get_tree().paused = true

func close_level_up() -> void:
	visible = false
	get_tree().paused = false

func _on_increase_damage_pressed() -> void:
	Globals.player_damage_mult += 0.1
	print("Damage Mult is now " + str(Globals.player_damage_mult))
	close_level_up()

func _on_increase_speed_pressed() -> void:
	Globals.player_speed_mult += 0.1
	print("Speed Mult is now " + str(Globals.player_speed_mult))	
	close_level_up()

func _on_reduce_attack_cooldown_pressed() -> void:
	Globals.player_cooldown_mult += 0.1
	print("Cooldown Mult is now " + str(Globals.player_cooldown_mult))
	close_level_up()

func _on_restore_health_pressed() -> void:
	var player = get_parent()
	player.hitpoints = player.max_hitpoints
	close_level_up()
