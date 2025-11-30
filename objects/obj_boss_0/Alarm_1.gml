// O tempo do ataque acabou, voltar ao estado CHASE (Perseguir)
if (state == MOON_STATE.ATTACKING) {
    state = MOON_STATE.CHASE;
}