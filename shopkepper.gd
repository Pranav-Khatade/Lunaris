extends Sprite2D
@onready var purchase = $"../player/purchase"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("shopkepper"):
		purchase.visible = true
		print("player Shopping")
