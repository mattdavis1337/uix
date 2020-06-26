extends Sprite


const GrassEffect = preload("res://Effects/GrassEffect.tscn")
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position
	


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
