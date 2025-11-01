velocidade_x = 0;//esquerda e direita
velocidade_y = 0;//para cima e para baixo
velocidade_movimento = 0.65;

sprite[Up] = spr_jogador_up;
sprite[Down] = spr_jogador_down;
sprite[Right] = spr_jogador_right;
sprite[Left] =  spr_jogador_left;
sprite[Normal] = spr_jogador;
face = Normal;
	
// --- Variáveis de Vida do Jogador ---

// Esta linha corrige o erro que você está vendo
hp = 3; 
hp_max = 3;

// !! MUITO IMPORTANTE !!
// Adicione esta linha também. O seu código de colisão do boss
// vai tentar usar essa variável logo em seguida, e vai
// dar o *mesmo erro* se ela não existir!
invincible = false;

// --- Animação dos Corações ---
heart_anim_frame = 0;
heart_anim_speed = 0.1; // Velocidade da animação (0.1 é lento, 1 é rápido)
