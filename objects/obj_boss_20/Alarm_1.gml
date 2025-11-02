// O tempo do ataque acabou, voltar ao estado CHASE (Perseguir)
//MODIFICAR DE ACORDO COM NOME DO BOSS
if (state == BOSS_STATE_MOON.ATTACKING) {
    state = BOSS_STATE_MOON.CHASE;
}