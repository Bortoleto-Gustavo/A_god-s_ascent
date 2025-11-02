// --- Lógica de Estado: Estamos Atacando? ---
var _is_attacking = (alarm[1] > 0);


// --- 1. PROCESSAR INPUTS E ATUALIZAR VELOCIDADE ---
if (!_is_attacking)
{
    var right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
    var up_key    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
    var left_key  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
    var down_key  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

    velocidade_x = (right_key - left_key) * velocidade_movimento;
    velocidade_y = (down_key - up_key) * velocidade_movimento;
}


// --- 2. PROCESSAR ATAQUE ---
if (mouse_check_button_pressed(mb_left) && !_is_attacking)
{
    // --- Começa o Ataque ---
    _is_attacking = true; 
    velocidade_x = 0;
    velocidade_y = 0;
    alarm[1] = room_speed * 0.3; 
    
    sprite_index = spr_jogador_attack_down; 
    image_index = 0;
    image_speed = 1;
    
    // --------------------------------------------------------
    // --- NOVA LÓGICA DE DANO ---
    // --------------------------------------------------------
    
    // A variável é declarada AQUI, e vale para TUDO abaixo
    var _attack_range = 30; 
    
    // --- CHECAR DANO NO BOSS 1 (SUN) ---
    if (instance_exists(obj_boss_19))
    {
        var _dist = point_distance(x, y, obj_boss_19.x, obj_boss_19.y);
        
        if (_dist < _attack_range) // (Funciona!)
        {
            if (obj_boss_19.state != BOSS_STATE_SUN.HIT && obj_boss_19.state != BOSS_STATE_SUN.DEAD)
            {
                var _damage_taken = 1;
                obj_boss_19.hp -= _damage_taken;
                obj_boss_19.state = BOSS_STATE_SUN.HIT;
                obj_boss_19.image_alpha = 0.5;
                obj_boss_19.alarm[2] = room_speed * 0.2; 
                show_debug_message("Boss SUN levou dano! HP: " + string(obj_boss_19.hp));
            }
        }
    }
    
	 if (instance_exists(obj_boss_20))
    {
        var _dist = point_distance(x, y, obj_boss_20.x, obj_boss_20.y);
        
        if (_dist < _attack_range) // (Funciona!)
        {
            if (obj_boss_20.state != BOSS_STATE_MOON.HIT && obj_boss_20.state != BOSS_STATE_MOON.DEAD)
            {
                var _damage_taken = 1;
                obj_boss_20.hp -= _damage_taken;
                obj_boss_20.state = BOSS_STATE_MOON.HIT;
                obj_boss_20.image_alpha = 0.5;
                obj_boss_20.alarm[2] = room_speed * 0.2; 
                show_debug_message("Boss SUN levou dano! HP: " + string(obj_boss_20.hp));
            }
        }
    }
    

    // --- CHECAR DANO NO BOSS 2 (HERMIT) ---
    if (instance_exists(obj_boss_10))
    {
        var _dist = point_distance(x, y, obj_boss_10.x, obj_boss_10.y);
        
        // (Agora esta linha funciona!)
        if (_dist < _attack_range) 
        {
            if (obj_boss_10.state != BOSS_STATE_HERMIT.HIT && obj_boss_10.state != BOSS_STATE_HERMIT.DEAD)
            {
                var _damage_taken = 1;
                obj_boss_10.hp -= _damage_taken;
                obj_boss_10.state = BOSS_STATE_HERMIT.HIT;
                obj_boss_10.image_alpha = 0.5;
                obj_boss_10.alarm[2] = room_speed * 0.2; 
                show_debug_message("Boss HERMIT levou dano! HP: " + string(obj_boss_10.hp));
            }
        }
    }
    // --------------------------------------------------------
    // --- FIM DA LÓGICA DE DANO ---
    // --------------------------------------------------------

} // <-- FIM do if (mouse_check_button_pressed...)


// --- 3. APLICAR MOVIMENTO ---
x += velocidade_x;
y += velocidade_y;


// --- 4. APLICAR ANIMAÇÃO (Movimento ou Parado) ---
if (!_is_attacking)
{
    mask_index = sprite[Down];
    
    if (velocidade_y == 0) {
        if (velocidade_x > 0) { face = Right; }
        if (velocidade_x < 0) { face = Left; }
    }

    if (velocidade_x > 0 && face == Left) { face = Right; }
    if (velocidade_x < 0 && face == Right) { face = Left; }

    if (velocidade_x == 0) {
        if (velocidade_y > 0) { face = Down; }
        if (velocidade_y < 0) { face = Up; }
    }

    if (velocidade_y > 0 && face == Up) { face = Down; }
    if (velocidade_y < 0 && face == Down) { face = Up; }

    if (velocidade_x == 0 && velocidade_y == 0) {
        image_index = 0; 
        face = Normal;
    }
    
    image_speed = 1; 
    sprite_index = sprite[face];
}

// --- Atualizar a Animação dos Corações ---
heart_anim_frame += heart_anim_speed;

if (heart_anim_frame >= sprite_get_number(spr_heart_full_player))
{
    heart_anim_frame = 0; 
}

// --- VERIFICAÇÃO DE MORTE DO PLAYER ---
if (hp <= 0)
{
    show_debug_message("Player MORREU! Reiniciando a sala.");
    room_restart();
}