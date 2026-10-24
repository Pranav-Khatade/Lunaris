extends AnimatedSprite2D
@onready var rock_area = $Area2D
@onready var player = $"../player"
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("rocket_flew") and rocket_inventory_full():
		print("flying")
		player.visible = false
		get_tree().change_scene_to_file("res://scene/fly.tscn")


func rocket_inventory_full():
	if Global.rocket_inventory["base"] != 0 and Global.rocket_inventory["nose"] != 0 and Global.rocket_inventory["thrusters"] != 0 and Global.rocket_inventory["body"] !=0:
		return true
	else:
		false
