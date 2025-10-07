// Inicializar
room_queue = queue_create();

// Adicionar salas
queue_enqueue(room_queue, "andar_0");
queue_enqueue(room_queue, "andar_1");

// Avançar salas
var next_room = queue_dequeue(room_queue);
// room_goto(asset_get_index(next_room));