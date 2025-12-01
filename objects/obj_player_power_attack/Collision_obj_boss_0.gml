// Verifica estado (Usando MOON_STATE conforme seu código anterior)
if (other.state != MOON_STATE.HIT && other.state != MOON_STATE.DEAD)
{
    other.hp -= damage;
    other.state = MOON_STATE.HIT;
    other.image_alpha = 0.5;
    other.alarm[2] = room_speed * 0.2;

    show_debug_message("Poder acertou Moon Boss! HP: " + string(other.hp));
    instance_destroy();
}