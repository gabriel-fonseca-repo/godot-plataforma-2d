extends Node2D

var telaFinal = false

func _ready():
	$Jogador.connect("morrendo", self, "mostrartelaYD") 
	$"Zona-de-queda".connect("finalizado", self, "mostrartelaHR") 
	$"Zona-de-queda".connect("morrendo", self, "mostrartelaYD") 

func mostrartelaYD():
	$YouDied/YouDiedAnim.play("YouDied")

func mostrartelaHR():
	$YouDied/YouDiedAnim.play("HumanityRestored")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and telaFinal:
		get_tree().reload_current_scene()
		Socket.write_text("JogoFinalizado\n");
	if Input.is_action_just_pressed("ui_cancel") and telaFinal:
		get_tree().quit()
		Socket.write_text("JogoFinalizado\n");

func _on_YouDiedAnim_animation_finished(anim_name):
	if anim_name == "YouDied":
		telaFinal = true
	if anim_name == "HumanityRestored":
		telaFinal = true
