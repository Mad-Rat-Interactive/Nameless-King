extends State

@onready var enemy := $"../.."

func Enter():
	enemy.velocity = Vector2.ZERO
	$"../../AnimatedSprite2D".play("attack_end")

func Physics_Update(_delta: float):
	enemy.velocity = Vector2.ZERO
	if not $"../../AnimatedSprite2D".is_playing():
		Transitioned.emit(self, "EnemyIdle")
