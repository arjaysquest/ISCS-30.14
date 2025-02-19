extends Sprite2D


var initial_position
var w
var h

func _ready():
	initial_position = position
	w = texture.get_width()
	h = texture.get_height()
	region_rect = region_rect.grow_side(SIDE_LEFT, w)
	region_rect = region_rect.grow_side(SIDE_RIGHT, w)
	region_rect = region_rect.grow_side(SIDE_BOTTOM, h)
	region_rect = region_rect.grow_side(SIDE_TOP, h)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 75 * delta
	position.x = fmod(position.x + initial_position.x, w)  + initial_position.x
	print(initial_position.x - position.x)
