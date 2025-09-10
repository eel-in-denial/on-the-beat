extends Node2D

var enemy_1 = preload("res://Characters/enemy_railgun.tscn")
var spawn_num = 1
var spawn_timer = 5.0
var max_spawn_timer = 5.0
var threshold = 4.0
var init_spawn = 5
@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.new_room(preload("res://Assets/Round 4.ogg"), 120)
	for x in range(init_spawn):
		spawn_enemy(enemy_1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if spawn_timer > 0.0:
		spawn_timer -= delta
	else:
		for x in range(spawn_num):
			spawn_enemy(enemy_1)
		max_spawn_timer -= 0.1
		spawn_timer = max_spawn_timer
		if max_spawn_timer <= threshold:
			if max_spawn_timer <= 1.0:
				max_spawn_timer = 2.0
			else:
				threshold -= 1.0
			spawn_num += 1
			

func spawn_enemy(enm: Resource):
	var new_enm = enm.instantiate()
	new_enm.global_position = player.global_position + Vector2(randf_range(100.0, 800.0)* random_sign(), randf_range(100.0, 800.0)* random_sign())
	add_child(new_enm)
	
func random_sign():
	var num = 1
	if randf() < 0.5:
		num = -1
	return num
