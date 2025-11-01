// --- Lógica de Estado: Estamos Atacando? ---
// alarm[1] é o nosso timer de "duração da animação de ataque"
var _is_attacking = (alarm[1] > 0);


// --- 1. PROCESSAR INPUTS E ATUALIZAR VELOCIDADE ---
// --- 1. PROCESSAR INPUTS E ATUALIZAR VELOCIDADE ---
if (!_is_attacking)
{
    // Se NÃO estivermos atacando, ler as teclas (Setas OU WASD)
    var right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
    var up_key    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
    var left_key  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
    var down_key  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

    velocidade_x = (right_key - left_key) * velocidade_movimento;
    velocidade_y = (down_key - up_key) * velocidade_movimento;
}


// --- 2. PROCESSAR ATAQUE ---
if (mouse_check_button_pressed(mb_left) && !_is_attacking)
{
    // --- Começa o Ataque ---
    _is_attacking = true; // Trava o movimento
    velocidade_x = 0;
    velocidade_y = 0;
    alarm[1] = room_speed * 0.3; // Timer da animação
    
    // 1. Tocar a Animação de Ataque
    sprite_index = spr_jogador_attack_down; // (Seu sprite de ataque único)
    image_index = 0;
    image_speed = 1;
    
    // --------------------------------------------------------
    // --- MUDANÇA AQUI: NOVA LÓGICA DE DANO ---
    // --------------------------------------------------------
    // Nós NÃO criamos mais o 'obj_player_attack'.
    // Em vez disso, checamos a distância AGORA:
    
    // !! AJUSTE ESTE VALOR !!
    // Esta é a "distância considerável" que você pediu
    var _attack_range = 30; // Ex: 30 pixels
    
    // 1. Checar se o boss existe
    if (instance_exists(obj_boss_19))
    {
        // 2. Calcular a distância
        var _dist = point_distance(x, y, obj_boss_19.x, obj_boss_19.y);
        
        // 3. Se o boss estiver DENTRO do alcance
        if (_dist < _attack_range)
        {
            // 4. Checar se o boss NÃO ESTÁ invencível
            // (Isso lê as variáveis do boss)
            if (obj_boss_19.state != BOSS_STATE.HIT && obj_boss_19.state != BOSS_STATE.DEAD)
            {
                // 5. DAR O DANO!
                // (Este é o código que estava no evento de colisão,
                // agora ele fica aqui)
                var _damage_taken = 1;
                obj_boss_19.hp -= _damage_taken;
                
                // Manda o boss entrar no estado "HIT"
                obj_boss_19.state = BOSS_STATE.HIT;
                obj_boss_19.image_alpha = 0.5;
                obj_boss_19.alarm[2] = room_speed * 0.2; // Liga o timer de "piscar" do boss
                
                show_debug_message("Boss levou dano! HP: " + string(obj_boss_19.hp));
            }
        }
    }
    // --------------------------------------------------------
    // --- FIM DA MUDANÇA ---
    // --------------------------------------------------------
}


// --- 3. APLICAR MOVIMENTO ---
x += velocidade_x;
y += velocidade_y;


// --- 4. APLICAR ANIMAÇÃO (Movimento ou Parado) ---
if (!_is_attacking)
{
    // Sua lógica de animação de movimento (agora funciona)
    mask_index = sprite[Down];
    
    if (velocidade_y == 0) {
        if (velocidade_x > 0) { face = Right; }
        if (velocidade_x < 0) { face = Left; }
    }
    // ... (o resto da sua lógica de 'face' e 'sprite[face]'...)
    // (Eu cortei aqui para resumir, mas cole o seu código
    // de 'face' inteiro que já funcionava)
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

// Para garantir que o frame não exceda o número total de sub-imagens do sprite
// Use sprite_get_number(spr_heart_full) para que funcione com qualquer quantidade de frames
if (heart_anim_frame >= sprite_get_number(spr_heart_full))
{
    heart_anim_frame = 0; // Reinicia a animação
}
// ------------------------------------
// --- VERIFICAÇÃO DE MORTE DO PLAYER ---
// (Este bloco DEVE estar no FINAL do seu Evento Step)
// ------------------------------------

// Checar se a vida é 0 ou menor
if (hp <= 0)
{
    // (Opcional) Mostrar uma mensagem no console
    show_debug_message("Player MORREU! Reiniciando a sala.");
    
    // Ação de morte: Reiniciar a sala
    room_restart();
    
    // (Se você tiver uma sala de Game Over,
    //  você pode usar 'room_goto(rm_game_over);' em vez disso)
}