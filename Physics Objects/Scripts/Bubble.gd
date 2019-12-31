extends Area2D

#var ball_scene = preload("res://Physics Objects/Scenes/MainBall.tscn")

var balldefaultgravity = 0
var ballDefaulLinearDamp = 0
var ball
var isActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_enter")
	$PopArea.connect("input_event", self, "on_input_event")
	
func on_body_enter(body : PhysicsBody2D):
	if body.is_in_group("MainBall"):
		isActive = true
		ball = body
#		body.set_deferred(mode, RigidBody2D.MODE_KINEMATIC)
		balldefaultgravity = body.gravity_scale
		body.gravity_scale = 0
		body.linear_velocity = Vector2(0,-150)
		ballDefaulLinearDamp = body.linear_damp
		body.linear_damp = 0

func _process(delta):
	if isActive:
		position = ball.position

func on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
        pop()

func pop():
	ball.gravity_scale = balldefaultgravity
	ball.linear_damp = ballDefaulLinearDamp
	queue_free()
