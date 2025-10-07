show_debug_message("Step running - game_started: " + string(game_started));

if (!game_started && !queue_is_empty(room_queue)) {
    show_debug_message("Starting first room...");
    start_next_room();
    game_started = true;
}

// Spawner controls
if (keyboard_check_pressed(ord("S"))) {
    show_debug_message("=== S KEY PRESSED ===");
    
	 with (obj_spawner) {
        show_debug_message("Direct spawner access: " + string(id));
        is_active = !is_active;
        show_debug_message("Toggled to: " + string(is_active));
    }
	
    var spawner = instance_find(obj_spawner, 0);
    if (spawner != noone) {
        show_debug_message("Spawner found: " + string(spawner));
        show_debug_message("Current state: " + string(spawner.is_active));
        
        spawner.is_active = !spawner.is_active;
        show_debug_message("New state: " + string(spawner.is_active));
        show_debug_message("Spawner " + (spawner.is_active ? "ACTIVATED" : "DEACTIVATED"));
    } else {
        show_debug_message("ERROR: No spawner found!");
        // List all spawners
        var all_spawners = instance_find(obj_spawner, 0);
        var count = 0;
        while (all_spawners != noone) {
            show_debug_message("Spawner " + string(count) + ": " + string(all_spawners));
            all_spawners = instance_find(obj_spawner, count);
            count++;
        }
        show_debug_message("Total spawners: " + string(instance_number(obj_spawner)));
    }
}

if (keyboard_check_pressed(ord("C"))) {
    clear_all_enemies();
    show_debug_message("Manually cleared all enemies");
}

if (keyboard_check_pressed(ord("D"))) {
    damage_random_enemy();
}

if (keyboard_check_pressed(ord("B"))) {
    spawn_boss();
}

// MANUAL ROOM COMPLETION - Press SPACE to complete room
if (keyboard_check_pressed(vk_space)) {
    show_debug_message("=== MANUAL ROOM COMPLETION ===");
    if (game_started && room_queue.room_start_time > 0) {
        // Stop spawner first
        var spawner = instance_find(obj_spawner, 0);
        if (spawner != noone) {
            spawner.is_active = false;
        }
        // Clear any remaining enemies
        clear_all_enemies();
        // Complete the room
        end_current_room();
    }
}

// Manual spawn test - Press 1 to spawn one enemy
if (keyboard_check_pressed(ord("1"))) {
    show_debug_message("=== MANUAL SPAWN TEST ===");
    var spawner = instance_find(obj_spawner, 0);
    if (spawner != noone) {
        spawn_enemy();
    } else {
        show_debug_message("No spawner for manual test");
    }
}

// Auto room completion - Only if spawner is inactive and no enemies
if (game_started && are_all_enemies_defeated() && room_queue.room_start_time > 0) {
    show_debug_message("Auto: Room cleared! Moving to next...");
    end_current_room();
}