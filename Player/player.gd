extends Area2D

var game_running := false
var velocity := 0
var JUMP_VELOCITY := 550.0
var TERMINAL_VELOCITY := 1200.0
var GRAVITY_STRENGTH := 35.0
var MAX_FORWARD_TILT := (PI/3)  # Radians
@onready var screen_size = get_viewport_rect().size
signal player_died
signal reset_game


# Called when the node enters the scene tree for the first time.
func _ready():
	set_to_start_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		_handle_physics(delta)
		
	$DebugLabel.text = "Velocity " + str(velocity) + "\nRotation: " + str(rotation) + "\nScreen dimensions: " + str(screen_size)



func _handle_physics(delta) -> void:
	if Input.is_action_just_pressed("jump"):
		velocity = -JUMP_VELOCITY
		$JumpAudio.play()
	else:
		velocity += GRAVITY_STRENGTH
	velocity = clamp(velocity, -JUMP_VELOCITY, TERMINAL_VELOCITY)
	
	if not game_running: return
	
	position.y += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	rotation = velocity / TERMINAL_VELOCITY * MAX_FORWARD_TILT



func die(area: Area2D) -> void:
	if not game_running: return
	player_died.emit()
	game_running = false
	$ExplosionFrames.play()
	$Seal.hide()
	$ExplosionAudio.play()
	await $ExplosionFrames.animation_finished
	await $ExplosionAudio.finished
	reset_game.emit()
	set_to_start_position()
	$Seal.show()



func set_to_start_position() -> void:
	position = Vector2(200, screen_size.y/2)
	$DebugLabel.show()
	process_mode = Node.PROCESS_MODE_DISABLED
	rotation = 0


# TODO: Rename this function and give it more specific purpose
func game_started():
	game_running = true
	process_mode = Node.PROCESS_MODE_ALWAYS
