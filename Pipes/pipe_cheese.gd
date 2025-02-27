extends Area2D

var game_running: bool
@export var PIPE_SPEED := 400.0


func _ready():
	game_running = true



func _physics_process(delta):
	if game_running:
		position.x -= PIPE_SPEED * delta



func _on_screen_exit() -> void:
	queue_free()
	$"..".active_pipes.remove_at(0)
