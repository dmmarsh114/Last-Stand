extends CharacterBody2D

const SPEED = 300.0

@onready var health_bar: ProgressBar = $HealthBar
@export var max_hitpoints: int = 100
var hitpoints := max_hitpoints:
	set(value):
		hitpoints = value
		health_bar.value = hitpoints
		if hitpoints <= 0:
			get_tree().quit()

@onready var xp_bar: ProgressBar = $XPBar
@export var xp_to_next_level := 5
var current_xp := 0:
	set(value):
		current_xp = value
		xp_bar.value = current_xp
		if current_xp >= xp_to_next_level:
			level_up()

func _ready() -> void:
	health_bar.value = hitpoints
	xp_bar.value = current_xp
	xp_bar.max_value = xp_to_next_level

func _physics_process(delta: float) -> void:
	move()

func move() -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func level_up() -> void:
	xp_to_next_level += round(0.5 * xp_to_next_level)
	xp_bar.max_value = xp_to_next_level
	current_xp = 0
	print(xp_to_next_level)
