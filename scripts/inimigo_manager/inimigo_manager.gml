show_debug_message("=== LOADING INIMIGO_MANAGER ===");

/// @function simple_spawn_enemies(room_index, enemy_count)
function simple_spawn_enemies(room_index, enemy_count) {
    show_debug_message("simple_spawn_enemies: Room " + string(room_index) + " - " + string(enemy_count) + " enemies");
    
    // Configure enemies for this room
    configure_room_enemies(room_index);
    
    var spawner = instance_find(obj_spawner, 0);
    if (spawner != noone) {
        spawner.is_active = true;
        spawner.max_spawns = enemy_count;
        show_debug_message("Spawner activated for room " + string(room_index) + " with max: " + string(enemy_count));
    }
    
    return true;
}

/// @function simple_clear_enemies()
function simple_clear_enemies() {
    clear_all_enemies();
    show_debug_message("simple_clear_enemies: All enemies cleared");
    return true;
}

/// @function simple_are_enemies_defeated()
function simple_are_enemies_defeated() {
    return are_all_enemies_defeated();
}


/// @function configure_room_by_name()
global.configure_room_by_name = function() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) {
        show_debug_message("ERROR: No spawner found for room configuration");
        return false;
    }
    
    var room_name = room_get_name(room);
    show_debug_message("Configuring room: " + room_name);
    
    // Calculate everything in local variables first
    var new_room_enemies = [];
    var new_room_bosses = [];
    var base_spawns = 5;
    
    // Room configuration
    switch (room_name) {
        case "andar_0":
            array_push(new_room_enemies, obj_enemy_test);
            base_spawns = 6;
            show_debug_message("Room 0: Basic enemies (3)");
            break;
        case "andar_1":
            array_push(new_room_enemies, obj_boss_19);
            base_spawns = 1;
            show_debug_message("Room 1: Semi-boos (1)");
            break;
        case "andar_2":
            array_push(new_room_enemies, obj_inimigo_0);
            base_spawns = 6;
            show_debug_message(" Room 2: Intermidiate enemies (6)");
            break;
        case "andar_3":
            array_push(new_room_bosses, obj_boss_0);
            base_spawns = 1;
            show_debug_message("Room 19: Semi-BOSS");
            break;
		case "andar_4":
            array_push(new_room_bosses, obj_boss_1);
            base_spawns = 1;
            show_debug_message("Room 19: FINAL BOSS");
            break;
        default:
            if (string_pos("andar_", room_name) > 0) {
                array_push(new_room_enemies, obj_enemy_test);
                base_spawns = 5;
                show_debug_message("Default andar room: Basic enemies (5)");
            } else {
                base_spawns = 0;
                show_debug_message("Non-game room: No enemies");
            }
            break;
    }
    
    // Calculate max_spawns with multiplier
    var final_max_spawns = base_spawns;
    
    // Only apply multiplier if there are enemies/bosses AND multiplier exists
    if ((array_length(new_room_enemies) > 0 || array_length(new_room_bosses) > 0) && base_spawns > 0) {
        if (variable_global_exists("last_room_multiplier")) {
            final_max_spawns = ceil(base_spawns * global.last_room_multiplier);
            final_max_spawns = min(final_max_spawns, 15); // Cap at 15
            show_debug_message("MULTIPLIER APPLIED: " + string(base_spawns) + " × " + string(global.last_room_multiplier) + " = " + string(final_max_spawns));
        } else {
            show_debug_message("No multiplier found - using base: " + string(base_spawns));
        }
    } else {
        final_max_spawns = 0;
        show_debug_message("No enemies configured - spawns: 0");
    }
    
    // Apply to spawner instance
    spawner.room_enemies = new_room_enemies;
    spawner.room_bosses = new_room_bosses;
    spawner.current_enemy_index = 0;
    spawner.current_boss_index = 0;
    spawner.max_spawns = final_max_spawns;
    spawner.spawns_initiated = 0; // Reset initiated count
    
    show_debug_message("FINAL CONFIG: Enemies=" + string(array_length(new_room_enemies)) + 
                      ", Bosses=" + string(array_length(new_room_bosses)) +
                      ", Max=" + string(final_max_spawns));
    
    return true;
};

/// @function get_next_enemy_type()
function get_next_enemy_type() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return obj_enemy_test;
    
    // Use with block to access instance variables safely
    with (spawner) {
        if (array_length(room_enemies) == 0) {
            return obj_enemy_test; // Fallback
        }
        
        var enemy_type = room_enemies[current_enemy_index];
        current_enemy_index = (current_enemy_index + 1) % array_length(room_enemies);
        
        return enemy_type;
    }
}

/// @function get_next_boss_type()
function get_next_boss_type() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return obj_boss_test;
    
    with (spawner) {
        if (array_length(room_bosses) == 0) {
            return obj_boss_test; // Fallback
        }
        
        var boss_type = room_bosses[current_boss_index];
        current_boss_index = (current_boss_index + 1) % array_length(room_bosses);
        
        return boss_type;
    }
}

