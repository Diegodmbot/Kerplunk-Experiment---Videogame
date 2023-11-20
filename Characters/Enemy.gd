extends CharacterBody2D

@export var speed = 100
@export var player: CharacterBody2D

@onready var nav_ag: NavigationAgent2D = $NavigationAgent2D
@onready var anim = $AnimationPlayer
@onready var is_moving_backwards = false
@onready var can_move: bool = false


func _ready():
	update_path()

func _process(delta):
	if velocity == Vector2(0,0):
		$AnimationPlayer.play("Idle")
	else: 
		$AnimationPlayer.play("Run") 
	if GlobalWorldEnvironment.environment.adjustment_brightness == 0:
		can_move = false
	else:
		can_move = true
	if velocity[0] < 0:
		is_moving_backwards = true
	if velocity[0] > 0:
		is_moving_backwards = false

func _physics_process(delta):
	if can_move:
		var dir = to_local(nav_ag.get_next_path_position()).normalized()
		velocity = dir * speed
		$AnimatedSprite2D.flip_h = is_moving_backwards
		move_and_slide()

func update_path():
	nav_ag.set_target_position(player.position)


func _on_update_timeout():
	update_path()

func _on_death_detector_body_entered(body):
	if body.name == "MainCharacter":
		Game.change_actual_state(Game.game_states.LOSE)


func _on_start_moving_timeout():
	can_move = true
	$Update.start()
