// O tempo do ataque acabou, voltar ao estado CHASE (Perseguir)
if (state == BOSS_STATE_HERMIT.ATTACKING) {
    state = BOSS_STATE_HERMIT.CHASE;
}