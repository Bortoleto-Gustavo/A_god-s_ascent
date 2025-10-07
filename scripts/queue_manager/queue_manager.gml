// =============================================
// FILA TAD - Implementação Completa
// =============================================

/// @function queue_create()
function queue_create() {
    return instance_create_layer(0, 0, "Instances", obj_queue);
}

/// @function queue_enqueue(queue, room)
function queue_enqueue(queue, room_name) {
    with (queue) {
        if (size >= max_size) {
            show_debug_message("ERRO: Fila cheia!");
            return false;
        }
        
        rear_index = (rear_index + 1) % max_size;
        if (rear_index >= array_length(queue_array)) {
            array_push(queue_array, room_name);
        } else {
            queue_array[rear_index] = room_name;
        }
        size++;
        
        show_debug_message("Sala enfileirada: " + string(room_name) + " | Tamanho: " + string(size));
        return true;
    }
}

/// @function queue_dequeue(queue)
function queue_dequeue(queue) {
    with (queue) {
        if (size == 0) {
            show_debug_message("ERRO: Fila vazia!");
            return "";
        }
        
        var room_name = queue_array[front_index];
        front_index = (front_index + 1) % max_size;
        size--;
        
        show_debug_message("Sala desenfileirada: " + string(room_name) + " | Tamanho: " + string(size));
        return room_name;
    }
}

/// @function queue_peek(queue)
function queue_peek(queue) {
    with (queue) {
        return (size == 0) ? "" : queue_array[front_index];
    }
}

/// @function queue_is_empty(queue)
function queue_is_empty(queue) {
    with (queue) {
        return size == 0;
    }
}

/// @function queue_size(queue)
function queue_size(queue) {
    with (queue) {
        return size;
    }
}

/// @function queue_clear(queue)
function queue_clear(queue) {
    with (queue) {
        queue_array = [];
        front_index = 0;
        rear_index = -1;
        size = 0;
        show_debug_message("Fila limpa!");
    }
}

/// @function queue_display(queue)
function queue_display(queue) {
    with (queue) {
        var display_text = "Fila: [";
        var current = front_index;
        
        for (var i = 0; i < size; i++) {
            display_text += string(queue_array[current]);
            if (i < size - 1) display_text += ", ";
            current = (current + 1) % max_size;
        }
        display_text += "]";
        
        show_debug_message(display_text);
        return display_text;
    }
}