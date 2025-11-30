spawn_timer = 0;
spawn_interval = 45; // frames between spawns
max_spawns = 15;
current_spawns = 0;
spawns_initiated = 0;
is_active = true;
spawned_enemies = []; // Array to track spawned instances

// Enemy configuration
enemy_config = {
    hp: 3,
    hp_max: 3,
    chase_speed: 2,
    damage: 1
};

boss_config = {
    hp: 15,
    hp_max: 15,
    chase_speed: 3,
    damage: 3
};

persistent = true; // Make spawner persistent across rooms

// ROOM-SPECIFIC ENEMY CONFIGURATION
room_enemies = []; // Array of enemy object types for current room
room_bosses = [];  // Array of boss object types for current room
current_enemy_index = 0;
current_boss_index = 0;

// Default fallback enemy (in case no room configuration exists)
default_enemy = obj_enemy_test;
default_boss = obj_boss_test;

show_debug_message("PERSISTENT SPAWNER CREATED: " + string(id));
show_debug_message("Initial arrays: room_enemies=" + string(array_length(room_enemies)) + ", room_bosses=" + string(array_length(room_bosses)));