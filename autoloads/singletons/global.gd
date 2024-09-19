extends Node

var player_current_attack = false

var pillar_1 = false
var pillar_2 = false
var pillar_3 = false
var pillar_4 = false

var ending_triggered = false

func _physics_process(_delta):
	if not ending_triggered and (pillar_1 or pillar_3) and (pillar_2 or pillar_4):
		ending_triggered = true 
		play_ending_scene()

func play_ending_scene():
	get_tree().change_scene_to_file("res://autoloads/scenes/ending.tscn")
