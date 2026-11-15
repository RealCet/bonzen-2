extends Node2D
 
 
const BULLET = preload("res://bullet.tscn")
 
var ammo = 6
 
@onready var muzzle: Marker2D = $Marker2D
 
 
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
 
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
 
 
	if Input.is_action_just_pressed("fire"):
		if ammo > 0:
			var bullet_instance = BULLET.instantiate()
			get_parent().add_sibling(bullet_instance)
			bullet_instance.global_position = muzzle.global_position
			bullet_instance.set_direction(muzzle.global_transform.x)
			ammo -= 1
			print(ammo)
		else:
			print("no bullet hahah")
