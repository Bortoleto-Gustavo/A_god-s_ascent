// Voltar ao normal (transparência total)
image_alpha = 1.0; 

// Voltar ao estado CHASE (Perseguir)
if (state == BOSS_STATE.HIT) {
    state = BOSS_STATE.CHASE;
}