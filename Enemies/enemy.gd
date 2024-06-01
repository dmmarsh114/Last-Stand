extends CharacterBody2D

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var move_speed := 75.0
var player: CharacterBody2D

var is_attacking: bool = false
@export var damage = 10
@export var max_hitpoints: int = 50
var hitpoints : int:
	set(value):
		hitpoints = value
		if hitpoints <= 0:
			var new_xp := xp_scene.instantiate()
			get_parent().add_child(new_xp)
			new_xp.global_position = global_position
			queue_free()

@export var xp_scene: PackedScene

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hitpoints = max_hitpoints

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	if player:
		var player_direction = position.direction_to(player.position)
		velocity = player_direction * move_speed
	
	sprite_2d.rotation = velocity.angle()
	
	move_and_slide()
	
	if is_attacking:
		if attack_cooldown.is_stopped():
			player.hitpoints -= damage
			attack_cooldown.start()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_attacking = true

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_attacking = false
