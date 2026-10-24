extends Node

@onready var alien_time: Timer = $Timer
@onready var alien_invasion = %Alien_invasion
var Redeem: Button = null
var player_position: Vector2 = Vector2(36.0, -17.0)

var life_counter: int = 3

const ALIEN_APPEAR_AFTER: int = 280
const ALIEN_DURATION: int = 60
var alien_timer_cooldown: int = 0

var ore_inventory := {
	"iron_ore": 0,
	"aluminium_ore": 0,
	"titanium_ore": 0
}

var rocket_inventory := {
	"base": 0,
	"thrusters": 0,
	"body": 0,
	"nose": 0
}

var cash_amount := 0
var speed := 90
var dug_ore_collected: int = 0
var counter: int = 0

func _ready() -> void:
	if is_instance_valid(alien_invasion):
		alien_invasion.visible = false
	else:
		print("ERROR: Node '%Alien_invasion' not found or is null! Invasion logic may fail.")

	if !is_instance_valid(alien_time):
		print("FATAL ERROR: The '$Timer' node was not found. Alien invasion cannot be scheduled.")
		return 

	alien_time.wait_time = ALIEN_APPEAR_AFTER
	alien_time.one_shot = true
	alien_time.timeout.connect(_on_alien_timer_timeout)
	alien_time.start()
	print("Alien invasion countdown started...")

func _on_alien_timer_timeout() -> void:
	print(" Alien invasion incoming!")
	
	if is_instance_valid(alien_invasion):
		alien_invasion.activate()

	var invasion_timer := Timer.new()
	invasion_timer.wait_time = ALIEN_DURATION
	invasion_timer.one_shot = true
	add_child(invasion_timer)
	invasion_timer.timeout.connect(_on_alien_invasion_end)
	invasion_timer.start()

func _on_alien_invasion_end() -> void:
	print("Alien invasion ended.")
	
	if is_instance_valid(alien_invasion):
		alien_invasion.visible = false

	alien_time.start()

func add_ore(ore_type: String, amount: int = 1) -> void:
	if ore_inventory.has(ore_type):
		ore_inventory[ore_type] += amount

func convert_ores_to_cash() -> int:
	var added_cash = 0
	added_cash += ore_inventory["titanium_ore"] * randi_range(200, 400)
	added_cash += ore_inventory["aluminium_ore"] * randi_range(50, 120)
	added_cash += ore_inventory["iron_ore"] * randi_range(5, 15)

	ore_inventory["titanium_ore"] = 0
	ore_inventory["aluminium_ore"] = 0
	ore_inventory["iron_ore"] = 0

	cash_amount += added_cash
	return added_cash

func add_rocket_component(item: String) -> void:
	if rocket_inventory.has(item):
		rocket_inventory[item] += 1
		print(item, "added to inventory")

func get_alien_timer() -> Timer:
	return alien_time

func restart() -> void:
	var current_scene_path = get_tree().current_scene
	life_counter = 3
	cash_amount = 0
	get_tree().change_scene_to_file("res://scene/main.tscn")
	
