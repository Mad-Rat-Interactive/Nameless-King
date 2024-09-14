extends CharacterBody2D

@export var speed = 200

# Animation variables
var long_idle = false
@export var idle_twirl_threshold = 4.2

@onready var animation_tree: AnimationTree = $Animation/AnimationTree
@onready var idle_timer: Timer = Timer.new()

# Combat variables
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var attack_ip = false # Player attack in progress

var health = 10
signal health_changed(new_value)
var player_alive = true

# Sprite for hurt effect
@onready var sprite: Sprite2D = $Sprite2D # Assuming the sprite is named 'Sprite2D'
@onready var hurt_timer: Timer = Timer.new()

# Activate the animation tree when the scene is ready
func _ready():
	animation_tree.active = true
	idle_timer.one_shot = true
	idle_timer.wait_time = idle_twirl_threshold
	idle_timer.connect("timeout", Callable(self, "_on_idle_timer_timeout"))
	add_child(idle_timer)
	
	# Hurt timer setup
	hurt_timer.one_shot = true
	hurt_timer.wait_time = 0.2 # Time for the hurt effect (in seconds)
	hurt_timer.connect("timeout", Callable(self, "_on_hurt_timer_timeout"))
	add_child(hurt_timer)

# Movement synchronized with physics steps, independent of framerate
func _physics_process(delta):
	velocity = Vector2.ZERO # Player movement vector.

	# Input checks for movement directions
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1

	# Normalize the velocity and scale it by speed if the player is moving
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Update the position
	position += velocity * delta

	# Update the blend position of the animation based on movement
	update_animation_parameter(velocity)
	
	# Combat
	attack()
	enemy_attack()
	
	if health <= 0:
		player_alive = false # Add Game over/death screen
		health = 0
		print("The nameless king has fallen")

# Called every frame, handles other updates
func _process(_delta):
	pass # Here, but not in use atm

# Update animation based on movement
func update_animation_parameter(movement: Vector2):
	# Set the conditions in the AnimationTree
	if movement == Vector2.ZERO:
		animation_tree["parameters/conditions/Idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
		
		# Start the idle timer only if it is stopped
		if idle_timer.is_stopped() and !long_idle:
			idle_timer.start()
	else:
		animation_tree["parameters/conditions/Idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		long_idle = false
		idle_timer.stop() # Stop the timer when moving
	
	# Set the blend position based on whether in long idle state
	if long_idle:
		animation_tree["parameters/Idle/blend_position"] = Vector2(1, 0)
	else:
		animation_tree["parameters/Idle/blend_position"] = Vector2(-1, 0)
	
	# Attack animation
	if Input.is_action_just_pressed("basic_attack"):
		animation_tree["parameters/conditions/attack"] = true
		# Check if idle, and manually set the blend direction to right when attacking while idle
		if movement == Vector2.ZERO:
			animation_tree["parameters/Attack/blend_position"] = Vector2(1, 0) # Force attack to the right when idle
		else:
			animation_tree["parameters/Attack/blend_position"] = movement.normalized()
	else:
		animation_tree["parameters/conditions/attack"] = false

	# Update the blend position based on the movement velocity
	if movement != Vector2.ZERO:
		animation_tree["parameters/Walk/blend_position"] = movement.normalized()

# Called when the idle timer reaches zero
func _on_idle_timer_timeout():
	long_idle = true

# Hurt effect for when player is hit
func _on_player_hit():
	sprite.modulate = Color(1, 0, 0) # Change sprite color to red
	hurt_timer.start()

# Reset the sprite color after the hurt effect
func _on_hurt_timer_timeout():
	sprite.modulate = Color(1, 1, 1) # Reset to default color

# Combat related functions
func player(): # Need this for entity detection via method
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func attack():
	if Input.is_action_just_pressed("basic_attack"):
		long_idle = false
		Global.player_current_attack = true
		attack_ip = true
		$deal_attack_timer.start()

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health -= 2
		health_changed.emit(health)
		_on_player_hit() # Trigger the hurt effect when attacked
		enemy_attack_cooldown = false
		$take_damage_cooldown.start()

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func _on_deal_attack_timer_timeout(): # When attack ends
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
