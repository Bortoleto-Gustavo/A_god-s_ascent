/*for (var i = 0; i < array_length(choices); i++) {
    var bx = button_x;
    var by = button_y_start + i * (button_height + button_margin);

    if (point_in_rectangle(mouse_x, mouse_y, bx, by, bx + button_width, by + button_height)) {
        var chosen = choices[i];
        show_debug_message("✅ Chosen Power-Up: " + chosen);

        // Apply it to the player
        apply_powerup(chosen);

        // Advance to next level
        go_to_next_level();

        // Close the menu
        instance_destroy();
        break;
    }
}
