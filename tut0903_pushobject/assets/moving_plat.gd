extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0

@onready var path = $PathFollow2D
@onready var anim = $AnimationPlayer

var pinch_count := 0
var anim_pos := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if not loop:
		anim.play("move")
		anim.speed_scale = speed_scale
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.progress += speed*delta
