extends CharacterBody2D

# gravity parameter
var gravity = 600

var start : bool = false
var enteringLeft : bool = false

# jump speed parameter
var jump_height = 500

func _physics_process(delta):
	
	velocity.y += gravity * delta
	
	# allows movement 
	move_and_slide()
