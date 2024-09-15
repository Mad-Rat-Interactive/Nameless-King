extends State

@onready var enemy := $"../.."
@export var move_speed := 60.0

func Enter():
	$"../../AnimatedSprite2D".play("chase")

func Physics_Update(_delta: float):
	if not enemy.player:
		enemy.player = null
		Transitioned.emit(self, "EnemyIdle")

	if enemy.can_attack:
		Transitioned.emit(self, "EnemyAttackCharge")

	var direction : Vector2 = enemy.player.global_position - enemy.global_position

	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

	if direction.length() > 200:
		enemy.player = null
		Transitioned.emit(self, "EnemyIdle")
