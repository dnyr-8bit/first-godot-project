extends CharacterBody3D

@export var move_speed :float = 5.0
@export var acceleration :float = 20.0
@export var jump_velocity :float = 5.0

var gravity: float = float(ProjectSettings.get_setting("physics/3d/default_gravity"))

@onready var camera: Camera3D = ($CameraPivot/SpringArm3D/Camera3D)

func _physics_process(in_delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * in_delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	var input := Input.get_vector("move_left","move_right","move_forward","move_backward")
	var camera_basis := camera.global_transform.basis
	
	var forward := -camera_basis.z
	forward.y = 0.0
	forward = forward.normalized()
	
	var right := camera_basis.x
	right.y = 0.0
	right = right.normalized()
	
	var direction := (right * input.x + forward * -input.y).normalized()
	
	velocity.x = move_toward(velocity.x, direction.x * move_speed, acceleration * in_delta)
	velocity.z = move_toward(velocity.z, direction.z * move_speed, acceleration * in_delta)
	
	move_and_slide()
	
