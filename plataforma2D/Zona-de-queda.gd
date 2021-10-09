extends Area2D

signal finalizado
signal morrendo

func _on_Zonadequeda_body_entered(body):
	if body.temItem == true:
		emit_signal("finalizado")
	else:
		emit_signal("morrendo")
