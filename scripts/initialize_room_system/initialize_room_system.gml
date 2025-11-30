function initialize_room_system() {
    show_debug_message("nitializing room system...");
    
    // Clean up old queue if it exists
    if (variable_global_exists("room_queue") && ds_exists(global.room_queue, ds_type_queue)) {
        queue_destroy(global.room_queue);
    }
    
    // Create new queue
    global.room_queue = queue_create();
    
    // Add intro room first -
    var intro_room = asset_get_index("Intro_room"); 
    if (room_exists(intro_room)) {
        queue_enqueue(global.room_queue, intro_room);
        show_debug_message("Added Intro_room to queue");
    } else {
        show_debug_message("Intro_room not found! Using room 0");
        queue_enqueue(global.room_queue, 0);
    }
    
    // Add all andar rooms
    var total_levels = 4;
    var rooms_added = 0;
    
    for (var i = 0; i < total_levels; i++) {
        var room_name = "andar_" + string(i);
        var room_id = asset_get_index(room_name);
        
        if (room_id != -1 && room_exists(room_id)) {
            queue_enqueue(global.room_queue, room_id);
            rooms_added++;
            show_debug_message("Added: " + room_name);
        }
    }
	
	//Add Final Boss Room
	var boss_room = asset_get_index("Boss_room"); 
    if (room_exists(boss_room)) {
        queue_enqueue(global.room_queue, boss_room);
        show_debug_message("Added Boss_room to queue");
    } else {
        show_debug_message("Boss_room not found! Using room 5");
        queue_enqueue(global.room_queue, 5);
    }
	
	//Add game end room
	var end_room = asset_get_index("End_room"); 
    if (room_exists(end_room)) {
        queue_enqueue(global.room_queue, end_room);
        show_debug_message("Added End_room to queue");
    } else {
        show_debug_message("End_room not found! Using room 6");
        queue_enqueue(global.room_queue, 6);
    }
    
    show_debug_message("Room system ready! Total rooms: " + string(queue_size(global.room_queue)));
}