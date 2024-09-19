extends State

@onready var enemy := $"../.."
@export var move_speed := 0.0

func Enter():
	enemy.velocity = Vector2.ZERO
	SoundManager.play_sound("Necromancer_Death")
	$"../../AnimatedSprite2D".play("death")

func Physics_Update(_delta: float):
	enemy.velocity = Vector2.ZERO
	if not $"../../AnimatedSprite2D".is_playing():
		owner.queue_free()

