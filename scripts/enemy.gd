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

func _physics_process(delta):
	take_damage()

	# Enemy movement towards player using move_and_collide
	if player_chase and player:
		var direction = (player.position - position).normalized() # Normalize direction
		var velocity = direction * speed
		move_and_collide(velocity * delta) # Use move_and_collide to move while respecting collisions

# Enemy-related functions
func enemy():
	pass

# Detect if the player enters the enemy's detection area
func _on_detection_area_body_entered(body):
	if body.has_method("player"): # Ensure it's the player
		player = body
		player_chase = true

# Detect if the player exits the detection area
func _on_detection_area_body_exited(_body):
	if _body.has_method("player"): # Ensure it's the player
		player = null
		player_chase = false

# Detect when the player enters the enemy's attack range
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

# Detect when the player exits the enemy's attack range
func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

# Damage handling for the enemy
func take_damage():
	if player_inattack_zone and Global.player_current_attack:
		if can_take_damage:
			health -= 4
			health_changed.emit(health)
			$take_damage_cooldown.start()
			can_take_damage = false

			# If health is depleted, remove the enemy
			if health <= 0:
				self.queue_free()

# Reset damage cooldown after a short period
func _on_take_damage_cooldown_timeout():
	can_take_damage = true
