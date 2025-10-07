// Spawner Create Event
spawn_timer = 0;
spawn_interval = 45; // frames between spawns
max_spawns = 8;
current_spawns = 0;
is_active = false;
spawned_enemies = []; // Array to track spawned instances

show_debug_message("Spawner created: " + string(id));
show_debug_message("Initial state: active=" + string(is_active) + ", max=" + string(max_spawns));

/// @function spawn_enemy()
function spawn_enemy() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return;
    
    with (spawner) {
        if (current_spawns >= max_spawns) return;
        
        var spawn_x = random_range(x - 150, x + 150);
        var spawn_y = random_range(y - 150, y + 150);
        
        var enemy_instance = instance_create_layer(spawn_x, spawn_y, "Instances", obj_enemy_test);
        array_push(spawned_enemies, enemy_instance);
        current_spawns++;
        
        show_debug_message("Spawned enemy " + string(current_spawns) + " at " + string(spawn_x) + "," + string(spawn_y));
    }
}