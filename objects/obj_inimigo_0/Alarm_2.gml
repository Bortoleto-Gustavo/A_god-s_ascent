// Voltar ao normal (transparência total)
image_alpha = 1.0; 

// Voltar ao estado CHASE (Perseguir)
if (state == ENEMY0_STATE.HIT) {
    state = ENEMY0_STATE.CHASE;
}