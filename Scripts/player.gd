extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	#Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Handle jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Get the input direction and handle the movement/deceleration
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _input(event):
	if event.is_action_pressed("down"):
		var query :=  PhysicsRayQueryParameters2D.create(
			global_position,
			global_position + Vector2(0,10)
		)
		query.exclude = [self] #Exclude the player itself
		
		var collision_info = get_world_2d().direct_space_state.intersect_ray(query)
		
		if collision_info:
			var collider = collision_info.collider
			if collider and collider.has_method("get_collision_layer"):
				if collider.collision_layer == 2:
					$CollisionShape2D.disabled = true #Temporarily disable the player's collision
				
					position.y += 1 #Down movement for the player
				
					await get_tree().create_timer(0.1).timeout #waiting time
					$CollisionShape2D.disabled = false
			else:
				pass
		else:
			pass
