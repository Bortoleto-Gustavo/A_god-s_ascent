// Voltar ao normal (transparência total)
image_alpha = 1.0; 

// Voltar ao estado CHASE (Perseguir)
if (state == MOON_STATE.HIT) {
    state = MOON_STATE.CHASE;
}