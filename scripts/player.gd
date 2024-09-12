extends CharacterBody2D

@export var speed = 200

@onready var animation_tree: AnimationTree = $Animation/AnimationTree

# Activate the animation tree when the scene is ready
func _ready():
	animation_tree.active = true

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
func _process(delta):
	pass

# Update animation parameters based on the player's velocity
func update_animation_parameter(velocity: Vector2):
	# Set the conditions in the AnimationTree
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true

	# Update the blend position based on the velocity
	animation_tree["parameters/Walk/blend_position"] = velocity.normalized()
