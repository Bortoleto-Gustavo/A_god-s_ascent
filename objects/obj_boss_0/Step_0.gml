if (mouse_check_button_pressed(mb_left)) {
    hp -= 1;
    if (hp <= 0) instance_destroy();
}