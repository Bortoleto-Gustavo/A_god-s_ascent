/*function next_level_choices() {
    global.current_level += 1;

    if (global.current_level > 22) return undefined; // done

    var opts = generate_powerup_choices(global.current_class, global.current_level);
    return opts;
}
