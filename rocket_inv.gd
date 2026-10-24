extends Control

@onready var thruster_panel = $Panel2/thrusters_panel
@onready var thruster_anime = $Panel2/thrusters_panel/thruster_anime
@onready var base_panel = $Panel2/Base
@onready var base_anime = $Panel2/Base/base_anime
@onready var body_panel = $Panel2/Body_panel
@onready var body_anime = $Panel2/Body_panel/body_anime
@onready var nose_panel = $Panel2/Nose_panel
@onready var nose_anime = $Panel2/Nose_panel/Nose_anime
@onready var lab = $Panel2/Label
@onready var lab2 = $Panel2/Label3
var thrusters = "thrusters"
var base = "base"
var nose = "nose"
var body = "body"

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/shop_inside.tscn")
	pass


func _on_thrusters_pressed() -> void:
	thruster_panel.visible = true
	thruster_anime.play("default")
	await get_tree().create_timer(3).timeout
	thruster_anime.play_backwards("default")
	thruster_panel.visible = false


func _on_thrusters_mouse_entered() -> void:
	thruster_panel.visible = true
	thruster_anime.play("default")
	await get_tree().create_timer(3).timeout
	thruster_anime.play_backwards("default")
	thruster_panel.visible = false



func _on_body_pressed() -> void:
	body_panel.visible = true
	body_anime.play("default")
	await get_tree().create_timer(3).timeout
	body_anime.play_backwards("default")
	body_panel.visible = false


func _on_body_mouse_entered() -> void:
	body_panel.visible = true
	body_anime.play("default")
	await get_tree().create_timer(3).timeout
	body_anime.play_backwards("default")
	body_panel.visible = false


func _on_base_2_pressed() -> void:
	base_panel.visible = true
	base_anime.play("default")
	await get_tree().create_timer(3).timeout
	base_anime.play_backwards("default")
	base_panel.visible = false


func _on_base_2_mouse_entered() -> void:
	base_panel.visible = true
	base_anime.play("default")
	await get_tree().create_timer(3).timeout
	base_anime.play_backwards("default")
	base_panel.visible = false


func _on_nose_pressed() -> void:
	nose_panel.visible = true
	nose_anime.play("default")
	await get_tree().create_timer(3).timeout
	nose_anime.play_backwards("default")
	nose_panel.visible = false


func _on_nose_mouse_entered() -> void:
	nose_panel.visible = true
	nose_anime.play("default")
	await get_tree().create_timer(3).timeout
	nose_anime.play_backwards("default")
	nose_panel.visible = false


func _on_thruster_buy_pressed() -> void:
	if Global.rocket_inventory[thrusters] ==0 and Global.cash_amount >= 2500:
		Global.add_rocket_component(thrusters)
	elif Global.cash_amount < 2500:
		lab2.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab2.visible = false
	else:
		lab.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab.visible = false


func _on_base_buy_pressed() -> void:
	if Global.rocket_inventory[base] ==0 and Global.cash_amount >= 1200:
		Global.add_rocket_component(base)
	elif Global.cash_amount <1200:
		lab2.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab2.visible = false
	else:
		lab.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab.visible = false

func _on_body_buy_pressed() -> void:
	if Global.rocket_inventory[body] ==0 and Global.cash_amount >= 3000:
		Global.add_rocket_component(body)
	elif Global.cash_amount <3000:
		lab2.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab2.visible = false
	else:
		lab.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab.visible = false

func _on_nose_buy_pressed() -> void:
	if Global.rocket_inventory[nose] ==0 and Global.cash_amount >= 2000:
		Global.add_rocket_component(nose)
	elif Global.cash_amount <2000:
		lab2.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab2.visible = false
	else:
		lab.visible = true
		print("Item Already Present")
		await get_tree().create_timer(2).timeout
		lab.visible = false
