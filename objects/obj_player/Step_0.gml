// --- Lógica de Estado: Estamos Atacando? ---
// alarm[1] é o nosso timer de "duração da animação de ataque"
var _is_attacking = (alarm[1] > 0);

// --- Check for Death ---
if (hp <= 0)
{
    show_debug_message("PLAYER MORREU! Restarting game...");
    
	// reset spawner
    var spawner = instance_find(obj_spawner, 0);
    if (spawner != noone) {
        with (spawner) {
            // Complete reset spawner state
            room_enemies = [];
            room_bosses = [];
            current_enemy_index = 0;
            current_boss_index = 0;
            current_spawns = 0;
            spawns_initiated = 0;
            spawned_enemies = [];
            is_active = false;
            spawn_timer = 0;
            show_debug_message("SPAWNER RESET COMPLETE");
        }
    }
	
    // Reset player state
    hp = 5;
    hp_max = 5;
    invincible = false;
    image_alpha = 1.0;
    
    // Reset position
    x = 1220;
    y = 830;
    velocidade_x = 0;
    velocidade_y = 0;
    
    // Reset progression but KEEP THE QUEUE STRUCTURE
    global.current_level = 0;
    
    // Reset game state but preserve queue
    if (instance_exists(obj_control)) {
        with (obj_control) {
            game_started = false;
            global.game_started = false;
            
            // Reinitialize the queue for a fresh start
            initialize_room_system();
            
			obj_spawner.is_active = true;
            // Go to intro room
            var intro_room = queue_peek(global.room_queue);
            room_goto(intro_room);
        }
    }
    
    exit;
}
/*if (hp <= 0)
{
    show_debug_message("PLAYER MORREU! Resetando estado do jogo...");
    
    // Reset all game progression
    reset_game_state();
    
    // Reset player state immediately
    hp = 3;
    hp_max = 3;
    invincible = false;
    image_alpha = 1.0;
    
    // Reset position (important!)
    x = room_width / 2;
    y = room_height / 2;
    velocidade_x = 0;
    velocidade_y = 0;
    
    // Go to first room
    room_goto(0);
    
    exit;
}*/

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
	
	//Collision with obj_wall_collision
	if place_meeting(x+velocidade_x, y, obj_wall_collision) == true
	{
		velocidade_x=0;
	}
	if place_meeting(x, y+velocidade_y, obj_wall_collision) == true
	{
		velocidade_y=0;
	}

}

