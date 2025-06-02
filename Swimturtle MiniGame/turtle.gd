extends CharacterBody2D

const Gravity: int = 1000
const maxVel: int = 600
const flapspeed: int = -470
var flying: bool = false
var falling : bool = false 


func _ready():
	reset()
	
func reset():

	$Sprite2D.visible = true
	$Sprite2D2.visible = false
	falling = false
	flying = false
	set_rotation(0)

func _physics_process(delta):
	if flying or falling:
		velocity.y += Gravity * delta
		if velocity.y > maxVel:
			velocity.y = maxVel
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.007))
			$Sprite2D.play("default")
		elif falling:
			$Sprite2D.visible = false
			$Sprite2D2.visible = true
	move_and_slide()
	
func flap():
	velocity.y = flapspeed	
	falling = true
