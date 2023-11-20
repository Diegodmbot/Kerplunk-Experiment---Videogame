extends Area2D

var is_not_pressed = true
func _on_body_entered(body):
	if is_not_pressed:
		if body.name == "MainCharacter":
			$AnimatedSprite2D.play("Pressed")
			$"../Level1/OriginalMap/EndWall".queue_free()
			is_not_pressed = false
