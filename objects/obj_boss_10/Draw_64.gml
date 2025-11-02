// --- Desenhar os 10 Corações de Vida do Boss (Lado Direito + Animação) ---

var _scale = 2; // ESCALA AQUI!
var _heart_y = 20;
var _x_padding = 20;
var _spacing = 4;
var _gui_width = display_get_gui_width();
var _heart_width_scaled = sprite_get_width(spr_heart_full_hermit) * _scale;
var _heart_sep = _heart_width_scaled + _spacing;

// Loop para desenhar os 10 corações (da direita para a esquerda)
for (var i = 0; i < hp_max; i++)
{
    // Posição X (ancorado na direita, desenha para a esquerda)
    var _draw_x = (_gui_width - _x_padding - _heart_width_scaled) - (i * _heart_sep);
    
    var _sprite_to_draw;
    // Por padrão, frame 0 (para os corações vazios)
    var _subimg_to_draw = 0; 
    
    // Lógica de esvaziamento (da direita para a esquerda)
    var _empty_hearts = hp_max - hp;
    
    if (i < _empty_hearts)
    {
        _sprite_to_draw = spr_heart_empty_hermit;
    }
    else
    {
        _sprite_to_draw = spr_heart_full_hermit;
        
        // --- AQUI ESTÁ A MUDANÇA! ---
        // Usar a variável de animação do BOSS
        _subimg_to_draw = floor(heart_anim_frame);
    }
    
    // Desenhar o sprite
    draw_sprite_ext(
        _sprite_to_draw,   
        _subimg_to_draw, // O frame (agora animado!)
        _draw_x, _heart_y,
        _scale, _scale,
        0, c_white, 1
    );
}