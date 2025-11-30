// Voltar ao normal (transparência total)
image_alpha = 1.0; 

// Voltar ao estado CHASE (Perseguir)
if (state == ENEMY_STATE.HIT) {
    state = ENEMY_STATE.CHASE;
}