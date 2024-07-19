extends CharacterBody2D

@export var speed = 400

func _physics_process(delta):
	var input_direction = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	velocity = input_direction * speed
	print(input_direction)
	move_and_slide()
