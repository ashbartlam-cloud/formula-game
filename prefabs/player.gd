extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

@onready var sprint_player : AudioStreamPlayer = $"GP2 Engine"
@onready var sprint_visual : Sprite2D = $"GP2 Engine_Visual"

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
const SPRINT_SPEED = 700.0

var respawn = respawn_function()
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		if Input.get_action_strength("sprint_button"):
			velocity.x = direction * SPRINT_SPEED
		else:
			velocity.x = direction * SPEED
		animation.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
	if not is_on_floor():
		if animation.animation != "jump":
			animation.play("jump")
	elif direction != 0:
		if animation.animation != "walk":
			animation.play("walk")
	else:
		if animation.animation != "idle":
			animation.play("idle")

	
func _process(delta: float) -> void:
	
	# Sprint Function
	if Input.is_action_just_pressed("sprint_button"):
		sprint_player.play()
		sprint_visual.show()
	if Input.is_action_just_released("sprint_button"):
		sprint_player.stop()
		sprint_visual.hide()


func respawn_function():
	position.x = 75.0
	position.y = 70.0
