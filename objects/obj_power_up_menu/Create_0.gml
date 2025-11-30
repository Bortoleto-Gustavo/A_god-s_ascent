/*
// Store the player’s available power-ups (array from global)
if (variable_global_exists("current_choices")) {
    choices = global.current_choices;
} else {
    choices = [];
}

// UI layout
button_width = 300;
button_height = 80;
button_margin = 40;

// Calculate positions dynamically
button_x = display_get_width() / 2 - button_width / 2;
button_y_start = display_get_height() / 2 - ((array_length(choices) * (button_height + button_margin)) / 2);
