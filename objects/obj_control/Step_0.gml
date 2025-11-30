show_debug_message("Step running - game_started: " + string(game_started));

if (!game_started && !queue_is_empty(global.room_queue)) {
    // We're in intro room, wait for player input to start
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        show_debug_message("=== GAME STARTING FROM INTRO ===");
        game_started = true;
        global.game_started = true;
        current_room_index = 0;
        
        // Remove intro room from queue (we're already in it)
        var intro_room = queue_dequeue(global.room_queue);
        show_debug_message("Intro room completed, moving to: " + room_get_name(queue_peek(global.room_queue)));
        
        // Go to first game room
        var first_game_room = queue_peek(global.room_queue);
        room_goto(first_game_room);
    }
}

// Simple multiplier calculation when all enemies are defeated
if (game_started && is_game_room()) {
    var enemies_defeated = are_all_enemies_defeated();
    
    if (enemies_defeated) {
        show_debug_message("=== ENEMIES DEFEATED - SETTING MULTIPLIER ===");
        global.last_room_multiplier = 1.2; // Simple progressive multiplier
        show_debug_message("Multiplier for next room: " + string(global.last_room_multiplier) + "x");
    }
}

/* DEBUG
// Manual multiplier test with "M" key
if (keyboard_check_pressed(ord("M"))) {
    show_debug_message("MANUAL MULTIPLIER TEST");
    
    // Cycle through different multipliers
    if (!variable_global_exists("test_multiplier_index")) {
        global.test_multiplier_index = 0;
    }
    
    var test_multipliers = [1.0, 1.2, 1.5, 1.8, 2.0];
    global.last_room_multiplier = test_multipliers[global.test_multiplier_index];
    global.test_multiplier_index = (global.test_multiplier_index + 1) % array_length(test_multipliers);
    
    show_debug_message("Set multiplier to: " + string(global.last_room_multiplier) + "x");
    
    // Reconfigure current room to apply the multiplier
    global.configure_room_by_name();
}
*/
show_debug_message("Step running - game_started: " + string(game_started));

// Safety check - ensure queue is valid (only once)
if (!variable_global_exists("queue_initialized") || !global.queue_initialized) {
    show_debug_message("First-time queue initialization...");
    initialize_room_system();
    global.queue_initialized = true;
}


// Handle game start from intro room
if (!game_started && !queue_is_empty(global.room_queue)) {
    // We're in intro room, wait for player input to start
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        show_debug_message("=== GAME STARTING FROM INTRO ===");
        game_started = true;
        global.game_started = true;
        current_room_index = 0;
        
        // Remove intro room from queue (we're already in it)
        var intro_room = queue_dequeue(global.room_queue);
        show_debug_message("Intro room completed, moving to: " + room_get_name(queue_peek(global.room_queue)));
        
        // Go to first game room
        var first_game_room = queue_peek(global.room_queue);
        room_goto(first_game_room);
    }
}

// Time-based multiplier calculation when all enemies are defeated
if (game_started && is_game_room() && room_timer_active && !room_completed) {
    var enemies_defeated = are_all_enemies_defeated();
    
    if (enemies_defeated) {
        show_debug_message("===  ENEMIES DEFEATED - CALCULATING TIME-BASED MULTIPLIER ===");
        
        // Calculate completion time
        var completion_time = (current_time - room_start_time) / 1000;
        room_timer_active = false; // Stop the timer
        room_completed = true;
        
        show_debug_message("Completion time: " + string(completion_time) + "s");
        
        // Set multiplier based on completion time
        var new_multiplier = 1.0;
        if (completion_time < 5) {         // Under 5 seconds = 2.0x
            new_multiplier = 2.0;
        } else if (completion_time < 10) { // Under 10 seconds = 1.8x
            new_multiplier = 1.8;
        } else if (completion_time < 15) { // Under 15 seconds = 1.5x
            new_multiplier = 1.5;
        } else if (completion_time < 20) { // Under 20 seconds = 1.2x
            new_multiplier = 1.2;
        }
        // Over 20 seconds stays at 1.0x
        
        global.last_room_multiplier = new_multiplier;
        global.last_room_time = completion_time;
        
        show_debug_message("Multiplier for next room: " + string(new_multiplier) + "x");
        
        // Force reconfigure to see the multiplier effect
        global.configure_room_by_name();
    }
}

// Debug: Check why multiplier isn't calculating
if (game_started && is_game_room() && room_timer_active && current_time % 60 == 0) {
    var enemies_defeated = are_all_enemies_defeated();
    var current_time_elapsed = (current_time - room_start_time) / 1000;
    
    show_debug_message("=== MULTIPLIER DEBUG ===");
    show_debug_message("Timer active: " + string(room_timer_active));
    show_debug_message("Room completed: " + string(room_completed));
    show_debug_message("Enemies defeated: " + string(enemies_defeated));
    show_debug_message("Current time: " + string(current_time_elapsed) + "s");
    show_debug_message("Should calculate: " + string(enemies_defeated && !room_completed));
}

// Debug reset state
if (current_time % 60 == 0) {
    show_debug_message("RESET DEBUG - Game started: " + string(game_started) + ", Room: " + room_get_name(room));
}

// Debug room transitions
/*if (game_started && current_time % 30 == 0) { // Show every half second
    var spawner = instance_find(obj_spawner, 0);
    show_debug_message("=== ROOM DEBUG ===");
    show_debug_message("Current room: " + room_get_name(room));
    show_debug_message("Game started: " + string(game_started));
    show_debug_message("Spawner exists: " + string(spawner != noone));
    if (spawner != noone) {
        show_debug_message("Spawner active: " + string(spawner.is_active));
        show_debug_message("Spawner max: " + string(spawner.max_spawns));
        show_debug_message("Room enemies: " + string(array_length(spawner.room_enemies)));
    }
}
/* DEBUG
// Manual multiplier test with "M" key
if (keyboard_check_pressed(ord("M"))) {
    show_debug_message("MANUAL MULTIPLIER TEST");
    
    // Cycle through different multipliers
    if (!variable_global_exists("test_multiplier_index")) {
        global.test_multiplier_index = 0;
    }
    
    var test_multipliers = [1.0, 1.2, 1.5, 1.8, 2.0];
    global.last_room_multiplier = test_multipliers[global.test_multiplier_index];
    global.test_multiplier_index = (global.test_multiplier_index + 1) % array_length(test_multipliers);
    
    show_debug_message("Set multiplier to: " + string(global.last_room_multiplier) + "x");
    
    // Reconfigure current room to apply the multiplier
    global.configure_room_by_name();
}
*/