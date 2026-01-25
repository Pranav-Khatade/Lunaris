extends Area2D

@export var ore_type: String = "iron_ore"
@onready var dig_timer: Timer = $Timer

var player: Node = null
var player_inside := false
var input_held := false
var dug_cooldown_time: float = 120.0
var dug_is_cooldown: bool = false

func _ready():
	
	add_to_group("duggables")
	dig_timer.one_shot = true
	dig_timer.wait_time = 5.0
	dig_timer.timeout.connect(_on_digging_complete)


	player = get_tree().get_first_node_in_group("player")
	if player == null:
		push_warning("⚠️ Player not found in _ready(), will retry when needed.")

func _process(_delta):
	if player_inside and not dug_is_cooldown:
		if Input.is_action_pressed("dig"):
			if not input_held:
				print("Started digging")
				dig_timer.start()
				input_held = true
		else:
			if input_held:
				print("Stopped early, resetting timer")
				dig_timer.stop()
				input_held = false
	else:
		dig_timer.stop()
		input_held = false

func _on_digging_complete():
	print("Digging complete after 5 sec!")
	var chosen_ore = get_random_ore()

	# Always double-check player before calling
	if player == null:
		player = get_tree().get_first_node_in_group("player")

	if player:
		player._on_tile_ore_mined(chosen_ore)
		Global.dug_ore_collected += 1
	else:
		push_error("❌ Player still not found! Make sure the player is in group 'player'.")

	input_held = false  

	if Global.dug_ore_collected >= 3:
		start_cooldown()
		print("Cooldown started globally for", dug_cooldown_time, "sec")

func get_random_ore() -> String:
	var ores = [
		{"type": "iron_ore", "chance": 0.6},
		{"type": "aluminium_ore", "chance": 0.3},
		{"type": "titanium_ore", "chance": 0.1}
	]

	var rand_val = randf()
	var accumulator = 0.0
	for ore in ores:
		accumulator += ore["chance"]
		if rand_val < accumulator:
			return ore["type"]
	return "iron_ore"

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):
		player_inside = true
		print("Player entered dig zone")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		print("Player exited dig zone")

func start_cooldown():
	dug_is_cooldown = true
	Global.dug_ore_collected = 0

func end_cooldown():
	dug_is_cooldown = false
	dug_cooldown_time = 120.0   

func reduce_cooldown():
	if dug_cooldown_time > 60.0:   
		dug_cooldown_time -= 5.0
		if dug_cooldown_time < 60.0:
			dug_cooldown_time = 60.0  
		print("Global cooldown time now:", dug_cooldown_time)
	else:
		print("Cooldown already at minimum (60s)")
