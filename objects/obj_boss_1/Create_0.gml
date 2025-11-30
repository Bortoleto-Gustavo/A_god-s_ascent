// --- Variáveis de Vida ---
hp = 20;
hp_max = 20;

// --- Variáveis de Perseguição ---
chase_speed = 0;  // Velocidade de perseguição (ajuste este valor)
chase_range = 1600;  // A distância máxima que o boss "enxerga" o player
min_distance = 50; // A distância mínima que o boss tenta manter do player
collision_radius = 40;

// --- Máquina de Estados (enum) ---
// Define os "modos" que o boss pode ter
enum HANG_STATE {
    CHASE,      // Perseguindo (ou parado se estiver longe)
    ATTACKING,  // Atacando
    HIT,        // Levando dano
    DEAD        // Morrendo
}
// --- Sprites Direcionais do Boss ---
// (Vamos usar um array simples. 0=Direita, 1=Esquerda, 2=Cima, 3=Baixo)
sprite_movimento = [
    spr_enforcado,  // Índice 0
    spr_enforcado,   // Índice 1
    spr_enforcado,     // Índice 2
    spr_enforcado    // Índice 3
];
// O estado inicial do boss é perseguir
state = HANG_STATE.CHASE;

// --- Timers de Ataque ---
// Define o primeiro ataque para daqui a 5 segundos (intervalo longo)
alarm[0] = room_speed * 5; 

show_debug_message("Boss CRIADO. Estado: CHASE. Primeiro ataque em 5 seg.");
// --- Animação dos Corações do Boss ---
heart_anim_frame = 0;
heart_anim_speed = 0.1; // (Use a mesma velocidade do player)

function take_damage(amount) {
    if (state == HANG_STATE.HIT || state == HANG_STATE.DEAD) return false;
    
    hp -= amount;
    state = HANG_STATE.HIT;
    image_alpha = 0.5;
    
    // Set hit recovery timer
    if (variable_instance_exists(id, "alarm")) {
        alarm[2] = room_speed * 0.2;
    }
    
    show_debug_message("BOSS took " + string(amount) + " damage! HP: " + string(hp));
    
    if (hp <= 0) {
        state = HANG_STATE.DEAD;
    }
    
    return true;
}