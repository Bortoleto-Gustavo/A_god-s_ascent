/*if (global.current_class == "") {
    if (keyboard_check_pressed(ord("1"))) global.current_class = "fire";
    if (keyboard_check_pressed(ord("2"))) global.current_class = "water";
    if (keyboard_check_pressed(ord("3"))) global.current_class = "air";

    if (global.current_class != "") {
        // Generate first 2 choices for the player
        global.current_choices = next_level_choices();
        global.current_powerup_node = 0; // start at root
    }
}
// --- Power-up selection ---
else {
    // Make sure we have choices ready
    if (array_length(global.current_choices) < 1) exit;

    if (keyboard_check_pressed(ord("1"))) {
        apply_powerup(global.current_choices[0]);
        global.current_choices = next_level_choices();
        global.current_powerup_node += 1; // move down the tree
    }
    else if (keyboard_check_pressed(ord("2"))) {
        apply_powerup(global.current_choices[1]);
        global.current_choices = next_level_choices();
        global.current_powerup_node += 1; // move down the tree
    }
}