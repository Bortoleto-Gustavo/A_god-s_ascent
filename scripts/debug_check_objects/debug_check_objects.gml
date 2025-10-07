/// @function debug_check_objects()
function debug_check_objects() {
    show_debug_message("=== DEBUG: CHECKING OBJECTS ===");
    
    // Method 1: Direct check
    var enemy_id = object_get_index("obj_inimigo_0");
    show_debug_message("Method 1 - object_get_index: " + string(enemy_id));
    
    // Method 2: Check if object exists by trying to create an instance
    if (enemy_id != -1) {
        var test_instance = instance_create_depth(0, 0, 0, enemy_id);
        if (instance_exists(test_instance)) {
            show_debug_message("Method 2 - Instance created successfully");
            instance_destroy(test_instance);
        } else {
            show_debug_message("Method 2 - Failed to create instance");
        }
    }
    
    // Method 3: List ALL objects in project
    show_debug_message("=== LISTING ALL OBJECTS ===");
    var all_objects = object_get_names();
    for (var i = 0; i < array_length(all_objects); i++) {
        show_debug_message("Object " + string(i) + ": " + all_objects[i]);
    }
}