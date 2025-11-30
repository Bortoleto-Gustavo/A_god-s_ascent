/*function generate_powerup_choices(_class, _level) {
    var main_list = global.powerups[? _class];
    var all_classes = ["fire", "water", "air"];

    // Determine the power-up strength range based on the level
    var strength_min = clamp(iround(_level / 2), 1, 13);
    var strength_max = clamp(iround(_level / 1.5), 1, 13);

    var choices = [];

    repeat (2) {
        // 75% chance to pick from the chosen class
        if (irandom_range(1, 100) <= 75) {
            var pool = [];
            for (var i = strength_min; i <= strength_max; i++) {
                var name = main_list[i - 1];
                // Skip exclusive power-ups early in the game
                if (array_index_of(global.exclusive_indices, i) != -1 && _level < 6) continue;
                array_push(pool, name);
            }

            // Pick one random element from the pool
            if (array_length(pool) > 0) {
                var pick_index = irandom(array_length(pool) - 1);
                array_push(choices, pool[pick_index]);
            }
        }
        else {
            // Select one of the other classes
            var others = [];
            for (var j = 0; j < array_length(all_classes); j++) {
                if (all_classes[j] != _class) array_push(others, all_classes[j]);
            }

            var other_class = choose(others[0], others[1]);
            var list = global.powerups[? other_class];

            // Pick one random non-exclusive power-up from another class
            var i = irandom_range(strength_min, strength_max);
            if (i > array_length(list)) i = array_length(list);
            if (array_index_of(global.exclusive_indices, i) != -1) continue;

            var name = list[i - 1];
            array_push(choices, name);
        }
    }
	// after generating choices (debug):
	global.current_choices = generate_powerup_choices(global.current_class, global.current_level);
	show_debug_message("Level " + string(global.current_level) + " -> " + string(global.current_choices[0]) + " / " + string(global.current_choices[1]));

    return choices;
}
