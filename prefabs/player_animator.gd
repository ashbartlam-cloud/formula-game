extends AnimatedSprite2D

@export var player_controller : PlayerController
@export var animation_player : AnimatedSprite2D
@export var sprite : AnimatedSprite2D

func _process(delta):
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.
