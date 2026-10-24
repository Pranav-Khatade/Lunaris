extends Area2D
@onready var main = $".."
@onready var life_label = $"../player/RichTextLabel2"
var speed = 200.0
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		Global.life_counter -=1
		life_label.text = " Life : %d" %Global.life_counter
		if Global.life_counter == 0:
			Global.restart()
		queue_free()
