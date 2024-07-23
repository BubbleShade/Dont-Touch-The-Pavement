extends Node

@export var speed = 150
@export var accel = 800
@onready var charBody: CharacterBody2D = get_node("Body2D")
@onready var shadowbox: Area2D = charBody.get_node("ShadowHitbox")

var collidingSafeBodies = []
@onready var lastPosition = charBody.position
func Vector2Clamp(inputVector, v1: Vector2, v2: Vector2):
	return Vector2(max(v1.x, min(inputVector.x, v2.x)),
					max(v1.y, min(inputVector.y, v2.y)))
func getVelocity(delta):
	var input_direction = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	var newVelocity = charBody.velocity + (input_direction * accel * delta)
	newVelocity = Vector2Clamp(newVelocity, Vector2(-speed,-speed), Vector2(speed, speed))
	if(input_direction.x == 0): newVelocity.x = 0
	if(input_direction.y == 0): newVelocity.y = 0
	return newVelocity
func isSafe():
	var tilemap : TileMap = get_node("../TileMap")
	var tileBelow := tilemap.local_to_map(charBody.global_position) 
	var tileExists = tilemap.get_cell_source_id(1, tileBelow) != -1
	
	return (len(collidingSafeBodies) != 0) || tileExists
	

func _physics_process(delta):
	
	lastPosition = charBody.position
	#print(lastPosition, "Before")
	charBody.velocity = getVelocity(delta)
	charBody.move_and_slide()
	#print(charBody.velocity)
	#else:
	#	charBody.position = sprite.position
func _process(delta):
	if(!isSafe()): charBody.position = lastPosition
	
func _ready():
	shadowbox.area_entered.connect(onBodyEnter)
	shadowbox.area_exited.connect(onBodyExit)
	
func onBodyEnter(body: Node):
	collidingSafeBodies.append(body)
func onBodyExit(body: Node):
	collidingSafeBodies.remove_at(collidingSafeBodies.find(body))
