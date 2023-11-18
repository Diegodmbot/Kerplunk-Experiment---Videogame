extends Node2D

var actual_level: Node

var red_level = preload("res://Maps/red_map.tscn")
var blue_level = preload("res://Maps/blue_map.tscn")
var green_level = preload("res://Maps/green_map.tscn")


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
	Utils.save_game()
	change_light_color()
	load_color_map()
	GlobalWorldEnvironment.environment.adjustment_brightness = 1

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
