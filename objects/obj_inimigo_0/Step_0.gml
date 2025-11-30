if (damage_cooldown > 0) {
    damage_cooldown--;
}

// Handle death
if (hp <= 0 && state != ENEMY0_STATE.DEAD) {
    state = ENEMY0_STATE.DEAD;
    instance_destroy();
    exit;
}

// Handle hit state
if (state == ENEMY0_STATE.HIT) {
    // Flash effect
    image_alpha = 0.5 + 0.5 * sin(current_time * 0.01);
    
    if (damage_cooldown <= 0) {
        state = ENEMY0_STATE.CHASE;
        image_alpha = 1.0;
    }
    exit;
}

// Chase player
if (state == ENEMY0_STATE.CHASE && instance_exists(obj_player)) {
    var dir = point_direction(x, y, obj_player.x, obj_player.y);
    var move_x = lengthdir_x(chase_speed, dir);
    var move_y = lengthdir_y(chase_speed, dir);
    
    // Collision with obj_wall_collision - FIXED VERSION
    if (!place_meeting(x + move_x, y, obj_wall_collision)) {
        x += move_x;
    }
    
    if (!place_meeting(x, y + move_y, obj_wall_collision)) {
        y += move_y;
    }
}

// Touch damage to player (similar to boss logic)
if (instance_exists(obj_player) && obj_player.invincible == false) {
    var _damage_radius = 8;
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (_dist < _damage_radius) {
        obj_player.hp -= touch_damage;
        obj_player.invincible = true;
        
        show_debug_message("Player took damage from enemy! HP: " + string(obj_player.hp));
    }
}