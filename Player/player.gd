extends CharacterBody2D

signal player_died
signal leveled_up

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var base_speed := 300.0

@onready var health_bar: ProgressBar = $HealthBar
@export var max_hitpoints: int = 100
var hitpoints : int:
	set(value):
		hitpoints = value
		health_bar.value = hitpoints
		if hitpoints <= 0:
			emit_signal("player_died")

#@onready var level_up_screen: Control = $LevelUpScreen
@onready var xp_bar: ProgressBar = $XPBar
@export var xp_to_next_level := 5
var current_xp := 0:
	set(value):
		current_xp = value
		xp_bar.value = current_xp
		if current_xp >= xp_to_next_level:
			level_up()

var previous_sprite_rotation: float = 0.0

func _ready() -> void:
	hitpoints = max_hitpoints
	health_bar.value = hitpoints
	xp_bar.value = current_xp
	xp_bar.max_value = xp_to_next_level

func _physics_process(_delta: float) -> void:
	move()

func move() -> void:
	var speed = base_speed + (Globals.player_speed_mult * base_speed)
	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	# direction player sprite should face
	var current_angle: float = velocity.angle()
	if current_angle != previous_sprite_rotation and velocity != Vector2.ZERO:
		sprite_2d.rotation = current_angle
		previous_sprite_rotation = current_angle
	
	sprite_2d.rotation = previous_sprite_rotation
	
	move_and_slide()

func level_up() -> void:
	xp_to_next_level += round(0.1 * xp_to_next_level)
	xp_bar.max_value = xp_to_next_level
	current_xp = 0
	#level_up_screen.open_level_up()
	emit_signal("leveled_up")
