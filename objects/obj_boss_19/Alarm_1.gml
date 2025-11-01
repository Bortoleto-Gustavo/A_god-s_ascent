// O tempo do ataque acabou, voltar ao estado CHASE (Perseguir)
if (state == BOSS_STATE.ATTACKING) {
    state = BOSS_STATE.CHASE;
}