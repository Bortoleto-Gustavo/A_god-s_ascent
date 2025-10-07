// Spawner Step Event
show_debug_message("Spawner Step: active=" + string(is_active) + ", enemies=" + string(current_spawns) + "/" + string(max_spawns));

if (is_active && current_spawns < max_spawns) {
    spawn_timer++;
    if (spawn_timer >= spawn_interval) {
        spawn_timer = 0;
        spawn_enemy();
    }
}

// Spawner controls
if (keyboard_check_pressed(ord("S"))) {
    is_active = !is_active;
    show_debug_message("Spawner " + (is_active ? "ACTIVATED" : "DEACTIVATED"));
}

if (keyboard_check_pressed(ord("C"))) {
    clear_all_enemies();
}

// Auto-deactivate when max reached
if (current_spawns >= max_spawns) {
    is_active = false;
    show_debug_message("Spawner auto-deactivated - max enemies reached");
}