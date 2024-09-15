extends CharacterBody2D
class_name Necromancer

@export var speed = 40
@export var health = 16

var player_chase = false
var player = null

var player_inattack_zone = false
var can_take_damage = true

var can_attack = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func take_damage():
	if !player_inattack_zone or !Global.player_current_attack:
		return

	if can_take_damage:
		health -= 4
		$take_damage_cooldown.start()
		can_take_damage = false

	if health <= 0:
		self.queue_free()

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
