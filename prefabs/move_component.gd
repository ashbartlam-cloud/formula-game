class_name MoveComponent
extends Node

@export var gravity: float = 3000.0
@export var speed : float = 30.0
@export var left_collision_ray: RayCast2D
@export var right_collision_ray: RayCast2D

@onready var parent: CharacterBody2D = get_parent()

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	
	parent.move_and_slide()
	
func _apply_gravity(delta : float) -> void:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta
