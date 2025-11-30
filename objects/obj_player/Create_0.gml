persistent = true;

// Reset player state when entering any room
if (variable_global_exists("just_died") && global.just_died) {
    show_debug_message("eespawmando jogador após morte...");
    
    // COMPLETELY reset player state
    hp = 5;
    hp_max = 5;
    invincible = false;
    image_alpha = 1.0;
    
    // Reset position
    x = room_width / 2;
    y = room_height / 2;
    velocidade_x = 0;
    velocidade_y = 0;
    
    // Clear the death flag
    global.just_died = false;
    
    show_debug_message("Player respawned with HP: " + string(hp));
}

// Make sure we're not invincible when starting
invincible = false;
image_alpha = 1.0;

velocidade_x = 0;//esquerda e direita
velocidade_y = 0;//para cima e para baixo
velocidade_movimento = 1.55;

sprite[Up] = spr_jogador_up;
sprite[Down] = spr_jogador_down;
sprite[Right] = spr_jogador_right;
sprite[Left] =  spr_jogador_left;
sprite[Normal] = spr_jogador;
face = Normal;
	
// --- Variáveis do Jogador ---
hp = 5;
hp_max = 5; // total de corações do player no momento
total_hp_limit = 30; // Máximo de corações que o player pode ter no jogo
potion_regen_rate = 0; // quantos corações aumenta
heal_potions = 0;
vampire_effect = false; // steals life from the enemmy, can be implemented by using the damage caused to calculate the health received
berserk_effect = false; // deals like 45% more damage when with 1,5 hearts i guess
heal_aura = false; // when healing all enemies in the "area_effect_radius" take damage
heal_aura_damage = 1;

shield = 0;
shield_max = 10;
shield_health = 1;
shield_health_max = 20;
explosive_shields = false; //when the player loses all of their shield they cause a area effect damage
reflective_shield = false; //15 seconds of full damage reflection, single use power-up
knockback_shield = false; //single use power-up causes knockback on all enemies inside the "area_effect_radius"
invincible = false; //5 seg de invencibilidade, single use as well babyyyyy

short_damage = 3; // less than 30 pixels distance
long_damage = 2; // more than 30 and less than 60 pixels distance
damage_limit = 10;
crit_chance = 0.2;
crit_damage = 2.0;
combo_damage = false; //se possivel, para cada 6 hits seguidos se o jogador tem esse power-up ele causa um crit_damage
burn_effect = false; //dano de fogo, o inimigo recebe dano a cada segundo por 4 segundos. reset o counter a cada hit do player no inimigo
burn_damage = 0.25;	
slow_effect = false; // ao atingir o inimigo ele fica mais lento, um knock down de 0.4 de velocidade de movimento... acho... sei lá
flash_damage = false; // dano em linha ao invés de individualmente por inimigo, estilo o flash no LOL, mai o meno
insta_kill = false; // mata inimigos de forma instantanea caso recebam dano quando abaixo de 20% de sua vida
tesla_burst = false; // dano de choque em todos os inimigos na "area_effect_radius"
tesla_damage = 1.5; // dano do choque
cooldown = 10; // tempo para carregar cada coisa

area_effect_radius = 150; //raio de 100px para o circulo de dano dos ataques em área

// --- Animação dos Corações ---
heart_anim_frame = 0;
heart_anim_speed = 0.1; // Velocidade da animação (0.1 é lento, 1 é rápido)
