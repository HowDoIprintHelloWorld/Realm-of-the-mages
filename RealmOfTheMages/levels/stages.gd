extends Node2D

@onready var player = $hero
@onready var progressBar = $Control/progressBar
@onready var manaBar = $Control/manaBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progressBar.max_value = player.maxHealth
	progressBar.value = player.currentHealth
	
	manaBar.max_value = player.maxMana
	manaBar.value = player.currentMana
