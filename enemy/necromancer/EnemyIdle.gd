extends State

@onready var enemy := $"../.."
@export var move_speed := 30.0

var move_direction: Vector2
var wander_time: float

func randomise_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 2)

func Enter():
	$"../../AnimatedSprite2D".play("idle")
	randomise_wander()

func Update(_delta):
	if wander_time > 0:
		wander_time -= _delta
	else:
		randomise_wander()

func Physics_Update(_delta: float):
	if enemy.is_taking_damage:
		Transitioned.emit(self, "EnemyTakeDamage")
	if enemy.can_attack_player:
		Transitioned.emit(self, "EnemyAttackCharge")
	if enemy:
		enemy.velocity = move_direction * move_speed
	if enemy.player:
		Transitioned.emit(self, "EnemyChase")

func Exit():
	pass
