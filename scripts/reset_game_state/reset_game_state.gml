/// @function reset_game_state()
/// @description Completely resets all game progression and player state

function reset_game_state() {
    show_debug_message("Reset completo do estado do jogo...");
    
    // Reset global progression variables
    if (variable_global_exists("current_room_level")) {
        global.current_room_level = 0;
    }
    if (variable_global_exists("rooms_completed")) {
        global.rooms_completed = 0;
    }
    if (variable_global_exists("room_progression")) {
        global.room_progression = 0;
    }
    
    // Reset any other global progression flags
    if (variable_global_exists("boss_defeated")) {
        global.boss_defeated = false;
    }
    if (variable_global_exists("teleporter_active")) {
        global.teleporter_active = false;
    }
    
    // Reset player death flag
    if (variable_global_exists("just_died")) {
        global.just_died = false;
    }
    
    show_debug_message(" Estado do jogo resetado completamente");
}