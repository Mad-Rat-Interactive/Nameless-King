extends Enemy
class_name Necromancer

@export var speed = 40
@export var health = 16
@onready var healthbar: ProgressBar = $Healthbar

var player_chase = false
var player = null

var player_inattack_zone = false
var can_take_damage = true

var can_attack = false
var is_taking_damage = false

signal healthChange

func _ready() -> void:
	healthChange.connect(new_health)
	healthChange.emit(health)
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

# Functions

func new_health(health: int):
	healthbar.value = health

func take_damage(damage):
	if not is_taking_damage:
		is_taking_damage = true
		health -= damage
		healthChange.emit(health)

# Signals

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body

func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		can_attack = true

func _on_attack_hitbox_body_exited(body: Node2D) -> void:
	if body is Player:
		can_attack = false
