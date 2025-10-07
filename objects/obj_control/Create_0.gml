// obj_control - Create Event (CLEAN)
room_queue = noone;
current_room_index = -1;
game_started = false;
room_start_delay = 0;
// Initialize queue
room_queue = queue_create();

// Enqueue rooms for testing
for (var i = 0; i < 2; i++) {
    queue_enqueue(room_queue, "andar_" + string(i));
}

// Configurar dificuldade inicial
with (room_queue) {
    room_multiplier = 1.0;
}

var spawner = instance_find(obj_spawner, 0);
if (spawner != noone) {
    show_debug_message("Spawner in room at: " + string(spawner.x) + "," + string(spawner.y));
} else {
    show_debug_message("WARNING: No spawner in room!");
}

show_debug_message("Jogo inicializado com " + string(queue_size(room_queue)) + " salas");
queue_display(room_queue);

// FUNCTION DEFINITIONS (keep these)
function start_next_room() {
    if (!queue_is_empty(room_queue)) {
        current_room_index++;
        
        // Use fixed values for testing
        var enemy_count = 5;
        var boss_count = 1;
        
        show_debug_message("=== ROOM " + string(current_room_index) + " STARTED ===");
        show_debug_message("Enemies: " + string(enemy_count) + ", Bosses: " + string(boss_count));
        
        // Auto-activate spawner
        var spawner = instance_find(obj_spawner, 0);
        if (spawner != noone) {
            spawner.is_active = true;
            spawner.max_spawns = enemy_count;
        }
        
        start_room_timer(room_queue);
    }
}

function end_current_room() {
    // Calculate multiplier based on time
    var multiplier = end_room_timer(room_queue);
    
    // Remove current room from queue
    var cleared_room = queue_dequeue(room_queue);
    
    show_debug_message("Sala " + string(current_room_index) + " completada! Multiplicador próxima: " + string(multiplier) + "x");
    
    // Check if there's next room
    if (!queue_is_empty(room_queue)) {
        var next_room_name = queue_peek(room_queue);
        show_debug_message("Next room: " + next_room_name);
        
        // Actually change to the next room
        switch (next_room_name) {
            case "andar_0":
                room_goto(andar_0);
                break;
            case "andar_1":
                room_goto(andar_1);
                break;
            default:
                show_debug_message("Unknown room: " + next_room_name);
        }
    } else {
        show_debug_message("=== TODAS AS SALAS CONCLUÍDAS! ===");
    }
}

/// @function test_enemy_objects()
function test_enemy_objects() {
    show_debug_message("=== TESTING ENEMY OBJECTS ===");
    
    // Test if obj_enemy_test exists
    if (object_exists(obj_enemy_test)) {
        show_debug_message("✓ obj_enemy_test exists");
        
        // Try to create one at a known position
        var test_enemy = instance_create_layer(400, 300, "Instances", obj_enemy_test);
        if (instance_exists(test_enemy)) {
            show_debug_message("✓ Successfully created obj_enemy_test instance");
        } else {
            show_debug_message("✗ Failed to create obj_enemy_test instance");
        }
    } else {
        show_debug_message("✗ obj_enemy_test does not exist");
    }
    
    // Test if obj_boss_test exists
    if (object_exists(obj_boss_test)) {
        show_debug_message("✓ obj_boss_test exists");
    } else {
        show_debug_message("✗ obj_boss_test does not exist");
    }
}

test_enemy_objects();

// obj_control - Create Event (add this)
show_debug_message("obj_control CREATED at position: " + string(x) + "," + string(y));
show_debug_message("Room: " + room_get_name(room));

show_debug_message("=== ROOM VERIFICATION ===");
show_debug_message("Room name: " + room_get_name(room));
show_debug_message("Room size: " + string(room_width) + "x" + string(room_height));
show_debug_message("My position: " + string(x) + "," + string(y));

// Force a room background color
background_color = c_gray;