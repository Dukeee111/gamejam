extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
@export var dashing = false
@export var jump_velocity = -2.0
@export var up = false
var dash_cooldown := 1.0 
var time_since_dash := 0.0
var can_dash := true
var speed_multiplier = 90
var jump_multiplier = -30.0
var direction = 0
var dash_speed = 5

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _spring_jump(jump_force):
	velocity.y = jump_velocity * jump_force

func _input(event):
	# Handle jump.
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	# Handle jump down
	if event.is_action_pressed("move down"):
		set_collision_mask_value(10,false)
	else:
		set_collision_mask_value(10,true)
		
	if event.is_action_pressed("dash"):
		dashing = true
		$dash_timer.start()
	if event.is_action_pressed("up"):
		up = true
		
func _physics_process(delta: float) -> void:
	# Update dash cooldown timer
	if not can_dash:
		time_since_dash += delta
		if time_since_dash >= dash_cooldown:
			can_dash = true
			time_since_dash = 0.
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta 
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		if dashing and can_dash and up == false:
			velocity.x = direction * dash_speed * speed_multiplier
			print(velocity.y)
			can_dash = false
			
		elif dashing and can_dash and up:
			velocity.x = direction * dash_speed * speed_multiplier
			velocity.y += dash_speed * speed_multiplier * -0.5
			print(velocity.y)
			can_dash = false
	
		else:
			velocity.x = direction * speed * speed_multiplier
			
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
		
	move_and_slide()

#Make it stop dashing
func _on_dash_timer_timeout() -> void:
	dashing = false
