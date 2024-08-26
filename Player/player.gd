extends Area2D

signal player_died(player_position: Vector2)

var game_running := false
var screen_size : Vector2
var velocity := 0
@export var JUMP_VELOCITY := 500.0
@export var TERMINAL_VELOCITY := 1200.0
@export var GRAVITY_STRENGTH := 30.0
@export var MAX_TILT := 0.4  # How much the seal can tilt forwards in radians


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(150, screen_size.y/2)
	$DebugLabel.show()
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	$DebugLabel.text = "Velocity " + str(velocity) + "\nRotation: " + str(rotation) + "\nScreen dimensions: " + str(screen_size)



func die(area: Area2D) -> void:
	if not game_running: return
	game_running = false
	player_died.emit(position)
