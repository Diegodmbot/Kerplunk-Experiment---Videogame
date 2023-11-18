extends Node

var colors = {
	"RED" : Color(Color.RED, 0.1), 
	"BLUE": Color(Color.BLUE, 0.1), 
	"GREEN": Color(Color.GREEN, 0.1)
}

var actual_color = colors.RED
var points = 0 
var level_ended = false

func get_actual_color():
	return actual_color
	
func set_random_actual_color():
	var dict_keys = colors.keys()
	var random_key = dict_keys[randi() % dict_keys.size()]
	actual_color = colors[random_key] 
