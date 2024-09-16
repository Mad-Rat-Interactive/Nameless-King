extends Node2D

var pillar1_inZone = false
var pillar2_inZone = false
var pillar3_inZone = false
var pillar4_inZone = false

func _physics_process(_delta):
	activate_pillar()

func activate_pillar():
	if Input.is_action_just_pressed("interact"):
		if !(Global.pillar_1):
			if pillar1_inZone:
				Global.pillar_1 = true
				print("Pillar activated")
		if !(Global.pillar_2):
			if pillar2_inZone:
				Global.pillar_2 = true
				print("Pillar activated")
		if !(Global.pillar_3):
			if pillar3_inZone:
				Global.pillar_3 = true
				print("Pillar activated")
		if !(Global.pillar_4):
			if pillar4_inZone:
				Global.pillar_4 = true
				print("Pillar activated")

func _on_pillar_1_body_entered(body):
	if body.has_method("player"):
		pillar1_inZone = true

func _on_pillar_1_body_exited(body):
	if body.has_method("player"):
		pillar1_inZone = false


func _on_pillar_2_body_entered(body):
	if body.has_method("player"):
		pillar2_inZone = true

func _on_pillar_2_body_exited(body):
	if body.has_method("player"):
		pillar2_inZone = false


func _on_pillar_3_body_entered(body):
	if body.has_method("player"):
		pillar3_inZone = true

func _on_pillar_3_body_exited(body):
	if body.has_method("player"):
		pillar3_inZone = false


func _on_pillar_4_body_entered(body):
	if body.has_method("player"):
		pillar4_inZone = true

func _on_pillar_4_body_exited(body):
	if body.has_method("player"):
		pillar4_inZone = false
