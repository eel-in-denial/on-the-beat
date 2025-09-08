extends CharacterBody2D

@onready var action_controller := $ActionController
@onready var sprite := $sprite
@onready var collision := $Area2D/CollisionShape2D
@onready var line := $sprite/Line2D
@export var healthbar: Node2D
var colour := Color.ALICE_BLUE
var health := 5
#func _ready() -> void:
	#Global.beat.connect(action)
func _physics_process(delta: float) -> void:
	action_controller.direction = global_position.direction_to(get_global_mouse_position())
	sprite.look_at(global_position + action_controller.direction)
	if Input.is_action_just_pressed("Input 1"):
		action_controller.change_action(action_controller.actions[1])
	move_and_slide()


func set_invulnerable(value):
	collision.disabled = value
	if value == true:
		line.material.set_shader_parameter("glow_color", Color.YELLOW)
	else:
		line.material.set_shader_parameter("glow_color", Color.html("33ffe6"))


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("whatt")
	if area.is_in_group("enemy"):
		area.queue_free()
		print("is going on")
	elif area.is_in_group("projectile"):
		health -= 1
		healthbar.lose_health(health)
