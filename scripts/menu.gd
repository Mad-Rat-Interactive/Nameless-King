extends Control


func _ready():
	SoundManager.play_sound("Main")

func _on_play_pressed():
	SoundManager.stop_sound("Main")
	get_tree().change_scene_to_file("res://autoloads/scenes/cutscene.tscn")


func _on_quit_pressed():
	get_tree().quit()
