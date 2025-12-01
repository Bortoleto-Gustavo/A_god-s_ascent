
if (bbox_right < 0 || bbox_left > room_width || bbox_bottom < 0 || bbox_top > room_height)
{
    // Se qualquer uma dessas condições for verdadeira, estamos fora da tela.
    instance_destroy();
}