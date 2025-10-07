// =============================================
// SIMPLE ENEMY MANAGER - NO OBJECT LOOKUP
// =============================================

// We'll use a placeholder and manually check what works

/// @function simple_spawn_enemies(room_index, enemy_count)
function simple_spawn_enemies(room_index, enemy_count) {
    show_debug_message("simple_spawn_enemies: " + string(enemy_count) + " enemies");
    
    // Just show a message - don't actually spawn anything yet
    show_debug_message("ENEMY SPAWN SYSTEM READY");
    show_debug_message("Room progression working!");
    
    return true;
}

/// @function simple_clear_enemies()
function simple_clear_enemies() {
    show_debug_message("simple_clear_enemies: All enemies cleared");
    return true;
}

/// @function simple_are_enemies_defeated()
function simple_are_enemies_defeated() {
    // For testing, return true so rooms advance automatically
    return true;
}

/// @function spawn_enemy()
function spawn_enemy() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) {
        show_debug_message("ERROR: No spawner found");
        return;
    }
    
    with (spawner) {
        if (current_spawns >= max_spawns) {
            show_debug_message("Spawner: Max spawns reached");
            return;
        }
        
        // Calculate spawn position
        var angle = random(360);
        var distance = random_range(80, 200);
        var spawn_x = x + lengthdir_x(distance, angle);
        var spawn_y = y + lengthdir_y(distance, angle);
        
        show_debug_message("Attempting to spawn enemy at " + string(spawn_x) + "," + string(spawn_y));
        
        // Create the enemy instance
        var enemy_instance = instance_create_layer(spawn_x, spawn_y, "Instances", obj_enemy_test);
        
        if (instance_exists(enemy_instance)) {
            show_debug_message("✓ SUCCESS: Enemy instance created with ID: " + string(enemy_instance));
            
            // Store reference
            array_push(spawned_enemies, enemy_instance);
            current_spawns++;
            
            show_debug_message("Total enemies: " + string(current_spawns));
        } else {
            show_debug_message("✗ FAILED: Could not create enemy instance");
        }
    }
}

/// @function spawn_boss()
function spawn_boss() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return;
    
    with (spawner) {
        // Spawn boss in center
        var boss_instance = instance_create_layer(x, y - 100, "Instances", obj_boss_test);
        
        // Make boss bigger for visual distinction
        boss_instance.image_xscale = 1.5;
        boss_instance.image_yscale = 1.5;
        
        array_push(spawned_enemies, boss_instance);
        current_spawns++;
        
        show_debug_message("Spawned BOSS!");
    }
}

/// @function clear_all_enemies()
function clear_all_enemies() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return;
    
    with (spawner) {
        var count = array_length(spawned_enemies);
        
        // Actually destroy all instances
        for (var i = 0; i < array_length(spawned_enemies); i++) {
            if (instance_exists(spawned_enemies[i])) {
                instance_destroy(spawned_enemies[i]);
            }
        }
        
        spawned_enemies = [];
        current_spawns = 0;
        show_debug_message("Cleared " + string(count) + " enemy instances");
    }
}

/// @function damage_random_enemy()
function damage_random_enemy() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return;
    
    with (spawner) {
        if (array_length(spawned_enemies) > 0) {
            var random_index = irandom(array_length(spawned_enemies) - 1);
            var enemy = spawned_enemies[random_index];
            
            if (instance_exists(enemy)) {
                // Visual feedback - flash red
                enemy.image_blend = c_red;
                
                // CORRECT: alarm_set takes only 2 arguments
                enemy.alarm[0] = 10; // Reset color after 10 frames
                
                show_debug_message("Damaged enemy!");
                
                // 25% chance to destroy on damage for testing
                if (random(1) < 0.25) {
                    instance_destroy(enemy);
                    array_delete(spawned_enemies, random_index, 1);
                    current_spawns--;
                    show_debug_message("Enemy destroyed!");
                }
            }
        }
    }
}

/// @function are_all_enemies_defeated()
function are_all_enemies_defeated() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) {
        show_debug_message("DEBUG: No spawner found");
        return false;
    }
    
    with (spawner) {
        // Clean up destroyed instances
        for (var i = array_length(spawned_enemies) - 1; i >= 0; i--) {
            if (!instance_exists(spawned_enemies[i])) {
                array_delete(spawned_enemies, i, 1);
                current_spawns--;
            }
        }
        
        var result = !is_active && current_spawns == 0;
        show_debug_message("DEBUG: Spawner active=" + string(is_active) + ", enemies=" + string(current_spawns) + ", room_complete=" + string(result));
        return result;
    }
}