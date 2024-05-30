extends Area2D

@export var speed = 500
@export var base_damage = 15

var target: Node2D

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var damage = base_damage + (Globals.player_damage_mult * base_damage)
		body.hitpoints -= damage
		queue_free()
