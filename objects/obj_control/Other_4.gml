show_debug_message("SPAWNER ENTERED ROOM: " + room_get_name(room));

// SAFETY: Initialize ALL critical variables
if (!variable_instance_exists(id, "spawn_timer")) spawn_timer = 0;
if (!variable_instance_exists(id, "spawn_interval")) spawn_interval = 45;
if (!variable_instance_exists(id, "max_spawns")) max_spawns = 0;
if (!variable_instance_exists(id, "current_spawns")) current_spawns = 0;
if (!variable_instance_exists(id, "spawns_initiated")) spawns_initiated = 0;
if (!variable_instance_exists(id, "is_active")) is_active = false;
if (!variable_instance_exists(id, "spawned_enemies")) spawned_enemies = [];
if (!variable_instance_exists(id, "room_enemies")) room_enemies = [];
if (!variable_instance_exists(id, "room_bosses")) room_bosses = [];
if (!variable_instance_exists(id, "current_enemy_index")) current_enemy_index = 0;
if (!variable_instance_exists(id, "current_boss_index")) current_boss_index = 0;

// ALWAYS call room configuration
global.configure_room_by_name();

// Check if we should auto-start the game
var controller = instance_find(obj_control, 0);
var room_name = room_get_name(room);

if (controller != noone) {
    // If this is a game room but game hasn't started, auto-start it
    if (string_pos("andar_", room_name) > 0 && !controller.game_started) {
        show_debug_message("🎮 AUTO-STARTING GAME FROM SPAWNER");
        controller.game_started = true;
        global.game_started = true;
        controller.current_room_index = 0;
        //controller.start_room_timer(global.room_queue);
    }
    
    // Activate spawner if game is started and this is a game room
    if (controller.game_started && room_name != "intro_room" && max_spawns > 0) {
        is_active = true;
        spawns_initiated = 0;
        current_spawns = 0;
        spawned_enemies = [];
        show_debug_message(" Spawner AUTO-ACTIVATED for: " + room_name);
        show_debug_message("Ready to spawn: " + string(max_spawns) + " enemies");
    } else {
        is_active = false;
        show_debug_message(" Spawner inactive");
    }
}

// Start timer when entering game rooms
if (is_game_room() && game_started) {
    room_start_time = current_time;
    room_timer_active = true;
    room_completed = false;
    show_debug_message(" Room timer STARTED");
}