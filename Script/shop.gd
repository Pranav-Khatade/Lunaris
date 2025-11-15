extends AnimatedSprite2D

@onready var player = $"../player"

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	var count = Global.counter%2
	if body.is_in_group("shop") and count == 0:
		print("teleport to shop")
		Global.counter += 1
		Global.player_position = Vector2(432.0,31.0)
		get_tree().change_scene_to_file("res://scene/shop_inside.tscn")
	elif body.is_in_group("shop") and count !=0:
		print("teleport to moon")
		Global.counter +=1
		get_tree().change_scene_to_file("res://scene/main.tscn")
	else:
		pass
