extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print_debug("You Win!")
	get_tree().quit()