/// @function spawn_specific_enemy(enemy_object)
function spawn_specific_enemy(enemy_object) {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) {
        show_debug_message("ERROR: No spawner found");
        return noone;
    }
    
    with (spawner) {
        if (current_spawns >= max_spawns) {
            show_debug_message("Spawner: Max spawns reached");
            return noone;
        }
        
        // Calculate spawn position
        var angle = random(360);
        var distance = random_range(80, 200);
        var spawn_x = x + lengthdir_x(distance, angle);
        var spawn_y = y + lengthdir_y(distance, angle);
        
        show_debug_message("Spawning specific enemy: " + object_get_name(enemy_object));
        
        // Create the specific enemy instance
        var enemy_instance = instance_create_layer(spawn_x, spawn_y, "Instances", enemy_object);
        
        if (instance_exists(enemy_instance)) {
            show_debug_message(" SUCCESS: " + object_get_name(enemy_object) + " created with ID: " + string(enemy_instance));
            
            // Store reference
            array_push(spawned_enemies, enemy_instance);
            current_spawns++;
            
            show_debug_message("Total enemies: " + string(current_spawns));
            return enemy_instance;
        } else {
            show_debug_message(" FAILED: Could not create " + object_get_name(enemy_object));
            return noone;
        }
    }
}

/// @function spawn_enemy()
function spawn_enemy() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) {
        show_debug_message("ERROR: No spawner found");
        return noone;
    }
    
    with (spawner) {
        // ONLY check initial spawn count - ignore current living enemies
        if (spawns_initiated >= max_spawns) {
            return noone;
        }
        
        // Calculate spawn position
        var angle = random(360);
        var distance = random_range(0,80);
        var spawn_x = x + lengthdir_x(distance, angle);
        var spawn_y = y + lengthdir_y(distance, angle);
        
        // Get enemy type
        var enemy_type = get_next_enemy_type();
        
        // Create the enemy instance
        var enemy_instance = instance_create_layer(spawn_x, spawn_y, "Instances", enemy_type);
        
        if (instance_exists(enemy_instance)) {
            // Store reference
            array_push(spawned_enemies, enemy_instance);
            current_spawns++;
            spawns_initiated++; // This should NEVER decrease
            
            show_debug_message("Spawned enemy " + string(spawns_initiated) + "/" + string(max_spawns));
            return enemy_instance;
        }
    }
    return noone;
}

/// @function spawn_boss()
function spawn_boss() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return noone;
    
    with (spawner) {
        if (spawns_initiated >= max_spawns) {
            show_debug_message("Spawner: Max initial spawns reached");
            return noone;
        }
        
        // Get the configured boss type for this room
        var boss_type = get_next_boss_type();
        
        // Spawn boss in center
        var boss_instance = instance_create_layer(x, y - 100, "Instances", boss_type);
        
        if (instance_exists(boss_instance)) {
            // Boss configuration
            boss_instance.image_xscale = 1.5;
            boss_instance.image_yscale = 1.5;
            
            array_push(spawned_enemies, boss_instance);
            current_spawns++;
            spawns_initiated++; // Track initial spawns for bosses too
            
            show_debug_message("Spawned BOSS: " + object_get_name(boss_type) + " " + string(spawns_initiated) + "/" + string(max_spawns));
            return boss_instance;
        }
    }
    return noone;
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
                // Apply damage directly to enemy
                if (variable_instance_exists(enemy, "hp")) {
                    enemy.hp -= 1;
                    show_debug_message("Damaged enemy! HP: " + string(enemy.hp));
                    
                    // Visual feedback
                    enemy.image_blend = c_red;
                    if (variable_instance_exists(enemy, "alarm")) {
                        enemy.alarm[0] = 10;
                    }
                    
                    // Check if enemy died
                    if (enemy.hp <= 0) {
                        instance_destroy(enemy);
                        array_delete(spawned_enemies, random_index, 1);
                        current_spawns--;
                        show_debug_message("Enemy destroyed!");
                    }
                }
            }
        }
    }
}

/// @function are_all_enemies_defeated()
function are_all_enemies_defeated() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return false;
    
    with (spawner) {
        // Clean up destroyed instances but DON'T touch spawns_initiated
        var living_count = 0;
        for (var i = array_length(spawned_enemies) - 1; i >= 0; i--) {
            if (!instance_exists(spawned_enemies[i])) {
                array_delete(spawned_enemies, i, 1);
            } else {
                living_count++;
            }
        }
        
        current_spawns = living_count; // Update current living count
        
        // Room is complete when initial batch is spawned AND all are dead
        var result = (spawns_initiated >= max_spawns) && (current_spawns == 0);
        
        show_debug_message("Room check: initiated=" + string(spawns_initiated) + 
                          "/" + string(max_spawns) + 
                          ", living=" + string(current_spawns) + 
                          ", complete=" + string(result));
        return result;
    }
}

/// @function stop_spawner_and_calculate_multiplier()
function stop_spawner_and_calculate_multiplier() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner == noone) return 1.0;
    
    with (spawner) {
        // Stop spawning new enemies
        is_active = false;
        show_debug_message("Spawner stopped - enemies will finish current actions");
        
        return 1.0; // Placeholder
    }
}

// detailed debug:
/*
if (array_length(room_enemies) > 0) {
    if (variable_global_exists("last_room_multiplier")) {
        var original_spawns = base_spawns;
        var multiplier_value = global.last_room_multiplier;
        max_spawns = ceil(original_spawns * multiplier_value);
        max_spawns = min(max_spawns, 15);
        
        show_debug_message("MULTIPLIER CALCULATION:");
        show_debug_message("   Base spawns: " + string(original_spawns));
        show_debug_message("   Multiplier: " + string(multiplier_value) + "x");
        show_debug_message("   Calculated: " + string(original_spawns) + " × " + string(multiplier_value) + " = " + string(max_spawns));
        show_debug_message("   Final max: " + string(max_spawns));
    } else {
        max_spawns = configured_max_spawns;
        show_debug_message("No multiplier found - using base: " + string(max_spawns));
    }
}