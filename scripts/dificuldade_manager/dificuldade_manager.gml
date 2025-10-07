// =============================================
// SISTEMA DE DIFICULDADE BASEADO EM TEMPO
// =============================================

/// @function start_room_timer(queue)
/// @description Inicia o timer para a sala atual
function start_room_timer(queue) {
    with (queue) {
        room_start_time = current_time;
        room_clear_time = 0;
        show_debug_message("Timer iniciado para sala: " + string(queue_peek(queue)));
    }
}

/// @function end_room_timer(queue)
/// @description Finaliza o timer e calcula o multiplicador
function end_room_timer(queue) {
    with (queue) {
        room_clear_time = current_time - room_start_time;
        var time_seconds = room_clear_time / 1000; // converter para segundos
        
        // Calcular multiplicador baseado no tempo
        // Quanto mais rápido limpar, maior o multiplicador (mais difícil)
        if (time_seconds < 30) {
            // Muito rápido - alta dificuldade
            room_multiplier = 1.8;
        } else if (time_seconds < 60) {
            // Rápido - dificuldade média
            room_multiplier = 1.5;
        } else if (time_seconds < 120) {
            // Normal
            room_multiplier = 1.2;
        } else {
            // Lento - dificuldade reduzida
            room_multiplier = 1.0;
        }
        
        show_debug_message("Sala limpa em " + string(time_seconds) + "s | Multiplicador próxima sala: " + string(room_multiplier));
        return room_multiplier;
    }
}

/// @function get_enemy_count_for_room(queue, room_index)
/// @description Calcula quantidade de inimigos baseada no multiplicador
function get_enemy_count_for_room(queue, room_index) {
    with (queue) {
        var base_count = base_enemy_count;
        var multiplied_count = ceil(base_count * room_multiplier);
        
        // Limitar máximo para não ficar impossível
        multiplied_count = min(multiplied_count, 5); // máximo 5 inimigos
        
        show_debug_message("Sala " + string(room_index) + ": " + string(multiplied_count) + " inimigos (base: " + string(base_count) + " × " + string(room_multiplier) + ")");
        return multiplied_count;
    }
}

/// @function get_boss_count_for_room(queue, room_index)
/// @description Calcula quantidade de bosses baseada no multiplicador
function get_boss_count_for_room(queue, room_index) {
    with (queue) {
        var base_count = base_boss_count;
        var multiplied_count = ceil(base_count * room_multiplier);
        
        // Boss geralmente é único, mas pode variar
        multiplied_count = min(multiplied_count, 2); // máximo 2 bosses
        
        show_debug_message("Sala " + string(room_index) + ": " + string(multiplied_count) + " bosses (base: " + string(base_count) + " × " + string(room_multiplier) + ")");
        return multiplied_count;
    }
}