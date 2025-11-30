// O tempo do ataque acabou, voltar ao estado CHASE (Perseguir)
if (state == ENEMY_STATE.ATTACKING) {
    state = ENEMY_STATE.CHASE;
}