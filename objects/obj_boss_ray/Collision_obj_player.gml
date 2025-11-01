// --- O JOGADOR LEVA DANO (pelo raio) ---

// 1. Só dar dano se o player NÃO estiver invencível
// (Checamos se ele existe primeiro, por segurança)
if (instance_exists(obj_player) && obj_player.invincible == true) {
    instance_destroy(); // Destruir o raio, mas não dar dano
    exit;
}

// 2. Dar Dano ao Jogador
var _ray_damage = 0.5; // Dano do raio (ajuste)
obj_player.hp -= _ray_damage;

// 3. Ativar a Invencibilidade no Jogador
obj_player.invincible = true;

// 4. !! ATIVAR O ALARME[0] DO PLAYER !!
// (Para ele parar de piscar em 1.5 segundos)
obj_player.alarm[0] = room_speed * 1.5;

show_debug_message("Player levou dano de RAIO! HP: " + string(obj_player.hp));

// 5. Destruir o raio
instance_destroy();