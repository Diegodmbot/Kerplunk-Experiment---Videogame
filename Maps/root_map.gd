extends Node2D

var actual_level: Node

var red_level = preload("res://Maps/red_map.tscn")
var blue_level = preload("res://Maps/blue_map.tscn")
var green_level = preload("res://Maps/green_map.tscn")

@onready var time = 0

func change_light_color():
	Game.set_random_actual_color()
	$ColorRect.set_color(Game.actual_color)

func load_color_map():
	var actual_color = Game.actual_color
	if actual_color == Color(1, 0, 0, 0.1):
		$Level1.add_child(red_level.instantiate())
	if actual_color == Color(0, 1, 0, 0.1):
		$Level1.add_child(green_level.instantiate())
	if actual_color == Color(0, 0, 1, 0.1):
		$Level1.add_child(blue_level.instantiate())
	actual_level = $Level1.get_child(-1)
	
func _ready():
	Game.change_actual_state(Game.game_states.PLAYING)
	Game.actual_color = Game.game_states.PLAYING
	Utils.save_game()
	change_light_color()
	load_color_map()
	GlobalWorldEnvironment.environment.adjustment_brightness = 1
	self
	if Game.best_time != 1000000:
		$CanvasLayer/Label2.text = "Best Time: " + str(Game.best_time)
	else:
		$CanvasLayer/Label2.text = "" 

func _process(delta):
	time += delta
	$CanvasLayer/Label.text = str(int(time))
	
	if Game.actual_state == Game.game_states.WON:
		Game.set_best_time(time)
		Utils.save_game()
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://main_screen.tscn")
	if Game.actual_state == Game.game_states.LOSE:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://main_screen.tscn")
func _on_light_timer_timeout():
	GlobalWorldEnvironment.environment.adjustment_brightness = 0
	change_light_color()
	$Level1.remove_child(actual_level)
	load_color_map()
	$Darkness_Timer.start()
	
func _on_darkness_timer_timeout():
	GlobalWorldEnvironment.environment.adjustment_brightness = 1
	$Darkness_Timer.stop()
	$Light_Timer.start()

