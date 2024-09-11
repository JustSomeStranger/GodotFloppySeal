extends Area2D

signal player_died()

var game_running := false
var screen_size: Vector2
var velocity := 0
var JUMP_VELOCITY := 550.0
var TERMINAL_VELOCITY := 1200.0
var GRAVITY_STRENGTH := 35.0
var MAX_TILT := 0.4  # How much the seal can tilt forwards in radians


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	set_to_start_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		_handle_physics(delta)
	if null:
		pass
	
	$DebugLabel.text = "Velocity " + str(velocity) + "\nRotation: " + str(rotation) + "\nScreen dimensions: " + str(screen_size)



func _handle_physics(delta) -> void:
	if Input.is_action_just_pressed("jump"):
		game_running = true
		velocity = -JUMP_VELOCITY
	else:
		velocity += GRAVITY_STRENGTH
	velocity = clamp(velocity, -JUMP_VELOCITY, TERMINAL_VELOCITY)
	
	if not game_running: return
	
	position.y += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	rotation = velocity / TERMINAL_VELOCITY * MAX_TILT * PI



func die(area: Area2D) -> void:
	if not game_running: return
	game_running = false
	$Explosion.play()
	$Seal.hide()
	player_died.emit()
	await $Explosion.animation_finished
	hide()



func set_to_start_position() -> void:
	position = Vector2(200, screen_size.y/2)
	$DebugLabel.show()
	process_mode = Node.PROCESS_MODE_DISABLED



func _on_game_started():
	game_running = true
	process_mode = Node.PROCESS_MODE_ALWAYS
