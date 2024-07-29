class_name Pickup
var pickupsInRange = []
var pickupSelected : Node2D
var holding : StaticBody2D
var holdingShadow : Node2D
var parent : CharacterBody2D

func _init(Parent):
	parent = Parent
	
func setOutline(body, outline):
	if(body == null): return
	var pickupSprite : Sprite2D = body.get_node("Sprite2D")
	pickupSprite.material.set_shader_parameter("line_thickness", outline)
func addBody(body):
	pickupsInRange.append(body)

func removeBody(body):
	pickupsInRange.remove_at(pickupsInRange.find(body))
func _process():
	if(holding != null): return
	var lastPickup = pickupSelected
	if(len(pickupsInRange) == 0):
		pickupSelected = null
	else:
		pickupSelected = pickupsInRange[0]
		var nearestRange = pickupSelected.global_position.distance_to(parent.global_position)
		var dist = 0
		for pickup in pickupsInRange:
			dist = pickup.global_position.distance_to(parent.global_position)
			if(dist < nearestRange):
				nearestRange = dist
				pickupSelected = pickup
	setOutline(pickupSelected, 1)
	if(lastPickup != pickupSelected):
		setOutline(lastPickup, 0)
func Restart():
	if(holding != null):
		pickupObject()
	if(pickupSelected != null): setOutline(pickupSelected, 0)
	holding = null
	pickupSelected = null
	pickupsInRange = []

func pickupObject():
	if holding == null:
		if pickupSelected == null: return
		AudioHandler.play(parent, LevelInfo.pickup_sound)
		holding = pickupSelected
		holdingShadow = holding.get_node("Sprite2D/Shadow/Shadow")
		var shadowSprite : Sprite2D = holding.get_node("Sprite2D/Shadow")
		shadowSprite.modulate.a = 0.2
		holding.get_node("CollisionShape2D").disabled = true
		holding.position = holding.global_position - parent.global_position
		holding.get_parent().remove_child(holding)
		parent.add_child(holding)
		holding.get_node("Sprite2D/Shadow").remove_child(holdingShadow)
		setOutline(holding, 0)
	else:
		AudioHandler.play(parent, LevelInfo.drop_sound)
		holding.position = holding.global_position
		holding.get_node("Sprite2D/Shadow").add_child(holdingShadow)
		holding.get_node("CollisionShape2D").disabled = false
		var shadowSprite : Sprite2D = holding.get_node("Sprite2D/Shadow")
		shadowSprite.modulate.a = 0.67
		parent.remove_child(holding)
		parent.get_parent().add_child(holding)
		pickupSelected = holding
		holding = null
