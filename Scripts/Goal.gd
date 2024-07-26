extends Area2D
@export var nextLevel = "Levels/Level1"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_body_entered(body):
	print("collide")
	if(body.is_in_group("player")):
		SceneTransition.load_scene(nextLevel)
		return
