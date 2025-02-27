extends Node2D

var PIPE_SCENE := preload("res://Pipes/pipe_cheese.tscn")
var game_state := "main_menu"
var score := 0.0
var time_elapsed := 0
var active_pipes := []
@onready var screen_size = get_viewport().size
signal game_started

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		print("DEBUG KEY PRESSED")
	if Input.is_action_just_pressed("jump") and game_state == "main_menu":
		start_game()



func spawn_pipe_pair() -> void:
	var PIPE_GAP_DISTANCE := 170.0
	var offset = randf() * (screen_size.y - PIPE_GAP_DISTANCE)
	
	# Spawn top pipe
	var instance = PIPE_SCENE.instantiate()
	instance.position = \
			Vector2(screen_size.x, offset)
	active_pipes.append(instance)
	add_child(instance)
	
	# Spawn bottom pipe  
	var pipe_size = instance.get_node("Sprite2D").texture.get_size() * instance.scale
	instance = PIPE_SCENE.instantiate()
	instance.position = \
			Vector2(screen_size.x, pipe_size.y + PIPE_GAP_DISTANCE + offset)
	active_pipes.append(instance)
	add_child(instance)



func _on_pipe_timer_timeout() -> void:
	if game_state == "playing":
		spawn_pipe_pair()



func start_game() -> void:
	game_state = "playing"
	game_started.emit()
	$PipeTimer.start()



func _on_score_area_d(area):
	print(score)
	score += 0.5  # Since the pipes spawn in pairs
	$Debugging/Label.text = str(score)



func remove_pipes():
	$PipeTimer.stop()
	for pipe in active_pipes:
		pipe.queue_free()
	active_pipes = []



func _on_player_death():
	game_state = "exploding"
	$PipeTimer.stop()
	print(len(active_pipes))
	for pipe in active_pipes:
		pipe.game_running = false



func reset_game():
	remove_pipes()
	game_state = "main_menu"
