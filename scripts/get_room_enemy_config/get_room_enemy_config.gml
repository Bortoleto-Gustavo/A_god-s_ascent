/// @function get_room_enemy_config(room_index)
/// @description Get the enemy configuration for a specific room
function get_room_enemy_config(room_index) {
    var config = {
        enemies: [],
        bosses: [],
        spawn_count: 5
    };
    
    switch (room_index) {
        case 0:
			config.enemies = [obj_enemy_test];
            config.spawn_count = 5 + room_index;
            break;
        case 1:
			config.enemies = [obj_boss_19];
            config.spawn_count = 0 + room_index;
            break;
        case 2:
            config.enemies = [obj_inimigo_0];
            config.spawn_count = 3 + room_index;
            break;
        case 3:
            config.enemies = [obj_boss_0];
            config.spawn_count = 0 + room_index;
            break;
            
        default:
            config.enemies = [obj_enemy_test];
            config.spawn_count = min(5 + floor(room_index / 3), 12);
            break;
    }
    
    return config;
}