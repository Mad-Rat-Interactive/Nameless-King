extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

var health = 16
var player_inattack_zone = false
var can_take_damage = true

signal health_changed(new_value)

func _ready():
	health_changed.emit(health)

func _physics_process(_delta):
	take_damage()
	
	if player_chase:
		position += (player.position - position)/speed
	
		#No animation yet

func enemy():
	pass

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func take_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if can_take_damage:
			health = health - 4
			health_changed.emit(health)
			$take_damage_cooldown.start()
			can_take_damage = false 
			#Add hp system unique to enemy
			
			if health <= 0: #Enemy ded
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

