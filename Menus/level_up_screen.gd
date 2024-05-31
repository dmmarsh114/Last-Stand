extends Control

@onready var increase_damage: Button = $CenterContainer/PanelContainer/VBoxContainer/IncreaseDamage
@onready var increase_speed: Button = $CenterContainer/PanelContainer/VBoxContainer/IncreaseSpeed
@onready var reduce_attack_cooldown: Button = $CenterContainer/PanelContainer/VBoxContainer/ReduceAttackCooldown
@onready var restore_health: Button = $CenterContainer/PanelContainer/VBoxContainer/RestoreHealth

func open_level_up() -> void:
	visible = true
	get_tree().paused = true
	
	if Globals.player_damage_mult >= 0.9:
		increase_damage.disabled = true
		increase_damage.text = "Damage at max"
		
	if Globals.player_speed_mult >= 0.9:
		increase_speed.disabled = true
		increase_speed.text = "Speed at max"
		
	if Globals.player_cooldown_mult >= 0.7:
		reduce_attack_cooldown.disabled = true
		reduce_attack_cooldown.text = "Attack Speed at max"


func close_level_up() -> void:
	visible = false
	get_tree().paused = false

func _on_increase_damage_pressed() -> void:
	Globals.player_damage_mult += 0.1
	#print("Damage Mult is now " + str(Globals.player_damage_mult))
	close_level_up()

func _on_increase_speed_pressed() -> void:
	Globals.player_speed_mult += 0.1
	#print("Speed Mult is now " + str(Globals.player_speed_mult))
	close_level_up()

func _on_reduce_attack_cooldown_pressed() -> void:
	Globals.player_cooldown_mult += 0.1
	#print("Cooldown Mult is now " + str(Globals.player_cooldown_mult))
	close_level_up()

func _on_restore_health_pressed() -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.hitpoints = player.max_hitpoints
	close_level_up()
