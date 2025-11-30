// Room Start Event
show_debug_message("Room Start - Checking respawn...");

// Check if we need to respawn (player died in previous room)
if (hp <= 0) {
    show_debug_message("Respawning player in new room...");
    
    // Reset player to full health
    hp = 5;
    hp_max = 5;
    invincible = false;
    image_alpha = 1.0;
    
    // Reset position to room center
    x = 1220;
    y = 830;
    velocidade_x = 0;
    velocidade_y = 0;
    
    show_debug_message(" Player respawned with HP: " + string(hp));
}