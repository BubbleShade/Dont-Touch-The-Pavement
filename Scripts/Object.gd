extends Node

@export var shadowScale := Vector2(4,1.5)
@onready var Shadow : Sprite2D = get_node("Sprite2D/Shadow")
# Determines the phase of the shadow. 
# 0 is to the left of the object
# 0.5 is behind the object
# 1 is to the right of the object

#@onready var sprite = get_node("Sprite")
@onready var baseOrigin = -Shadow.offset
#var shader_value = material.get_shader_param("level")
# Called when the node enters the scene tree for the first time.
func _ready(): pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#print(shader_value)
	# https://docs.godotengine.org/en/stable/tutorials/math/matrices_and_transforms.html
	var newTransform = Transform2D() 	# Creates a new transform object
	#Modified shadow progess, this looks weird, but it just clamps ShadowProgress between 0 and 1,
	#And also makes it so it bouces, so 1.1 becomes 0.9, instead of 0.1
	var modSP = abs(fmod(abs(LevelInfo.ShadowProgress), 2.0) -1)



	#The sin of the ModShadowProgress * PI. This is done to create the effect so when 
	# ShadowProgress is 0.5, it is behind the object (sin(pi/2) = 1) and when it is 0 or 1 it is at one of the extremes
	# (sin(pi) = sin(0) = 0)
	var sinSP = sin(modSP*PI) 
	
	var cscSP = 1/sin(modSP*PI) 
	
	#The sin of the ModShadowProgress * PI. This is done to create the effect so when 
	# ShadowProgress is 0.5, it is behind the object (sin(pi/2) = 1) and when it is 0 or 1 it is at one of the extremes
	# (sin(pi) = sin(0) = 0)
	var cosSP = cos(modSP*PI) 

	# (modSP*shadowScale*2)-shadowScale - this is the x component of the y compenent
	# when modSP = 0, the x compenent is -shadowScale
	# when modSP = 0.5, the x compenent is 0
	# when modSP = 1, the x compenent is shadowScale
	# TODO: Try switching this with cos
	# The y compenent of the y is set to SP to emulate a circular motion in the shaows transformation
	newTransform.y = Vector2(-cosSP,sinSP) * shadowScale
	
	# if modSP > 0.5, flip the x component of the the t.x of the transform in order flip the sprite
	# (Otherwise it looks weird IDK)
	# The y component of the x is set to 1 - sinSP, in order to keep the t.y.y + t.x.y = 1, otherwise it'll become flat
	newTransform.x = Vector2(sinSP,cosSP)
	#if(modSP > 0.5): newTransform.x = Vector2(-sinSP,cosSP)
	#else: newTransform.x = Vector2(sinSP,cosSP)
	var bounceSP = abs((modSP*2)-1)
	# Change to move the sprite around idk
	newTransform.origin = baseOrigin #- Vector2(-cosSP*8, (bounceSP)*8)

	# Update the sprites transform
	Shadow.transform = newTransform
