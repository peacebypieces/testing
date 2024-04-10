extends Node2D

var ground_instance = preload("res://Ground.tscn")
var added_grounds = []
var viewport_size_x 

func _ready():
	var beginningFloor = ground_instance.instantiate()
	beginningFloor.position = Vector2i(0, 350)
	
	add_child(beginningFloor)
	added_grounds.push_back(beginningFloor)
	
# Called every physics frame.
func _physics_process(delta):
	# Move all grounds to the left
	if(!added_grounds.is_empty()):
		for ground in added_grounds:
			ground.position.x -= 1
		
	viewport_size_x = $Camera2D.get_viewport_rect().size.x
	var camera_right_side = $Camera2D.global_position.x + $Camera2D.get_viewport_rect().size.x / 2

	# Add a new ground instance if needed
	if added_grounds.is_empty() or added_grounds[added_grounds.size() - 1].position.x + viewport_size_x <= camera_right_side:
		# Create a new instance of Ground
		var new_ground = ground_instance.instantiate()

		# Position the new ground to the right of the last ground
		if !added_grounds.is_empty():
			var last_ground = added_grounds[added_grounds.size() - 1]
			new_ground.position.x = last_ground.position.x + viewport_size_x
		else:
			# If there are no existing grounds, position the new ground to the right of the camera
			new_ground.position.x = camera_right_side

		# Add the new ground to the scene and the array
		add_child(new_ground)
		added_grounds.push_back(new_ground)

	# Remove the first ground instance if it's out of the viewport
	if !added_grounds.is_empty() and added_grounds[0].position.x + viewport_size_x <= $Camera2D.global_position.x - $Camera2D.get_viewport_rect().size.x / 2:
		# Mark the ground node for removal
		added_grounds[0].queue_free()
		added_grounds[0] = null
		added_grounds.pop_front()

