extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

var cooldown : float = 0.00

func _physics_process(delta):
	if cooldown > -1:
		cooldown -= delta
	if Input.is_action_pressed("lantern") and cooldown <= 0:
		if is_visible():
			hide()
		else:
			show()
		
		cooldown = 1.00
