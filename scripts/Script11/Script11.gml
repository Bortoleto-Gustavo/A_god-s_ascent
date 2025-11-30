/// @function configure_room_from_map(room_index)
/*
function configure_room_from_map(room_index) {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return false;
    
    with (spawner) {
        room_enemies = [];
        room_bosses = [];
        current_enemy_index = 0;
        current_boss_index = 0;
        
        // Check if we have a configuration for this room
        if (ds_map_exists(global.room_configurations, room_index)) {
            var config = global.room_configurations[? room_index];
            
            room_enemies = config.enemies;
            room_bosses = config.bosses;
            max_spawns = config.max_spawns;
            
            show_debug_message("✓ Room " + string(room_index) + " configured from map");
        } else {
            // Fallback configuration
            array_push(room_enemies, obj_enemy_test);
            max_spawns = 5;
            show_debug_message("⚠ Room " + string(room_index) + " using fallback configuration");
        }
        
        show_debug_message("Room " + string(room_index) + " - Enemies: " + string(array_length(room_enemies)) + 
                          ", Bosses: " + string(array_length(room_bosses)) + 
                          ", Max: " + string(max_spawns));
    }
    
    return true;
}