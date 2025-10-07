
draw_set_color(c_blue);
draw_circle(x, y, 25, false);
draw_set_color(c_white);
draw_text(x - 20, y - 8, "SPAWN");

// Spawner info
draw_set_halign(fa_left);
/*
var info_y = y - 80;

draw_text(x - 100, info_y, "SPAWNER CONTROLS:"); info_y += 18;
draw_text(x - 100, info_y, "S - Toggle Spawner"); info_y += 16;
draw_text(x - 100, info_y, "C - Clear Enemies"); info_y += 16;
draw_text(x - 100, info_y, "D - Damage Random"); info_y += 16;
draw_text(x - 100, info_y, "B - Spawn Boss"); info_y += 16;
draw_text(x - 100, info_y, "Active: " + string(is_active)); info_y += 16;
draw_text(x - 100, info_y, "Enemies: " + string(current_spawns) + "/" + string(max_spawns));