extends CharacterBody2D

@export var speed = 200

var long_idle = false
@export var idle_twirl_threshold = 4.2
@onready var animation_tree: AnimationTree = $Animation/AnimationTree
@onready var idle_timer: Timer = Timer.new()

# Activate the animation tree when the scene is ready
func _ready():
	animation_tree.active = true
	idle_timer.one_shot = true
	idle_timer.wait_time = idle_twirl_threshold
	idle_timer.connect("timeout", Callable(self, "_on_idle_timer_timeout"))
	add_child(idle_timer)

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

# Called every frame, handles other updates
func _process(_delta):
	pass

# Update animation parameters based on the player's movement velocity
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
		
	# Update the blend position based on the movement velocity
	if movement != Vector2.ZERO:
		animation_tree["parameters/Walk/blend_position"] = movement.normalized()
	

# Called when the idle timer reaches zero
func _on_idle_timer_timeout():
	long_idle = true
	
