extends Area2D

var screen_size
@export var PIPE_SPEED = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x -= PIPE_SPEED * delta
