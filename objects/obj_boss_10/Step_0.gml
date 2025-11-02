// Esta estrutura 'switch' vai checar o valor da variável 'state'
switch (state) {

    // --- ESTADO: PERSEGUINDO (CHASE) ---
	
	//MODIFICAR O STATE DE ACORDO COM SEU BOSS
    case BOSS_STATE_HERMIT.CHASE:
        // (A sua lógica de 'sprite_index' antiga estava aqui)
        
        // --- Lógica de Perseguição ---
        if (instance_exists(obj_player)) {
            
            var _dist = point_distance(x, y, obj_player.x, obj_player.y);
            
            if (_dist < chase_range && _dist > min_distance) {
                // --- Mover em direção ao player ---
                direction = point_direction(x, y, obj_player.x, obj_player.y);
                speed = chase_speed;
                
                // --- AQUI ESTÁ A NOVA LÓGICA DE ANIMAÇÃO ---
                // Checar a direção (em graus) para escolher o sprite
                
                if (direction > 45 && direction <= 135) {
                    // Cima
                    sprite_index = sprite_movimento[2]; // (spr_Sun_up)
                }
                else if (direction > 135 && direction <= 225) {
                    // Esquerda
                    sprite_index = sprite_movimento[1]; // (spr_Sun_left)
                }
                else if (direction > 225 && direction <= 315) {
                    // Baixo
                    sprite_index = sprite_movimento[3]; // (spr_Sun_down)
                }
                else {
                    // Direita (entre 315 e 45)
                    sprite_index = sprite_movimento[0]; // (spr_Sun_right)
                }
                
            } else {
                // Parar de se mover
                speed = 0;
                // (Opcional: Voltar para o sprite de "parado" se tiver um)
                // sprite_index = spr_Sun_idle; 
            }
            
        } else {
            // Player não existe, parar
            speed = 0;
        }
        break;

    // --- ESTADO: ATACANDO (ATTACKING) ---
    
	//MODIFICAR DE ACORDO COM O NOME DO SEU BOSS
	case BOSS_STATE_HERMIT.ATTACKING:
        // Parar de se mover enquanto ataca
        speed = 0; 
        
        // Troque 'spr_boss_attack' pelo nome do seu sprite de ataque
		//COLOCAR O ESTADO NORMAL DO SEU BOSS(DE ACORDO COM O NOME DELE)
        sprite_index = spr_hermit_down;
        break;

    // --- ESTADO: LEVANDO DANO (HIT) ---
	//MODIFICAR STATE DE ACORDO COM O NOME DO SEU BOSS
    case BOSS_STATE_HERMIT.HIT:
        // Parar de se mover brevemente ao levar dano
        speed = 0;
        break;

    // --- ESTADO: MORTO (DEAD) ---
	//MODIFICAR STATE DE ACORDO COM O NOME DO SEU BOSS
    case BOSS_STATE_HERMIT.DEAD:
        // Troque 'spr_boss_dead' pelo seu sprite de morte (se tiver)
		//COLOCAR UMA IMAGEM DO BOSS "MORTO"(DE ACORDO COM O NOME DO SEU BOSS)
        sprite_index = spr_hermit_dano;
        speed = 0;
        
        // Aqui você pode adicionar efeitos, som de explosão, etc.
        
        // Destruir o objeto do boss
        instance_destroy();
        break;
}

// --- Verificação de Morte (checa a cada frame) ---

//MODIFICAR STATE DE ACORDO COM O NOME DO SEU BOSS
if (hp <= 0 && state != BOSS_STATE_HERMIT.DEAD) {
    show_debug_message("Boss MORREU!");
    state = BOSS_STATE_HERMIT.DEAD;
    
    // Cancela todos os alarmes para não atacar enquanto morre
    alarm[0] = -1; 
    alarm[1] = -1;
    alarm[2] = -1;
}
// --------------------------------------------------
// --- LÓGICA DE DANO DE TOQUE (DANO NO "NÚCLEO") ---
// (Coloque isso no FIM do seu Evento Step)
// --------------------------------------------------

// 1. Checar se o player existe E se ele NÃO está invencível
if (instance_exists(obj_player) && obj_player.invincible == false)
{
    // 2. Definir o "raio de dano" do núcleo
    // !! AJUSTE ESTE VALOR !!
    // Um valor pequeno, como 8 ou 10, significa que o player
    // tem que estar "bem no centro".
    var _damage_radius = 8; 
    
    // 3. Calcular a distância do centro do boss (x,y) ao centro do player
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    // 4. Checar se o player está DENTRO desse raio pequeno
    if (_dist < _damage_radius)
    {
        // 5. Aplicar o Dano!
        // (Este é o mesmo código que estava no seu Collision Event antigo)
        var _touch_damage = 0.5;
        obj_player.hp -= _touch_damage;
        
        // 6. Ativar a invencibilidade do player
        obj_player.invincible = true;
        obj_player.alarm[0] = room_speed * 1.5; // Ativa o timer
        
        show_debug_message("Player levou dano do NÚCLEO! HP: " + string(obj_player.hp));
    }
}
// --- Atualizar a Animação dos Corações do Boss ---
heart_anim_frame += heart_anim_speed;

// Reinicia a animação quando ela chega ao fim
//MODIFICAR A IMAGEM DE VIDA DE ACORDO COM SEU BOSS
if (heart_anim_frame >= sprite_get_number(spr_heart_full_hermit))
{
    heart_anim_frame = 0;
}