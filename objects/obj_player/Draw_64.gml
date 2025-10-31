// --- Desenhar os Corações de Vida (Com "Metades", ESCALA e ANIMAÇÃO) ---

var _scale = 2; // ESCALA AQUI! 2 = Dobro do tamanho
var _heart_x = 20; 
var _heart_y = 20; 

var _heart_width = sprite_get_width(spr_heart_full);
var _heart_sep = (_heart_width * _scale) + 0.6; 

for (var i = 0; i < hp_max; i++)
{
    var _draw_x = _heart_x + (i * _heart_sep);
    
    var _sprite_to_draw;
    var _subimg_to_draw = 0; // Por padrão, frame 0

    if (hp >= i + 1) {
        _sprite_to_draw = spr_heart_full;
        // AQUI USAMOS A VARIÁVEL DE ANIMAÇÃO!
        _subimg_to_draw = floor(heart_anim_frame);
    }
    else if (hp >= i + 0.5) {
        _sprite_to_draw = spr_heart_half;
    }
    else {
        _sprite_to_draw = spr_heart_empty;
    }
    
    draw_sprite_ext(
        _sprite_to_draw,          // O sprite (cheio, metade, vazio)
        _subimg_to_draw,          // O FRAME (agora animado!)
        _draw_x, _heart_y, 
        _scale, _scale, 
        0, c_white, 1
    );
}