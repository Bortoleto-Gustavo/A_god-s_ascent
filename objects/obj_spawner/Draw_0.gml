/*
draw_set_color(c_blue);
draw_circle(x, y, 25, false);
draw_set_color(c_white);
draw_text(x - 20, y - 8, "SPAWN");

// Spawner info
draw_set_halign(fa_left);
var info_y = y - 80;

draw_text(x - 100, info_y, "SPAWNER CONTROLS:"); info_y += 18;
draw_text(x - 100, info_y, "P - Toggle Spawner"); info_y += 16;  // Changed from S to P
draw_text(x - 100, info_y, "C - Clear Enemies"); info_y += 16;
draw_text(x - 100, info_y, "D - Damage Random"); info_y += 16;
draw_text(x - 100, info_y, "B - Spawn Boss"); info_y += 16;
draw_text(x - 100, info_y, "Active: " + string(is_active)); info_y += 16;
draw_text(x - 100, info_y, "Enemies: " + string(current_spawns) + "/" + string(max_spawns));

function debug_spawner_status() {
    var spawner = instance_find(obj_spawner, 0);
    if (spawner != noone) {
        show_debug_message("   SPAWNER STATUS:");
        show_debug_message("   Active: " + string(spawner.is_active));
        show_debug_message("   Room: " + room_get_name(room));
        show_debug_message("   Max Spawns: " + string(spawner.max_spawns));
        show_debug_message("   Current: " + string(spawner.current_spawns));
        show_debug_message("   Initiated: " + string(spawner.spawns_initiated));
        show_debug_message("   Enemies: " + string(array_length(spawner.room_enemies)));
        show_debug_message("   Bosses: " + string(array_length(spawner.room_bosses)));
    } else {
        show_debug_message(" No spawner found!");
    }
}

// Call it with a key press if needed (add to Step Event):
if (keyboard_check_pressed(ord("I"))) {
    debug_spawner_status();
}

// Enemy counter with multiplier info
draw_set_color(c_white);
draw_set_halign(fa_left);

var info_x = 10;
var info_y = 50;

draw_text(info_x, info_y, "ENEMIES: " + string(current_spawns) + "/" + string(max_spawns)); info_y += 20;
draw_text(info_x, info_y, "Multiplier: " + string(global.last_room_multiplier) + "x"); info_y += 18;
draw_text(info_x, info_y, "Spawner: " + (is_active ? "ACTIVE" : "INACTIVE")); info_y += 18;

// Show multiplier effect visually
if (global.last_room_multiplier > 1.0) {
    draw_set_color(c_yellow);
    draw_text(info_x, info_y, "HARD MODE: " + string(global.last_room_multiplier) + "x"); info_y += 20;
}