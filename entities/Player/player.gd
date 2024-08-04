extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var player = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#input direction: -1, 0, 1.
	var direction = Input.get_axis("move_left", "move_right")
	
	#flip sprite direction when moving	
	if direction > 0:
		player.flip_h = false;
	elif direction < 0:
		player.flip_h = true;

	_handleAnimations(direction)
	_handleMovement(direction)
		
	move_and_slide()

func _handleAnimations(direction):
	if is_on_floor():
		#show run or idle animation
		if direction == 0:
			player.play("idle");	
		else:
			player.play("run");
	else:
		player.play("jump");
		
func _handleMovement(direction):
		#move the player
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
