function go_to_next_level() {
    if (!variable_global_exists("room_queue") || global.room_queue == noone) {
        show_debug_message("ERROR: global.room_queue not initialized!");
        return;
    }

    // If queue is empty, finish the run
    if (queue_is_empty(global.room_queue)) {
        show_debug_message("🎉 All levels completed! Returning to intro...");
        
        // Reset game state but keep queue structure
        game_started = false;
        global.game_started = false;
        
        // Reinitialize the queue for a new run
        initialize_room_system();
        
        // Go back to intro room
        var intro_room = queue_peek(global.room_queue);
        room_goto(intro_room);
        return;
    }

    // Get next room from the queue
    var next_room = queue_dequeue(global.room_queue);

    // Verify the room actually exists
    if (!room_exists(next_room)) {
        show_debug_message("Invalid room asset in queue — skipping.");
        return;
    }

    // Save progress
    global.current_level += 1;

    show_debug_message("Moving to next room: " + room_get_name(next_room));
    room_goto(next_room);
}