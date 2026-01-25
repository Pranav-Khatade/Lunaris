extends Node2D

@export var bullet_scene_path: String = "res://scene/bullet.tscn"
@export var num_bullets: int = 25
@export var orbit_radius: float = 120.0
@export var orbit_speed: float = 1.0
@export var fire_interval: float = 5.0
@export var spawn_delay: float = 20.0

var bullet_scene: PackedScene = null
var angle: float = 0.0
var center: Vector2
var offset_angle: float = 0.0
var active: bool = false

@onready var fire_timer: Timer = $Timer
@onready var spawn_timer: Timer = Timer.new()

func _ready() -> void:
	if ResourceLoader.exists(bullet_scene_path):
		bullet_scene = preload("res://scene/bullet.tscn")
	else:
		print("ERROR: Bullet scene not found at path: ", bullet_scene_path)
		return

	center = position
	angle = randf_range(0.0, TAU)

	visible = false
	add_child(spawn_timer)
	spawn_timer.wait_time = spawn_delay
	spawn_timer.one_shot = true
	spawn_timer.timeout.connect(_on_spawn_timeout)
	spawn_timer.start()

func _on_spawn_timeout() -> void:
	visible = true
	active = true
	if is_instance_valid(fire_timer):
		fire_timer.wait_time = fire_interval
		fire_timer.autostart = true
		fire_timer.timeout.connect(fire_circle)
		fire_timer.start()

func _process(delta: float) -> void:
	if not active:
		return
	angle += orbit_speed * delta
	var x = center.x + orbit_radius * cos(angle)
	var y = center.y + orbit_radius * sin(angle)
	position = Vector2(x, y)

func fire_circle() -> void:
	if bullet_scene == null:
		return

	var spawn_pos: Vector2
	if has_node("Marker2D"):
		spawn_pos = $Marker2D.global_position
	else:
		spawn_pos = global_position

	var angle_step = TAU / num_bullets
	var bullet_container = get_tree().current_scene.find_child("Bullets", true, false)
	
	for i in range(num_bullets):
		var bullet = bullet_scene.instantiate()
		var bullet_angle = offset_angle + i * angle_step
		bullet.global_position = spawn_pos
		bullet.direction = Vector2.RIGHT.rotated(bullet_angle)
		
		if bullet_container:
			bullet_container.add_child(bullet)
		else:
			get_tree().current_scene.add_child(bullet)

	offset_angle += 0.2
