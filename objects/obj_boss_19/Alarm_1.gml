// O tempo do ataque acabou, voltar ao estado CHASE (Perseguir)
if (state == BOSS_STATE_SUN.ATTACKING) {
    state = BOSS_STATE_SUN.CHASE;
}