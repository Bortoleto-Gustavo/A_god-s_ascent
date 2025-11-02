// --- Variáveis de Vida ---
//MODIFICAR VIDA DE ACORDO COM O BOSS 
hp = 10;
hp_max = 10;

// --- Variáveis de Perseguição ---
chase_speed = 1;  // Velocidade de perseguição (ajuste este valor)
chase_range = 250;  // A distância máxima que o boss "enxerga" o player
min_distance = 50; // A distância mínima que o boss tenta manter do player

// --- Máquina de Estados (enum) ---
// Define os "modos" que o boss pode ter

//MODIFICAR O NOME DE CADA BOSS
enum BOSS_STATE_MOON {
    CHASE,      // Perseguindo (ou parado se estiver longe)
    ATTACKING,  // Atacando
    HIT,        // Levando dano
    DEAD        // Morrendo
}
// --- Sprites Direcionais do Boss ---
// (Vamos usar um array simples. 0=Direita, 1=Esquerda, 2=Cima, 3=Baixo)
// !!! TROQUE PELOS NOMES REAIS DOS SEUS SPRITES DO BOSS !!!


//COLOCAR A IMAGEM DE MOVIMENTO DE ACORDO COM O NOME DO SEU BOSS
sprite_movimento = [
    spr_moon_right,  // Índice 0
    spr_moon_left,   // Índice 1
    spr_moon_up,     // Índice 2
    spr_moon_down    // Índice 3
];


// O estado inicial do boss é perseguir
//MODIFICAR O STATE DE ACORDO COM O NOME DO SEU BOSS
state = BOSS_STATE_MOON.CHASE;

// --- Timers de Ataque ---
// Define o primeiro ataque para daqui a 5 segundos (intervalo longo)
alarm[0] = room_speed * 5; 

show_debug_message("Boss CRIADO. Estado: CHASE. Primeiro ataque em 5 seg.");
// --- Animação dos Corações do Boss ---
heart_anim_frame = 0;
heart_anim_speed = 0.1; // (Use a mesma velocidade do player)