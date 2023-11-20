extends Node

var colors = {
	"RED" : Color(Color.RED, 0.1), 
	"BLUE": Color(Color.BLUE, 0.1), 
	"GREEN": Color(Color.GREEN, 0.1)
}
var actual_color = colors.RED

enum game_states {DEFAULT, PLAYING, WON, LOSE}
var actual_state = game_states.DEFAULT
var best_time: int = 1000000


func get_actual_color():
	return actual_color
	
func set_random_actual_color():
	var dict_keys = colors.keys()
	var random_key = dict_keys[randi() % dict_keys.size()]
	actual_color = colors[random_key] 

func set_best_time(time: float):
	if time < best_time:
		best_time = time 

func change_actual_state(state: Game.game_states):
	Game.actual_state = state
