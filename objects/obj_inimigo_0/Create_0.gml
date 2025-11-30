// --- Variáveis de Vida ---
hp = 6;
hp_max = 6;
chase_speed = 3;
damage_cooldown = 0.5;

// State machine
enum ENEMY0_STATE {
    CHASE,      // Perseguindo (ou parado se estiver longe)
    ATTACKING,  // Atacando
    HIT,        // Levando dano
    DEAD        // Morrendo
}
state = ENEMY0_STATE.CHASE;

// Touch damage to player
touch_damage = 0.5;

show_debug_message("Enemy created with HP: " + string(hp));

// --- Timers de Ataque ---
// Define o primeiro ataque para daqui a 5 segundos
alarm[0] = room_speed * 2; 

// --- Animação dos Corações do Boss ---
heart_anim_frame = 0;
heart_anim_speed = 0.1;

function take_damage(amount) {
    if (state == ENEMY0_STATE.HIT || state == ENEMY0_STATE.DEAD) return false;
    
    hp -= amount;
    state = ENEMY0_STATE.HIT;
    image_alpha = 0.5;
    
    // Set hit recovery timer
    if (variable_instance_exists(id, "alarm")) {
        alarm[2] = room_speed * 0.2;
    }
    
    show_debug_message("BOSS took " + string(amount) + " damage! HP: " + string(hp));
    
    if (hp <= 0) {
        state = ENEMY0_STATE.DEAD;
    }
    
    return true;
}