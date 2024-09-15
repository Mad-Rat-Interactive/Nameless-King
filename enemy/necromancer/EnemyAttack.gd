extends State

@onready var enemy := $"../.."
@export var move_speed := 0.0

var move_direction: Vector2
var lock: Vector2
func Enter():
	enemy.velocity = Vector2.ZERO
	lock = enemy.global_position
	$"../../AnimatedSprite2D".play("attack_warm_up")

func Physics_Update(_delta: float):
	enemy.velocity = Vector2.ZERO
	enemy.global_position = lock
	if enemy.is_taking_damage:
		Transitioned.emit(self, "EnemyTakeDamage")
	if not $"../../AnimatedSprite2D".is_playing():
		Transitioned.emit(self, "EnemyAttackFinish")



