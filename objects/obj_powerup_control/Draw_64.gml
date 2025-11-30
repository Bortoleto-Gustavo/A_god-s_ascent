/*if (global.current_class == "") {
    draw_text(100, 100, "Choose your starting path:");
    draw_text(120, 140, "[1] Fire");
    draw_text(120, 170, "[2] Water");
    draw_text(120, 200, "[3] Air");
}
else {
    if (global.current_level > 0 && global.current_level <= 22) {
		draw_text(100, 100, "Choose your power-up:");
		draw_text(120, 140, "[1] " + string(global.current_choices[0]));
		draw_text(120, 170, "[2] " + string(global.current_choices[1]));
	}
}