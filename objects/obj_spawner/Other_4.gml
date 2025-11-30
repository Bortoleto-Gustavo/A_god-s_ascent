show_debug_message("SPAWNER ENTERED ROOM: " + room_get_name(room));

// SPECIAL CASE: If returning to intro room after death, force full reset
if (room_get_name(room) == "Intro_room") {
    show_debug_message("SPAWNER DETECTED INTRO ROOM - FULL RESET");
    room_enemies = [];
    room_bosses = [];
    current_enemy_index = 0;
    current_boss_index = 0;
    current_spawns = 0;
    spawns_initiated = 0;
    spawned_enemies = [];
    is_active = false;
    spawn_timer = 0;
	
	// Reset multiplier for new game
    if (variable_global_exists("last_room_multiplier")) {
        global.last_room_multiplier = 1.0;
    }
}

// Only configure if we're in a game room and game is started
var controller = instance_find(obj_control, 0);
if (controller != noone && controller.game_started) {
    show_debug_message("Spawner configuring for game room...");
    
    // Reset spawner state
    room_enemies = [];
    room_bosses = [];
    current_enemy_index = 0;
    current_boss_index = 0;
    current_spawns = 0;
    spawns_initiated = 0; // ← ADD THIS LINE
    spawned_enemies = [];
    is_active = false;
    
    // Call configuration
    global.configure_room_by_name();
    
    // Check if this is a game room (not intro)
    var room_name = room_get_name(room);
	if (room_name != "intro_room" && array_length(room_bosses) > 0) {
	    is_active = true;
	    show_debug_message("BOSS ROOM: Spawner activated for boss encounter");
	} else if (room_name != "intro_room" && array_length(room_enemies) > 0) {
	    is_active = true;
	    show_debug_message("Spawner activated for regular enemy room");
	}
	
} else {
    show_debug_message("Spawner inactive - intro room or game not started");
    is_active = false;
}