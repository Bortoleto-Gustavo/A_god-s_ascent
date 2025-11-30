// --- Variáveis de Vida ---
hp = 3;
hp_max = 3;
chase_speed = 2;
damage_cooldown = 1;
collision_radius = 20;

// State machine
enum ENEMY_STATE {
    CHASE,
    HIT, 
    DEAD,
	ATTACKING
}
state = ENEMY_STATE.CHASE;

// Touch damage to player
touch_damage = 0.5;

show_debug_message("Enemy created with HP: " + string(hp));

// --- Timers de Ataque ---
// Define o primeiro ataque para daqui a 5 segundos
alarm[0] = room_speed * 5; 

// --- Animação dos Corações do Boss ---
heart_anim_frame = 0;
heart_anim_speed = 0.1;

function take_damage(amount) {
    if (state == ENEMY_STATE.HIT || state == ENEMY_STATE.DEAD) return false;
    
    hp -= amount;
    state = ENEMY_STATE.HIT;
    image_alpha = 0.5;
    
    // Set hit recovery timer
    if (variable_instance_exists(id, "alarm")) {
        alarm[2] = room_speed * 0.2;
    }
    
    show_debug_message("BOSS took " + string(amount) + " damage! HP: " + string(hp));
    
    if (hp <= 0) {
        state = ENEMY_STATE.DEAD;
    }
    
    return true;
}