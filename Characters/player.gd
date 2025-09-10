extends CharacterBody2D
@export var score_text: Label
var score := 0
@onready var action_controller := $ActionController
@onready var sprite := $sprite
@onready var collision_disabled := false
@onready var line := $sprite/Line2D
@export var healthbar: Node2D
var colour := Color.ALICE_BLUE
var health := 5:
	set(value):
		health = value
		healthbar.lose_health(health)
		if health <= 0:
			die.call_deferred()
			Global.reset()
#func _ready() -> void:
	#Global.beat.connect(action)
func _physics_process(delta: float) -> void:
	action_controller.direction = global_position.direction_to(get_global_mouse_position())
	sprite.look_at(global_position + action_controller.direction)
	if Input.is_action_just_pressed("Input 1"):
		action_controller.change_action(action_controller.actions[1])
	move_and_slide()


func set_invulnerable(value):
	collision_disabled = value
	if value == true:
		line.material.set_shader_parameter("glow_color", Color.YELLOW)
	else:
		line.material.set_shader_parameter("glow_color", Color.html("33ffe6"))


func _on_area_2d_area_entered(area: Area2D) -> void:

	if area.is_in_group("enemy"):
		if collision_disabled:
			area.queue_free()
			score += 10
			score_text.text = str(score)
		else:
			health -= 1

	elif area.is_in_group("projectile"):
		if not collision_disabled:
			health -= 1
func die():
	get_tree().change_scene_to_file("res://node_2d.tscn")
