if (spawned == false && x <= xx)
{
    if (!place_meeting(x + sprite_width, y, obj_mountains))
    {
        gml_Script_instance_create(x + sprite_width, y, obj_mountains);
        spawned = true;
    }
}

if (!place_meeting(x - sprite_width, y, obj_mountains))
    first = true;
else
    first = false;

if (first == false)
{
    if (!place_meeting(x - 1, y, obj_mountains))
        x -= 1;
    
    if (place_meeting(x, y, obj_mountains))
        x += 1;
}

if (first == true)
{
    if (x > (room_width / 2))
    {
        gml_Script_instance_create(x - sprite_width - 1, y, obj_mountains);
        first = false;
    }
}

if (x < (-sprite_width / 2))
    instance_destroy();
