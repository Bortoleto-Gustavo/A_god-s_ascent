// Create Event of obj_room_manager

room_queue = queue_create();

//add rooms to queue
var total_levels = 22; // number of playable levels
for (var i = 0; i < total_levels; i++) {
    var room_name = "andar_" + string(i);
    var room_index = asset_get_index(room_name);
	if (room_index != -1) {
	    queue_enqueue(room_queue, room_index);
	} else {
	    show_debug_message("Warning: Room not found -> " + room_name);
    }
}
/*
// If we are loading a level after the first
if (global.current_level > 0) {
    var choices = generate_powerup_choices(global.current_class, global.current_level);
    global.current_choices = choices;

    show_debug_message("Level " + string(global.current_level) + " choices: " + string(choices));
    
    // Open power-up menu UI
    instance_create_layer(0, 0, "UI", obj_powerup_menu);
}
else {
    // Beginning of the game — pick starting class (maybe a different menu)
    show_debug_message("Class selection screen here!");
}
