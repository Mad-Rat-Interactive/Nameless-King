extends CharacterBody2D

@export var speed = 200

# Called every frame.
func _process(delta):
	var velocity = Vector2.ZERO # Player movement vector.
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
