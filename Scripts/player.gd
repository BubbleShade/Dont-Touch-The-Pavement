extends CharacterBody2D

@export var speed = 150
@export var accel = 800
@onready var shadowbox: Area2D = get_node("ShadowHitbox")
@onready var animation: AnimatedSprite2D = get_node("AnimatedSprite")

var collidingSafeBodies = []
@onready var lastPosition = position
signal test
func Vector2Clamp(inputVector, v1: Vector2, v2: Vector2):
	return Vector2(max(v1.x, min(inputVector.x, v2.x)),
					max(v1.y, min(inputVector.y, v2.y)))
func getVelocity(delta):
	var input_direction = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	if(input_direction.x > 0): animation.flip_h = false
	elif (input_direction.x < 0): animation.flip_h = true
	var newVelocity = velocity + (input_direction * accel * delta)
	newVelocity = Vector2Clamp(newVelocity, Vector2(-speed,-speed), Vector2(speed, speed))
	if(input_direction.x == 0): newVelocity.x = 0
	if(input_direction.y == 0): newVelocity.y = 0
	if(input_direction == Vector2.ZERO): animation.animation = "default"
	else: animation.animation = "Walk"
	return newVelocity
	
func isSafe():
	var tilemap : TileMap = get_node("../TileMap")
	var tileBelow := tilemap.local_to_map(global_position + Vector2(0,8)) 
	var tileabove := tilemap.local_to_map(global_position) 
	var tileExists = tilemap.get_cell_source_id(1, tileBelow) != -1 || tilemap.get_cell_source_id(1, tileabove) != -1
	return (len(collidingSafeBodies) != 0) || tileExists
	

func _physics_process(delta):
	if(!isSafe()):
		position = lastPosition
		velocity = Vector2.ZERO
	lastPosition = position
	velocity = getVelocity(delta)
	move_and_slide()

func _process(delta): pass

func _ready():
	shadowbox.area_entered.connect(onBodyEnter)
	shadowbox.area_exited.connect(onBodyExit)
	
func onBodyEnter(body: Node):
	if(body.is_in_group("shadow")):
		collidingSafeBodies.append(body)
		return
	if(body.is_in_group("Goal")):
		print("Victory")
	
func onBodyExit(body: Node):
	collidingSafeBodies.remove_at(collidingSafeBodies.find(body))
