extends CharacterBody2D

@export var speed = 300

func _process(delta):
	if velocity == Vector2(0,0):
		$AnimationPlayer.play("Idle")
	else: 
		$AnimationPlayer.play("Run")
