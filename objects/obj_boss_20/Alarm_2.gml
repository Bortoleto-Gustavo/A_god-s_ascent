// Voltar ao normal (transparência total)
image_alpha = 1.0; 

// Voltar ao estado CHASE (Perseguir)
//MODIFICAR DE ACORDO COM O NOME DO SEU BOSS
if (state == BOSS_STATE_MOON.HIT) {
    state = BOSS_STATE_MOON.CHASE;
}