extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

@onready var sprint_player : AudioStreamPlayer = $"GP2 Engine"
@onready var sprint_visual : Sprite2D = $"GP2 Engine_Visual"

const SPEED = 400.0
const JUMP_VELOCITY = -700.0
const SPRINT_SPEED = 700.0

var respawn = respawn_function()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if velocity.x > 0.0:
			animation.flip_h = false
		else:
			animation.flip_h = true
		
		animation.play("walk")
		if Input.get_action_strength("sprint_button"):
			velocity.x = direction * SPRINT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
		
	

	move_and_slide()
	
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
