extends Node2D

signal game_started

var PIPE_GAP_DISTANCE := 200.0
var PIPE_SCENE := preload("res://Pipes/pipe_cheese.tscn")
var PLAYER_SCENE = preload("res://Player/player.tscn")
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		print("DEBUG KEY PRESSED")



func spawn_pipe_pair() -> void:
	var offset = randf() * (screen_size.y - PIPE_GAP_DISTANCE)
	
	# Spawn top pipe
	var instance = PIPE_SCENE.instantiate()
	instance.position = \
			Vector2(screen_size.x, offset)
	add_child(instance)
	
	# Spawn bottom pipe
	var pipe_size = instance.get_node("Sprite2D").texture.get_size() * instance.scale
	instance = PIPE_SCENE.instantiate()
	instance.position = \
			Vector2(screen_size.x, pipe_size.y + PIPE_GAP_DISTANCE + offset)
	add_child(instance)



func _on_pipe_timer_timeout() -> void:
	spawn_pipe_pair()



func start_game() -> void:
	game_started.emit()
	$PipeTimer.start()
