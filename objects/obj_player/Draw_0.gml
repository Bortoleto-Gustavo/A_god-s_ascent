// --- Lógica de "Piscar" ---

if (invincible == true) {
    // Se estiver invencível, fica piscando (alternando alfa)
    // 'get_timer()' retorna o tempo do jogo em microssegundos,
    // usamos 'sin()' para criar uma onda suave de 0.5 a 1.0
    var _alpha = lerp(0.5, 1.0, abs(sin(get_timer() / 100000)));
    image_alpha = _alpha;
} else {
    // Se não, alfa normal
    image_alpha = 1.0;
}

// Desenha o sprite do jogador com o alfa correto
draw_self();