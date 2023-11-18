extends CharacterBody2D


@export var speed = 300
var died = false
var can_player_move = true


func move():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	if can_player_move:
		move()
		if velocity == Vector2(0,0):
			$AnimationPlayer.play("Idle")
		else: 
			$AnimationPlayer.play("Run")
	else:
		velocity = Vector2(0,0)
	move_and_slide()

func _ready():
	$AnimationPlayer.play("Idle")

func _process(delta):
	if not died and not Game.level_ended and GlobalWorldEnvironment.environment.adjustment_brightness == 1:
		can_player_move = true
	else:
		can_player_move = false

func _on_death_detection_body_entered(body):
	if body.name == "Enemy":
		died = true
		$AnimationPlayer.play("Death")
		await $AnimationPlayer.animation_finished
		queue_free()
