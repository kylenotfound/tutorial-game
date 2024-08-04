extends Area2D

@onready var stat_manager = %StatManager

func _on_body_entered(body):
	stat_manager.add_coin();
	queue_free()
