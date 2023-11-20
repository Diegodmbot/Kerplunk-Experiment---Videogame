extends Node2D

func _ready():
	Utils.load_game()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Maps/root_map.tscn")


func _on_exit_pressed():
	get_tree().quit()
