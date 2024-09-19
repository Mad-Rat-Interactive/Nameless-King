extends Node2D

func _ready():
	SoundManager.play_sound("Sad")

func _on_scene_entered():
	SoundManager.play_sound("Sad")
