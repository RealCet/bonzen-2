extends CharacterBody2D
 
 
const MAX_SPEED: int = 125
const ACCELERATION: int = 1400
const FRICTION: int = 1000
const eye = preload("res://eye.tscn")
@onready var sprite: Sprite2D = $Sprite2D
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
 #var eye_instance = eye.instantiate()
#get_parent().add_sibling(eye_instannce) 
func _process(delta: float) -> void:
	if get_global_mouse_position().x < global_position.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
 
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction.x, ACCELERATION * delta)
		velocity.y = move_toward(velocity.y, MAX_SPEED * direction.y, ACCELERATION * delta)
		#animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction.x, FRICTION * delta)
		velocity.y = move_toward(velocity.y, MAX_SPEED * direction.y, FRICTION * delta)
		#animation_player.play("idle")
	
	move_and_slide()


func _on_pearl_pickup_area_entered(area: Area2D) -> void:
	if area.is.in.group("pearl"):
		area.queue_free()
