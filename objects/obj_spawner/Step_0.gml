if (is_active && current_spawns < max_spawns && spawns_initiated < max_spawns) {
    spawn_timer++;
    if (spawn_timer >= spawn_interval) {
        spawn_timer = 0;
        
        // Check if we should spawn a boss or regular enemy
        if (array_length(room_bosses) > 0) {
            // Spawn boss (only once)
            var boss = spawn_boss();
            if (boss != noone) {
                spawns_initiated++; // Only increment if boss was actually created
                is_active = false; // Stop spawning after boss is created
                show_debug_message("BOSS SPAWNED - Spawner deactivated");
            }
        } else {
            // Spawn regular enemies
            var enemy = spawn_enemy();
            if (enemy != noone) {
                spawns_initiated++; // Only increment if enemy was actually created
            }
        }
    }
}


// Auto-deactivate when we've spawned the initial batch
if (spawns_initiated >= max_spawns) {
    is_active = false;
    show_debug_message("Spawner completed initial spawn batch");
}



// Spawner controls
/*
if (keyboard_check_pressed(ord("S"))) {
    is_active = !is_active;
    show_debug_message("Spawner " + (is_active ? "ACTIVATED" : "DEACTIVATED"));
}

if (keyboard_check_pressed(ord("C"))) {
    clear_all_enemies();
}