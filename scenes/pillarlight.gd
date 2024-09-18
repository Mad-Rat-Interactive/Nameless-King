extends TileMap

#Loading child light nodes
@onready var p1 = $Pillar1_light
@onready var p2 = $Pillar2_light
@onready var p3 = $Pillar3_light
@onready var p4 = $Pillar4_light

#Upon input checks if pillar has been activated and turns on light if it has
func _process(_delta):
		if Global.pillar_1:
			p1.show()
		if Global.pillar_2:
			p2.show()
		if Global.pillar_3:
			p3.show()
		if Global.pillar_4:
			p4.show()

