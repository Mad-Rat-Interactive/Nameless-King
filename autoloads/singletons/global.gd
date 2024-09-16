extends Node

var player_current_attack = false

#Pillars active
var pillar_1 = false
var pillar_2 = false
var pillar_3 = false
var pillar_4 = false

func _physics_process(delta):
	if pillar_1 and pillar_2 and pillar_3 and pillar_4:
		get_tree().change_scene_to_file("res://autoloads/scenes/cutscene.tscn")
