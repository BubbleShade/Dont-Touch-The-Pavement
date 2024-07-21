extends CharacterBody2D

@export var speed = 150
@export var accel = 800
@onready var shadowbox: Area2D = get_node("ShadowHitbox")
func Vector2Clamp(inputVector, v1: Vector2, v2: Vector2):
	return Vector2(max(v1.x, min(inputVector.x, v2.x)),
					max(v1.y, min(inputVector.y, v2.y)))
	

func _physics_process(delta):
	var input_direction = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	velocity = Vector2Clamp(velocity + (input_direction * accel * delta),
		Vector2(-speed,-speed), Vector2(speed, speed))
	if(input_direction.x == 0): velocity.x = 0
	if(input_direction.y == 0): velocity.y = 0

	move_and_slide()
	
	print(shadowbox.get_overlapping_bodies())
	#for i in shadowbox.get_overlapping_bodies():
	#	print("I collided with ")
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.collider.name)
		
