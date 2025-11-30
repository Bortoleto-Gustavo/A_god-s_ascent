// O tempo do ataque acabou, voltar ao estado CHASE (Perseguir)
if (state == HANG_STATE.ATTACKING) {
    state = HANG_STATE.CHASE;
}