extends State

@onready var enemy := $"../.."
@export var move_speed := 0.0

var lock: Vector2

func Enter():
	enemy.velocity = Vector2.ZERO
	lock = enemy.global_position
	SoundManager.play_sound("Necromancer_hurt")
	SoundManager.play_sound("Hurt")
	$"../../AnimatedSprite2D".play("damage")

func Physics_Update(_delta: float):
	enemy.velocity = Vector2.ZERO
	enemy.global_position = lock
	if not $"../../AnimatedSprite2D".is_playing():
		enemy.is_taking_damage = false
		Transitioned.emit(self, "EnemyIdle")

	if enemy.health <= 0:
		Transitioned.emit(self, "EnemyDeath")
