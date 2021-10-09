extends KinematicBody2D

export var mv_velocidade = 64
var velocidade = Vector2.ZERO
var gravidade = 1200
var mv_direcao = -1

func _ready():
	var zdq = get_parent().get_node("Zona-de-queda")
	zdq.connect("finalizado", self, "pararFantasma")

func pararFantasma():
	mv_velocidade = 0
	gravidade = 0

func _physics_process(delta):
	var jogador = get_parent().get_node("Jogador")
	if jogador.position.y > position.y:
		velocidade.y = gravidade * delta
	elif jogador.position.y < position.y:
		velocidade.y = -gravidade * delta
	
	if jogador.position.x > position.x:
		velocidade.x = -mv_velocidade * mv_direcao
	elif jogador.position.x < position.x:
		velocidade.x = mv_velocidade * mv_direcao

	if position.x > jogador.position.x:
		$SpriteFantasma.flip_h = false
		$ColisaoFantasma2.scale.x = 1
		mv_direcao = -1
	elif position.x < jogador.position.x:
		$SpriteFantasma.flip_h = true
		$ColisaoFantasma2.scale.x = -1
	velocidade = move_and_slide(velocidade)

func _on_FantasmaCheck_body_entered(body):
	if body.name == "Jogador":
		$AnimacaoFantasma.play("Ataque")

func _on_AnimacaoFantasma_animation_finished(anim_name):
	var jogador = get_parent().get_node("Jogador")
	if anim_name == "Ataque":
		jogador.get_node("AnimacaoJogador").play("Morrendo")
		$AnimacaoFantasma.play("Sumindo")
	if anim_name == "Sumindo":
		$SpriteFantasma.visible = false
