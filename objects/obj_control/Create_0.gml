current_room_index = -1;
game_started = false;
room_start_delay = 0;
room_completed = false;
room_start_time = 0;
room_timer_active = false;


function room_get_current_time() {
    return (current_time - room_start_time) / 1000; // Convert to seconds
}


// Initialize global multiplier
if (!variable_global_exists("game_started")) {
    global.game_started = false;
    show_debug_message("INITIALIZED global.game_started = false");
}

if (!variable_global_exists("last_room_multiplier")) {
    global.last_room_multiplier = 1.0;
    show_debug_message("INITIALIZED global.last_room_multiplier = 1.0");
}

if (!variable_global_exists("last_room_time")) {
    global.last_room_time = 0;
    show_debug_message("INITIALIZED global.last_room_time = 0");
}

// Initialize room queue if it doesn't exist
initialize_room_system();
/*
if (!variable_global_exists("room_queue")) {
    global.room_queue = queue_create();
    
    // Add intro room first
    var intro_room = asset_get_index("intro_room");
    if (room_exists(intro_room)) {
        queue_enqueue(global.room_queue, intro_room);
        show_debug_message("Added intro_room to queue");
    }
    
    // Then add the andar rooms
    var total_levels = 5;
    for (var i = 0; i < total_levels; i++) {
        var name = "andar_" + string(i);
        var rm = asset_get_index(name);
    
        if (room_exists(rm)) {
            queue_enqueue(global.room_queue, rm);
        } else {
            show_debug_message("Missing room: " + name);
        }
    }
    
    show_debug_message("Room queue created with " + string(queue_size(global.room_queue)) + " rooms");
    show_debug_message("First room: " + room_get_name(queue_peek(global.room_queue)));
}*/

// === Initialize globals once ===
if (!variable_global_exists("current_level")) {
    global.current_level  = 0;
    global.current_class  = "Fire"; // or set to "" if player chooses later
    global.current_choices = [];
    global.player_stats   = {};
}

// === Define power-ups ===
if (!variable_global_exists("powerups")) {
    global.powerups = ds_map_create();
    global.powerups[? "fire"]  = ["Fire 1", "Fire 2", "Fire 3", "Fire 4", "Fire 5", "Fire 6", "Fire 7", "Fire 8", "Fire 9", "Fire 10", "Fire 11", "Fire 12", "Fire 13"];
    global.powerups[? "water"] = ["Water 1", "Water 2", "Water 3", "Water 4", "Water 5", "Water 6", "Water 7", "Water 8", "Water 9", "Water 10", "Water 11", "Water 12", "Water 13"];
    global.powerups[? "air"]   = ["Air 1", "Air 2", "Air 3", "Air 4", "Air 5", "Air 6", "Air 7", "Air 8", "Air 9", "Air 10", "Air 11", "Air 12", "Air 13"];
}

global.exclusive_indices = [6, 11, 12, 13];

//===================================== Debug info ==============================================
show_debug_message("obj_control CREATED at position: " + string(x) + "," + string(y));
show_debug_message("Room: " + room_get_name(room));

show_debug_message("=== ROOM VERIFICATION ===");
show_debug_message("Room name: " + room_get_name(room));
show_debug_message("Room size: " + string(room_width) + "x" + string(room_height));
show_debug_message("My position: " + string(x) + "," + string(y));
background_color = c_gray;

show_debug_message("Game initialized with " + string(queue_size(global.room_queue)) + " rooms.");

function is_game_room() {
    var room_name = room_get_name(room);
    return string_pos("andar_", room_name) > 0;
}

function go_to_next_level() {
    if (!variable_global_exists("room_queue") || global.room_queue == noone) {
        show_debug_message("ERROR: global.room_queue not initialized!");
        return;
    }

    // If queue is empty, finish the run
    if (queue_is_empty(global.room_queue)) {
        show_debug_message("All levels completed!");
        return;
    }

    // Get next room from the queue
    var next_room = queue_dequeue(global.room_queue);

    // Verify the room actually exists
    if (!room_exists(next_room)) {
        show_debug_message("Invalid room asset in queue — skipping.");
        return;
    }

    // Save progress (optional)
    global.current_level += 1;

    show_debug_message("Moving to room index: " + string(next_room));
    room_goto(next_room);
}

// Reset the game when dead
function reset_game_state() {
    show_debug_message("Reset COMPLETO do jogo...");
    
    // List all possible global variables that track progression
    var global_vars = [
        "current_room_level", "rooms_completed", "room_progression",
        "boss_defeated", "teleporter_active", "unlocked_rooms",
        "current_level", "game_progress", "player_level",
        "completed_rooms", "available_rooms", "room_access"
    ];
    
    for (var i = 0; i < array_length(global_vars); i++) {
        if (variable_global_exists(global_vars[i])) {
            global[$ global_vars[i]] = 0; // or false, depending on the variable
            show_debug_message("Reset: " + global_vars[i]);
        }
    }
    
    // Also destroy any persistent objects that shouldn't carry over
    var persistent_objects = [obj_boss_19, obj_enemy_test]; // Add your objects here
    for (var i = 0; i < array_length(persistent_objects); i++) {
        if (instance_exists(persistent_objects[i])) {
            instance_destroy(persistent_objects[i]);
        }
    }
}

/// @function complete_reset()
function complete_reset() {
    show_debug_message("=== COMPLETING RESET - GOING TO INTRO ===");
    
    // Recreate the room queue
    if (variable_global_exists("room_queue")) {
        queue_destroy(global.room_queue);
    }
    global.room_queue = queue_create();
    
    // Add intro room first
    var intro_room = asset_get_index("intro_room");
    if (room_exists(intro_room)) {
        queue_enqueue(global.room_queue, intro_room);
    }
    
    // Then add the andar rooms
    var total_levels = 22;
    for (var i = 0; i < total_levels; i++) {
        var name = "andar_" + string(i);
        var rm = asset_get_index(name);
        if (room_exists(rm)) {
            queue_enqueue(global.room_queue, rm);
        }
    }
    
    // Go to intro room
    room_goto(intro_room);
}

// Reset rooms