// --- 2. PROCESSAR ATAQUE ---
if (keyboard_check_pressed(vk_space) && !_is_attacking) {
    // --- Começa o Ataque ---
    _is_attacking = true;
    velocidade_x = 0;
    velocidade_y = 0;
    alarm[1] = room_speed * 0.3;
    
    // Attack animation
    sprite_index = spr_jogador_attack_down;
    image_index = 0;
    image_speed = 1;
    
    var _attack_range = 30;
    var _limit_attack_range = 60;
    
    if (instance_exists(obj_boss_19)) {
        var _dist = point_distance(x, y, obj_boss_19.x, obj_boss_19.y);
        
        if (_dist < _attack_range) {
            if (obj_boss_19.state != BOSS_STATE.HIT && obj_boss_19.state != BOSS_STATE.DEAD) {
                obj_boss_19.hp -= short_damage;
                obj_boss_19.state = BOSS_STATE.HIT;
                obj_boss_19.image_alpha = 0.5;
                obj_boss_19.alarm[2] = room_speed * 0.2;
                show_debug_message("Boss levou dano! HP: " + string(obj_boss_19.hp));
            }
        } else if (_dist < _limit_attack_range) {
            if (obj_boss_19.state != BOSS_STATE.HIT && obj_boss_19.state != BOSS_STATE.DEAD) {
                obj_boss_19.hp -= long_damage;
                obj_boss_19.state = BOSS_STATE.HIT;
                obj_boss_19.image_alpha = 0.5;
                obj_boss_19.alarm[2] = room_speed * 0.2;
                show_debug_message("Boss levou dano! HP: " + string(obj_boss_19.hp));
            }
        }
    }
    
    
    var enemy_count = instance_number(obj_enemy_test);
    for (var i = 0; i < enemy_count; i++) {
        var enemy = instance_find(obj_enemy_test, i);
        if (instance_exists(enemy)) {
            var dist = point_distance(x, y, enemy.x, enemy.y);
            
            if (dist < _limit_attack_range) {
                var damage_amount = long_damage;
                if (dist < _attack_range) {
                    damage_amount = short_damage;
                }
                
                if (variable_instance_exists(enemy, "take_damage")) {
                    enemy.take_damage(damage_amount);
                    show_debug_message("Enemy hit! Distance: " + string(dist) + ", HP: " + string(enemy.hp));
                }
            }
        }
    }
	
	var enemy_count1 = instance_number(obj_inimigo_0);
    for (var i = 0; i < enemy_count1; i++) {
        var enemy = instance_find(obj_inimigo_0, i);
        if (instance_exists(enemy)) {
            var dist = point_distance(x, y, enemy.x, enemy.y);
            
            if (dist < _limit_attack_range) {
                var damage_amount = long_damage;
                if (dist < _attack_range) {
                    damage_amount = short_damage;
                }
                
                if (variable_instance_exists(enemy, "take_damage")) {
                    enemy.take_damage(damage_amount);
                    show_debug_message("Enemy hit! Distance: " + string(dist) + ", HP: " + string(enemy.hp));
                }
            }
        }
    }
	
	if (instance_exists(obj_boss_0)) {
        var _dist = point_distance(x, y, obj_boss_0.x, obj_boss_0.y);
        
        if (_dist < _attack_range) {
            if (obj_boss_0.state != MOON_STATE.HIT && obj_boss_0.state != MOON_STATE.DEAD) {
                obj_boss_0.hp -= short_damage;
                obj_boss_0.state = MOON_STATE.HIT;
                obj_boss_0.image_alpha = 0.5;
                obj_boss_0.alarm[2] = room_speed * 0.2;
                show_debug_message("Boss levou dano! HP: " + string(obj_boss_0.hp));
            }
        } else if (_dist < _limit_attack_range) {
            if (obj_boss_0.state != MOON_STATE.HIT && obj_boss_0.state != MOON_STATE.DEAD) {
                obj_boss_0.hp -= long_damage;
                obj_boss_0.state = MOON_STATE.HIT;
                obj_boss_0.image_alpha = 0.5;
                obj_boss_0.alarm[2] = room_speed * 0.2;
                show_debug_message("Boss levou dano! HP: " + string(obj_boss_0.hp));
            }
        }
    }
	
	if (instance_exists(obj_boss_1)) {
        var _dist = point_distance(x, y, obj_boss_1.x, obj_boss_1.y);
        
        if (_dist < _attack_range) {
            if (obj_boss_1.state != HANG_STATE.HIT && obj_boss_1.state != HANG_STATE.DEAD) {
                obj_boss_1.hp -= short_damage;
                obj_boss_1.state = HANG_STATE.HIT;
                obj_boss_1.image_alpha = 0.5;
                obj_boss_1.alarm[2] = room_speed * 0.2;
                show_debug_message("Boss levou dano! HP: " + string(obj_boss_1.hp));
            }
        } else if (_dist < _limit_attack_range) {
            if (obj_boss_1.state != HANG_STATE.HIT && obj_boss_1.state != HANG_STATE.DEAD) {
                obj_boss_1.hp -= long_damage;
                obj_boss_1.state = HANG_STATE.HIT;
                obj_boss_1.image_alpha = 0.5;
                obj_boss_1.alarm[2] = room_speed * 0.2;
                show_debug_message("Boss levou dano! HP: " + string(obj_boss_1.hp));
            }
        }
    }
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

// Debug health (remove this after it's working)
if (keyboard_check_pressed(ord("I"))) {
    show_debug_message("HP: " + string(hp) + ", Invincible: " + string(invincible));
}

// DEBUG
if (hp < 0) {
    show_debug_message("CRITICAL: HP is negative! HP: " + string(hp) + ", Invincible: " + string(invincible));
}