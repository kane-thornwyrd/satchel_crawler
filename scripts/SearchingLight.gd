class_name SearchingLight
extends KinematicBody2D

const SCREEN_SIZE = Vector2(480, 270)

export(float, 1, 10, .1) var speed = 100
export(NodePath) var navPath

var _previous_position: Vector2 = SCREEN_SIZE / 2
var velocity: Vector2 = Vector2.ZERO
var path: Array = []
var threshold: int = 16

onready var nav: Navigation2D = get_node(navPath)


func _ready():
	yield(owner, "ready")


func _process(_delta):
	move_to_target()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		get_target_path(get_global_mouse_position())


static func get_new_target() -> Vector2:
	var new_target = Vector2(randi() % int(SCREEN_SIZE.x + 1), randi() % int(SCREEN_SIZE.y + 1))
	return new_target


func move_to_target():
	if path.size() <= 0:
		get_target_path(get_new_target())

	if global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	else:
		var direction = global_position.direction_to(path[0])
		velocity = move_and_slide(direction * speed)


func get_target_path(target_pos):
	path = nav.get_simple_path(global_position, target_pos, false)
