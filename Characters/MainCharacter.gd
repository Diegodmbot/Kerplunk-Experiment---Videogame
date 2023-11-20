extends CharacterBody2D


@export var speed = 150
@onready var animation_tree: AnimationTree = $AnimationTree

var can_player_move = true
var is_moving_backwards = true

func change_animation_parametres():
	if Game.actual_state == Game.game_states.PLAYING: 
		if velocity != Vector2.ZERO:
			animation_tree["parameters/conditions/idle"] = false
			animation_tree["parameters/conditions/is_moving"] = true
		else:
			animation_tree["parameters/conditions/idle"] = true
			animation_tree["parameters/conditions/is_moving"] = false
	if Game.actual_state == Game.game_states.WON:
		animation_tree["parameters/conditions/game_won"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	if Game.actual_state == Game.game_states.LOSE:
		animation_tree["parameters/conditions/game_lose"] = true
		animation_tree["parameters/conditions/is_moving"] = false

func move():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	if input_direction[0] == -1:
		is_moving_backwards = true
	if input_direction[0] == 1:
		is_moving_backwards = false

func _physics_process(delta):
	if can_player_move:
		move()
		if velocity == Vector2.ZERO:
			pass
		else:
			$AnimatedSprite2D.flip_h = is_moving_backwards
	else: 
		velocity = Vector2(0,0)
	move_and_slide()

func _ready():
	animation_tree.active = true

func _process(delta):
	if Game.actual_state == Game.game_states.PLAYING and GlobalWorldEnvironment.environment.adjustment_brightness == 1:
		can_player_move = true
	else:
		can_player_move = false
	change_animation_parametres()

