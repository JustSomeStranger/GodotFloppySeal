extends Area2D

var game_running := false
var screen_size: Vector2
var velocity := 0
var JUMP_VELOCITY := 550.0
var TERMINAL_VELOCITY := 1200.0
var GRAVITY_STRENGTH := 35.0
var MAX_FORWARD_TILT := 0.4  # Radians
signal player_died


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	set_to_start_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		_handle_physics(delta)
	
	$DebugLabel.text = "Velocity " + str(velocity) + "\nRotation: " + str(rotation) + "\nScreen dimensions: " + str(screen_size)



func _handle_physics(delta) -> void:
	if Input.is_action_just_pressed("jump"):
		velocity = -JUMP_VELOCITY
	else:
		velocity += GRAVITY_STRENGTH
	velocity = clamp(velocity, -JUMP_VELOCITY, TERMINAL_VELOCITY)
	
	if not game_running: return
	
	position.y += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	rotation = velocity / TERMINAL_VELOCITY * MAX_FORWARD_TILT * PI



func die(area: Area2D) -> void:
	if not game_running: return
	game_running = false
	$Explosion.play()
	$Seal.hide()
	await $Explosion.animation_finished
	player_died.emit()
	hide()



func set_to_start_position() -> void:
	position = Vector2(200, screen_size.y/2)
	$DebugLabel.show()
	process_mode = Node.PROCESS_MODE_DISABLED


# TODO: Rename this function and give it more specific purpose
func game_started():
	game_running = true
	process_mode = Node.PROCESS_MODE_ALWAYS
