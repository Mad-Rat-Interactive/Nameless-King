extends Enemy
class_name Necromancer

@export var speed = 40
@export var health = 16
@onready var healthbar: ProgressBar = $Healthbar

var player_chase = false
var player: Player = null

var can_attack_player = false
var can_damage_player = false
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

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body

func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		can_attack_player = true

func _on_attack_hitbox_body_exited(body: Node2D) -> void:
	if body is Player:
		can_attack_player = false

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Player:
		can_damage_player = true

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
		can_damage_player = false
