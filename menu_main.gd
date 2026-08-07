extends Control

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Play button
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://prefabs/environment.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
func _process(delta: float) -> void:
	animated_sprite.play("default")
