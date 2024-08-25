extends Area2D

var screen_size
@export var PIPE_SPEED = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= PIPE_SPEED * delta 
	
	var pipe_size = $Sprite2D.texture.get_size() * scale



func _on_screen_exit() -> void:
	queue_free()
