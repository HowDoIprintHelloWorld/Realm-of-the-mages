extends CharacterBody2D


const SPEED = 500.0
var lastVel = 0
var sprint = false
var sprintSpeed = 300

@export var maxHealth = 100
@export var currentHealth = maxHealth * 0.25

@export var maxMana = 30
@export var currentMana = 0
@export var manaTickTime = 0.5
var manaTimer = 0

func movement(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction != lastVel:
			lastVel = direction
			$Sprite2D.flip_h = 0 if direction == 1 else 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Input.is_action_pressed("sprint"):
		sprint = 1
	else:
		sprint = 0
		
	velocity = velocity.normalized() * (SPEED + sprint * sprintSpeed)

	move_and_slide()

func tick(vari, maxVari, value, maxTimer, timer, delta):
	if timer >= maxTimer:
		vari += value
		if vari >= maxVari:
			vari = maxVari
		timer = 0
	timer += delta
	return [vari, timer]

func _physics_process(delta):
	movement(delta)
	var res = tick(currentMana, maxMana, 1, manaTickTime, manaTimer, delta)
	currentMana = res[0]
	manaTimer = res[1]
	
