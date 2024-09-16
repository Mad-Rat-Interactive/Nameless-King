extends State

@onready var enemy := $"../.."

var lock:Vector2

func Enter():
	$"../../AnimatedSprite2D".play("idle")
	lock = enemy.global_position


func Physics_Update(_delta: float):
	enemy.global_position = lock

	if enemy.is_taking_damage:
		Transitioned.emit(self, "EnemyTakeDamage")
	if enemy.can_attack_player:
		Transitioned.emit(self, "EnemyAttackCharge")
	if enemy.player:
		Transitioned.emit(self, "EnemyChase")

func Exit():
	pass
