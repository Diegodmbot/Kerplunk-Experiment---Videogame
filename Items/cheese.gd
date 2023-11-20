extends Area2D

	
func _ready():
	var idle_tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_loops()
	idle_tween.tween_property(self, "rotation", 0.3 , 2)
	idle_tween.tween_property(self, "rotation", -0.3, 2)
	
func _process(delta):
	pass
	


func _on_body_entered(body):
	if body.name == "MainCharacter":
		Game.actual_state = Game.game_states.WON
		var picked_tween = get_tree().create_tween()
		picked_tween.tween_property(self, "position", position - Vector2(0,35), 0.3)
		picked_tween.tween_property(self, "modulate:a", 0, 0.2)
		picked_tween.tween_callback(queue_free)
