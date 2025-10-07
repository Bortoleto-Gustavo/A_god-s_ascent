queue_array = [];
front_index = 0;
rear_index = -1;
size = 0;
max_size = 23; // tamanho máximo da fila

room_multiplier = 1.0;
room_start_time = 0;
room_clear_time = 0;
base_enemy_count = 6; // inimigo base por sala
base_boss_count = 1;

/// @function queue_is_empty(queue)
function queue_is_empty(queue) {
    show_debug_message("queue_is_empty called, size: " + string(queue.size));
    with (queue) {
        return size == 0;
    }
}