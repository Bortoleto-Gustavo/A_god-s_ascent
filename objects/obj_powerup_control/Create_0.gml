/*
// Define the 3 power-up lists
global.powerups = {
    fire: [
        "1_fire", "2_fire", "3_fire", "4_fire", "5_fire",
        "6_fire", "7_fire", "8_fire", "9_fire", "10_fire",
        "11_fire", "12_fire", "13_fire"
    ],
    water: [
        "1_water", "2_water", "3_water", "4_water", "5_water",
        "6_water", "7_water", "8_water", "9_water", "10_water",
        "11_water", "12_water", "13_water"
    ],
    air: [
        "1_air", "2_air", "3_air", "4_air", "5_air",
        "6_air", "7_air", "8_air", "9_air", "10_air",
        "11_air", "12_air", "13_air"
    ]
};

// Exclusive power-ups (only appear if chosen class)
global.exclusive_indices = [6, 11, 12, 13];

// Game state
global.current_class = "";   // Player not chosen yet
global.current_level = 0;    // Before first level

// Game state
if (!variable_global_exists("powerup_forest")) {
    global.powerup_forest = ds_map_create(); // map per class
    global.powerup_forest[? "fire"] = ds_list_create();
    global.powerup_forest[? "water"] = ds_list_create();
    global.powerup_forest[? "air"] = ds_list_create();
}