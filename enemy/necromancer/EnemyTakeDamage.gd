extends State

@onready var enemy := $"../.."
@export var move_speed := 0.0

func Enter():
	enemy.velocity = Vector2.ZERO
	$"../../AnimatedSprite2D".play("damage")

func Physics_Update(_delta: float):
	enemy.velocity = Vector2.ZERO
	if not $"../../AnimatedSprite2D".is_playing():
		enemy.is_taking_damage = false
		Transitioned.emit(self, "EnemyIdle")

	if enemy.health <= 0:
		Transitioned.emit(self, "EnemyDeath")
