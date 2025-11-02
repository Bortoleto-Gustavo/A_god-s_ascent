show_debug_message("Boss ATACANDO! (Alarm 0 disparou) - 1 RAIO");

// --- HORA DE ATACAR! ---
// Só atacar se o player existir
if (!instance_exists(obj_player)) {
    alarm[0] = room_speed * 5; // Tenta de novo em 5 seg
    exit; // Sai do evento
}

// Mudar para o estado de ataque
//MODIFICAR STATE DE ACORDO COM SEU BOSS
state = BOSS_STATE_MOON.ATTACKING;

// --- Lógica do Ataque (1 Raio) ---
var _ray_speed = 3; // Velocidade do raio (ajuste!)

// Pegar a posição do player
var _target_x = obj_player.x;
var _target_y = obj_player.y;

// 1. Criar o objeto do raio no centro (x, y) do boss
// !!! TROQUE 'obj_boss_ray' PELO NOME DO SEU OBJETO DE RAIO !!!
//OBJ_BOSS_RAY é o objeto que seu boss irá lancar para causar dano no jogador(se seu boss faz isso, se não, retire)
var _ray = instance_create_layer(x, y, "Instances", obj_boss_ray);
    
// 2. Mirar o raio na posição salva do player
with (_ray) {
    speed = _ray_speed;
    direction = point_direction(x, y, _target_x, _target_y);
    
    // Gira o sprite do raio para apontar na direção
    image_angle = direction;
}
// -----------------------------------------------------------------

// Define quanto tempo o boss fica "preso" na animação de ataque
// (1 segundo. Você pode diminuir, ex: room_speed * 0.5)
alarm[1] = room_speed * 1;

// REINICIA o timer principal para o *próximo* ataque (intervalo longo)
alarm[0] = room_speed * 5;