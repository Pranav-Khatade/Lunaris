extends Area2D

@onready var rocket = $"../../Rocket"
@onready var rock = $"../../Rocket/rock"
func _ready() -> void:
	rock.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("rocket_build") and rocket_items_collected():
		rocket.play("Full_rocket")
		print("player Entered")
	elif body.is_in_group("rocket_build") and base():
		rocket.play("chute_chamber")
	elif body.is_in_group("rocket_build") and thruster():
		rocket.play("thruster")
	elif body.is_in_group("rocket_build") and body1():
		rocket.play("body")
	else:
		rock.visible = true
		await get_tree().create_timer(5).timeout
		rock.visible = false


func rocket_items_collected():
	if Global.rocket_inventory["base"] != 0 and Global.rocket_inventory["nose"] != 0 and Global.rocket_inventory["thrusters"] != 0 and Global.rocket_inventory["body"] !=0:
		return true
	else:
		return false

func base():
	if Global.rocket_inventory["base"] != 0:
		return true
	else :
		return false

func thruster():
	if Global.rocket_inventory["thrusters"] != 0:
		return true
	else :
		return false

func body1():
	if Global.rocket_inventory["body"] != 0:
		return true
	else :
		return false
