extends Area2D

var velocity = 0
var screen_size
@export var JUMP_VELOCITY := 600.0
@export var TERMINAL_VELOCITY := 1200.0
@export var GRAVITY_STRENGTH := 35.0
@export var MAX_TILT := 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	var position = Vector2(150, 300)
	$DebugLabel.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity += GRAVITY_STRENGTH
	if Input.is_action_pressed("jump"):
		velocity = -JUMP_VELOCITY

	velocity = clamp(velocity, -JUMP_VELOCITY, TERMINAL_VELOCITY)
	position.y += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	rotation = velocity / TERMINAL_VELOCITY * MAX_TILT * PI
	#rotation = MAX_TILT * PI / 10 * velocity**(1.0/3.0) # Uses quadratic roots, doesn't work with negative numbers :(
	
	$DebugLabel.text = "Velocity " + str(velocity) + "\nRotation: " + str(rotation)


# Hi I'm a cheeky little comment :3









 
