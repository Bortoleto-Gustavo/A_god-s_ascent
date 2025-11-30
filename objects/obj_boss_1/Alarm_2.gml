// Voltar ao normal (transparência total)
image_alpha = 1.0; 

// Voltar ao estado CHASE (Perseguir)
if (state == HANG_STATE.HIT) {
    state = HANG_STATE.CHASE;
}