extends Node

var PIPE_GAP_DISTANCE = 200
var screen_size
var pipe_scene = preload("res://Pipes/pipe_cheese.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	$PipeTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		spawn_pipe_pair()



func spawn_pipe_pair():
	var pipe_size
	var pipe_instance
	
	# Spawn top pipe
	pipe_instance = pipe_scene.instantiate()
	pipe_instance.position = \
			Vector2(screen_size.x, 0)
	add_child(pipe_instance)
	
	# Spawn bottom pipe
	pipe_size = pipe_instance.get_node("Sprite2D").texture.get_size() * pipe_instance.scale
	pipe_instance = pipe_scene.instantiate()
	pipe_instance.position = \
			Vector2(screen_size.x, (pipe_size.y + PIPE_GAP_DISTANCE))
	add_child(pipe_instance)



func _on_pipe_timer_timeout() -> void:
	spawn_pipe_pair()
