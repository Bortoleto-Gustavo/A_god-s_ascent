// Enemy Draw Event - Draw a simple shape if sprite doesn't show
if (sprite_index == -1 || sprite_index == noone) {
    draw_set_color(c_red);
    draw_circle(x, y, 16, false);
    draw_set_color(c_white);
    draw_text(x - 8, y - 6, "E");
} else {
    // Draw the actual sprite
    draw_self();
}