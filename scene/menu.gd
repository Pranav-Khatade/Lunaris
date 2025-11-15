extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")



func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/tutorial.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/fly.tscn")
