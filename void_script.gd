extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if "respawn" in body:
			body.respawn_function()
