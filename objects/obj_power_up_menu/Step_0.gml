/*draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

// Title
draw_text(display_get_width()/2, 100, "Choose Your Power-Up!");

// Draw buttons for each choice
for (var i = 0; i < array_length(choices); i++) {
    var bx = button_x;
    var by = button_y_start + i * (button_height + button_margin);

    // Background color change on hover
    var hover = point_in_rectangle(mouse_x, mouse_y, bx, by, bx + button_width, by + button_height);
    draw_set_color(hover ? c_lime : c_dkgray);
    draw_rectangle(bx, by, bx + button_width, by + button_height, false);

    // Text
    draw_set_color(c_white);
    draw_text(bx + button_width / 2, by + button_height / 2, choices[i]);
}
