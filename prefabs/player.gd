extends CharacterBody2D

var _throttle: float = 0.0
var _velocity: float = 0.0
var _steer: float = 0.0

@export var max_speed: float = 390.0
@export var friction: float = 200.0
@export var acceleration: float = 190.0
@export var steer_strength: float = 3.5
@export var min_steer_factor: float = 0.5

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	_throttle = Input.get_action_strength("throttle")
	_steer = Input.get_axis("steer_left", "steer_right")

func _physics_process(delta: float) -> void:
	apply_throttle(delta)
	apply_rotation(delta)
	position += transform.x * _velocity * delta

func get_steer_factor() -> float:
	return clampf(
		1.0 - pow(_velocity / max_speed, 2.0),
		min_steer_factor,
		1.0
	) * steer_strength

func apply_throttle(delta: float) -> void:
	if _throttle > 0.0:
		_velocity += acceleration * delta
	else:
		_velocity -= friction * delta
	
	_velocity = clampf(_velocity, 0.0, max_speed)

func apply_rotation(delta: float) -> void:
	rotate(steer_strength * delta * _steer)
