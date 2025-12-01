// Só executa se AINDA NÃO acertamos nada (para não dar dano 2x)
if (hit_confirmed == false)
{
    // --- LÓGICA DE DANO (Igual antes) ---
    if (variable_instance_exists(other, "take_damage")) {
        other.take_damage(damage);
    } else {
        if (other.state != BOSS_STATE_SUN.HIT && other.state != BOSS_STATE_SUN.DEAD) {
            other.hp -= damage;
            other.state = BOSS_STATE_SUN.HIT;
            other.image_alpha = 0.5;
            other.alarm[2] = room_speed * 0.2;
        }
    }

    // --- AQUI ESTÁ A MUDANÇA VISUAL ---
    
    // 1. Marcar que acertamos (para não dar dano de novo no próximo frame)
    hit_confirmed = true;
    
    // 2. Parar o movimento do poder (para parecer que bateu)
    speed = 0;
    
    // 3. Efeito visual: Aumentar um pouco o tamanho (opcional, fica parecendo uma explosãozinha)
    image_xscale = 1.5;
    image_yscale = 1.5;
    
    // 4. NÃO DESTRUIR AGORA!
    // Em vez de instance_destroy(), ativamos o alarme para destruir daqui a 5 frames
    alarm[1] = 5; 
}