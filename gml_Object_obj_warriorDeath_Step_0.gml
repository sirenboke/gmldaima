if (image_index == (image_number - 1))
{
    image_speed = 0;
    image_index = image_number - 1;
    
    if (alarm[0] == -1)
        alarm[0] = room_speed * 30;
}

ascended = false;
