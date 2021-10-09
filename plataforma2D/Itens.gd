extends Area2D

func _on_item_body_entered(body: Node) -> void:
	$CarneAnimacao.play("Coletado")
	if body.name == "Jogador":
		body.temItem = true
		Socket.write_text("PegouItem\n");

func _on_anim_animation_finished(anim_name):
	if anim_name == "Coletado":
		queue_free()
