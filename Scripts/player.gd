extends CharacterBody2D

@onready var startLocation = position
@export var speed = 150
@export var accel = 800
@onready var shadowbox: Area2D = get_node("ShadowHitbox")
@onready var pickupbox: Area2D = get_node("Pickup")
@onready var animation: AnimatedSprite2D = get_node("AnimatedSprite")
@onready
var pickupScript = Pickup.new(self)

var collidingSafeBodies = []
@onready var lastPosition = position

@onready
var feetBurn := AudioHandler.createLoop(self, LevelInfo.sizzle, 0, 1)
var feetBurnTime = 20
var feetBurning = false
func _ready():
	shadowbox.area_entered.connect(onBodyEnter)
	shadowbox.area_exited.connect(onBodyExit)
	LevelInfo.restartLevel.connect(restart)
func restart():
	pickupScript.Restart()
	position = startLocation

var lastStep = 0

func Vector2Clamp(inputVector, v1: Vector2, v2: Vector2):
	return Vector2(max(v1.x, min(inputVector.x, v2.x)),
					max(v1.y, min(inputVector.y, v2.y)))
func PlayWalkSound(delta):
	feetBurnTime += delta
	if(feetBurnTime > 1 && feetBurning):
		AudioHandler.play(self, LevelInfo.sizzle)
		feetBurnTime = 0
		return
	if(timeSinceLastStep < 0.4): return
	timeSinceLastStep = 0
	var tilemap : TileMap = get_node("../TileMap")
	var tileBelow := tilemap.local_to_map(global_position) 
	var tileExists = tilemap.get_cell_source_id(1, tileBelow) != -1
	if(tileExists):
		AudioHandler.play(self, LevelInfo.walk_sound_effect_grass, -25, 0.8)
		return
	AudioHandler.play(self, LevelInfo.walk_sound_concrete, -20, 0.75)
var timeSinceLastStep = 0
func getVelocity(delta):
	var input_direction = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	if(input_direction.x > 0): animation.flip_h = false
	elif (input_direction.x < 0): animation.flip_h = true
	var newVelocity = velocity + (input_direction * accel * delta)
	newVelocity = Vector2Clamp(newVelocity, Vector2(-speed,-speed), Vector2(speed, speed))
	
	if(input_direction != Vector2.ZERO):
		animation.animation = "Walk"
		timeSinceLastStep += delta
		PlayWalkSound(delta) 
	else: 
		animation.animation = "default"

	if(input_direction.x == 0): newVelocity.x = 0
	if(input_direction.y == 0): newVelocity.y = 0
	return newVelocity
	
func isSafe():
	var tilemap : TileMap = get_node("../TileMap")
	var tileBelow := tilemap.local_to_map(global_position - Vector2(0,8)) 
	var tileabove := tilemap.local_to_map(global_position) 
	var tileMuchBelow := tilemap.local_to_map(global_position + Vector2(0,4)) 
	var tileExists = (tilemap.get_cell_source_id(1, tileBelow) != -1 || 
					tilemap.get_cell_source_id(1, tileabove) != -1 ||
					tilemap.get_cell_source_id(1, tileMuchBelow) != -1)
	return (len(collidingSafeBodies) != 0) || tileExists
	

	
func _physics_process(delta):
	if(!isSafe()):
		if(position != lastPosition):
			feetBurning = true
			if(feetBurnTime > 1.5):
				feetBurnTime = 0.5
		else: feetBurning = false
		position = lastPosition
		velocity = Vector2.ZERO
	else: feetBurning = false
	if(Input.is_action_just_pressed("Interact")):
		pickupScript.pickupObject()
	lastPosition = position
	velocity = getVelocity(delta)
	move_and_slide()

func _process(delta):
	pickupScript._process()
	
func onBodyEnter(body: Node):
	if(body.is_in_group("shadow")):
		collidingSafeBodies.append(body)
		return
	
func onBodyExit(body: Node):
	collidingSafeBodies.remove_at(collidingSafeBodies.find(body))
	
func _on_pickup_area_entered(area):
	pickupScript.addBody(area.get_parent())


func _on_pickup_area_exited(area):
	pickupScript.removeBody(area.get_parent())
