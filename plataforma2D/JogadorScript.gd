extends KinematicBody2D

onready var raycasts = $raycasts
signal morrendo
var velocidade = Vector2.ZERO
var mv_velocidade = 220
var gravidade = 1200
var forca_pulo = -720
var no_chao
var temItem = false
var permJoystick = false
var jogadorMorto = false

func _ready():
	Socket.connect("direita", self, "MVdireita")
	Socket.connect("esquerda", self, "MVesquerda")
	Socket.connect("ponto_morto", self, "PontoMorto")
	Socket.connect("pulou", self, "Pulou")

func Pulou():
#	print("Pulo")
	if _esta_no_chao() == true:
		velocidade.y = forca_pulo / 2

func MVdireita():
	permJoystick = true
	if jogadorMorto == false:
		velocidade.x = lerp(velocidade.x, mv_velocidade * 1, 0.2)
#		print("Sim")
		$TexturaJogador.scale.x = 1
		_determinar_animacao()

func MVesquerda():
	permJoystick = true
	if jogadorMorto == false:
		velocidade.x = lerp(velocidade.x, mv_velocidade * -1, 0.2)
#		print("Não")
		$TexturaJogador.scale.x = -1
		_determinar_animacao()

func PontoMorto():
	permJoystick = false
	velocidade.x = 0
#	print("morto")
	_determinar_animacao()

func _physics_process(delta):
	velocidade.y += gravidade * delta
#	_entrada_controles()
	velocidade = move_and_slide(velocidade)
#	no_chao = _esta_no_chao()

#func _entrada_controles():
#	velocidade.x = 0
#	var mv_direcao = int(Input.is_action_pressed("mv_right")) - int(Input.is_action_pressed("mv_left"))
#	if permJoystick == false:
#		velocidade.x = lerp(velocidade.x, mv_velocidade * mv_direcao, 0.2)
#	if $AnimacaoJogador.assigned_animation == "Morrendo":
#		$TexturaJogador.scale.x = 1
#	elif mv_direcao != 0:
#		$TexturaJogador.scale.x = mv_direcao

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and no_chao:
		velocidade.y = forca_pulo / 2

func _esta_no_chao():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _determinar_animacao():
	var fantasmaColisao = get_parent().get_node("Fantasma/ColisaoFantasma2")
	var animacao = "Idle"
	if velocidade.x != 0:
		animacao = "Correr"
		if $AnimacaoJogador.assigned_animation != animacao:
			$AnimacaoJogador.play(animacao)
	if fantasmaColisao.is_colliding():
		mv_velocidade = 0
		forca_pulo = 0
		jogadorMorto = true
		animacao = "Morrendo"
		if $AnimacaoJogador.assigned_animation != animacao:
			$AnimacaoJogador.play(animacao)
	if $AnimacaoJogador.assigned_animation != animacao:
		$AnimacaoJogador.play(animacao)

func _on_AnimacaoJogador_animation_finished(anim_name):
	if anim_name == "Morrendo":
		emit_signal("morrendo")
