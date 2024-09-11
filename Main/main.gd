extends Node2D

var PIPE_SCENE := preload("res://Pipes/pipe_cheese.tscn")
var screen_size
var game_running := false
var score := 0.0
var time_elapsed := 0
var active_pipes := []
signal game_started


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		print("DEBUG KEY PRESSED")
	if Input.is_action_just_pressed("jump") and not game_running:
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
	spawn_pipe_pair()



func start_game() -> void:
	game_running = true
	game_started.emit()
	$PipeTimer.start()



func _on_score_area_d(area):
	print(score)
	score += 0.5  # Since the pipes spawn in pairs
	$Debugging/Label.text = str(score)



func _on_player_player_death():
	$MainMenu.open_menu()
	$PipeTimer.stop()
	for pipe in active_pipes:
		pipe.queue_free()
