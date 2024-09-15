extends Node
class_name Necromancer

@export var speed = 40
@export var health = 16

var player_chase = false
var player = null

var player_inattack_zone = false
var can_take_damage = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

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
