// obj_control - Draw Event (BOTTOM LEFT)
// Draw semi-transparent background for text
draw_set_color(make_color_rgb(0, 0, 0));
draw_set_alpha(0.7);
draw_rectangle(5, room_height - 250, 300, room_height - 5, false);
draw_set_alpha(1);

// Draw text
draw_set_color(c_white);
draw_set_halign(fa_left);

var g = room_height - 240; // Start near bottom

// Room Info
draw_text(10, g, "=== ROOM " + string(current_room_index) + " ==="); g += 20;
draw_text(10, g, "Queue: " + string(queue_size(room_queue)) + " rooms left"); g += 18;
draw_text(10, g, "Multiplier: " + string(room_queue.room_multiplier) + "x"); g += 18;

// Spawner Status
var spawner = instance_find(obj_spawner, 0);
if (spawner != noone) {
    g += 10;
    draw_text(10, g, "=== SPAWNER STATUS ==="); g += 20;
    draw_text(10, g, "Active: " + (spawner.is_active ? "YES" : "NO")); g += 18;
    draw_text(10, g, "Enemies: " + string(spawner.current_spawns) + "/" + string(spawner.max_spawns)); g += 18;
    
    var room_complete = are_all_enemies_defeated();
    draw_text(10, g, "Room Complete: " + string(room_complete)); g += 18;
}

// Controls
g += 10;
draw_text(10, g, "=== CONTROLS ==="); g += 20;
draw_text(10, g, "S - Toggle Spawner"); g += 16;
draw_text(10, g, "C - Clear Enemies"); g += 16;
draw_text(10, g, "D - Damage Enemy"); g += 16;
draw_text(10, g, "B - Spawn Boss"); g += 16;
draw_text(10, g, "SPACE - Complete Room"); g += 16;

// Room completion hint at very bottom
if (spawner != noone && are_all_enemies_defeated()) {
    draw_text(10, room_height - 20, ">>> PRESS SPACE TO COMPLETE ROOM <<<");
}