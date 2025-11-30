// Multiplier Debug Info
/*
var debug_x = 10;
var debug_y = room_height - 150;

draw_set_color(c_yellow);
draw_text(debug_x, debug_y, "=== MULTIPLIER DEBUG ==="); debug_y += 20;
draw_text(debug_x, debug_y, "Current Multiplier: " + string(global.last_room_multiplier) + "x"); debug_y += 18;
draw_text(debug_x, debug_y, "Last Room Time: " + string(global.last_room_time) + "s"); debug_y += 18;

// Show expected enemy counts for different multipliers
draw_text(debug_x, debug_y, "Expected enemies with 1.0x: " + string(ceil(5 * 1.0))); debug_y += 16;
draw_text(debug_x, debug_y, "Expected enemies with 1.2x: " + string(ceil(5 * 1.2))); debug_y += 16;
draw_text(debug_x, debug_y, "Expected enemies with 1.5x: " + string(ceil(5 * 1.5))); debug_y += 16;
draw_text(debug_x, debug_y, "Expected enemies with 1.8x: " + string(ceil(5 * 1.8))); debug_y += 16;

// Current room actual spawns
var spawner = instance_find(obj_spawner, 0);
if (spawner != noone) {
    debug_y += 10;
    draw_text(debug_x, debug_y, "ACTUAL SPAWNS: " + string(spawner.max_spawns)); debug_y += 18;
}

if (room_timer_active) {
    var current_time_elapsed = (current_time - room_start_time) / 1000;
    draw_text(debug_x, debug_y, "Current Room Time: " + string(current_time_elapsed) + "s"); 
    debug_y += 18;
}