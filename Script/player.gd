extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D
@onready var label = $RichTextLabel
@onready var panel = $Panel2
@onready var reddem = $Reddem
@onready var cash = $Panel2/cash
@onready var no_cash = $Panel2/new
@onready var speed_lab = $Panel2/VBoxContainer/speed/speed_label
@onready var button = $Panel2/Button
@onready var cooltime = $Panel2/VBoxContainer/cooldown/cool_label
@onready var sfx = $hitting
@onready var ore_sfx = $"../ore_sound"
@onready var Reddem = $Redeem
@onready var Player = $"."  
@onready var duggable = $"../TileMap/Duggable"
@onready var alien_C = %Alien_invasion and %Alien_invasion2 and %Alien_invasion3 and %Alien_invasion4
@onready var timr_label = $RichTextLabel2
@onready var odds = $Odds
var was_digging := false

func _ready() -> void:
	add_to_group("player")
	var current_scene = get_tree().current_scene
	panel.visible = false
	no_cash.visible = false
	if current_scene.scene_file_path.ends_with("res://scene/main.tscn"):
		Player.position = Global.player_position

	cash.text = "₹ %d" % Global.cash_amount
	speed_lab.text = "Speed : " + str(int(Global.speed))
	
	await countdown(3)
	odds.visible = false

@warning_ignore("unused_parameter")

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	var is_digging := Input.is_action_pressed("dig") and direction != Vector2.ZERO

	if is_digging:
		velocity = Vector2.ZERO
	else:
		velocity = direction * Global.speed

	move_and_slide()

func _process(_delta: float) -> void:

	var is_digging := Input.is_action_pressed("dig")
	if is_digging and not was_digging:
		sfx.play()
	was_digging = is_digging 
	
	if is_digging:
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("KEY_W"):
			sprite.play("forward_dig")
		elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("KEY_S"):
			sprite.play("backward_dig")
		elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("KEY_A"):
			sprite.play("left_dig")
		elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("KEY_D"):
			sprite.play("right_dig")
		else:
			sprite.play("idle")
	else:
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("KEY_W"):
			sprite.play("forward")
		elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("KEY_S"):
			sprite.play("backward")
		elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("KEY_A"):
			sprite.play("left")
		elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("KEY_D"):
			sprite.play("right")
		else:
			sprite.play("idle")

func _on_tile_ore_mined(ore_type: String):
	Global.add_ore(ore_type, 1)
	label.text = " ORE: %s | Total: %d" % [ore_type, Global.ore_inventory[ore_type]]
	ore_sfx.play()
	print("Collected:", ore_type, "| Total:", Global.ore_inventory[ore_type])



func _on_button_pressed() -> void:
	panel.visible = false

func cooldown():
	if Global.cash_amount >= 200:
		Global.cash_amount -= 200
		for d in get_tree().get_nodes_in_group("duggables"):
			d.reduce_cooldown()
		cash.text = "$ %d" % Global.cash_amount
		if duggable:
			cooltime.text = "Cooldown : " + str(int(duggable.dug_cooldown_time))
		else:
			push_warning("Duggable reference missing.")

	else:
		no_cash.visible = true
		print("Not enough cash to reduce cooldown.")


func upgrade_speed():
	if Global.cash_amount >= 100:
		Global.cash_amount -= 100
		Global.speed += 10
		cash.text = "$ %d" % Global.cash_amount
		print("Speed upgraded to", Global.speed)
		speed_lab.text = "Speed : " + str(int(Global.speed))
	else:
		no_cash.visible = true
		print("Not enough cash to upgrade speed.")

func _on_speed_pressed() -> void:
	upgrade_speed()

func _on_cool_pressed() -> void:
	cooldown()

func _on_redeem_pressed() -> void:
	panel.visible = true
	var added_cash = Global.convert_ores_to_cash()
	cash.text = "$ %d" % Global.cash_amount
	label.text = "Converted ore to $%d" % added_cash
	print("Cash after conversion:", Global.cash_amount)


func _on_purchase_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/rocket_inv.tscn")
	return

func countdown(seconds: int) -> void:
	for i in range(seconds, 0, -1):  
		print(i)
		await get_tree().create_timer(1.0).timeout  
