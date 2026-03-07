if (!place_meeting(x, y, obj_enemy))
    hit = false;

angle -= 50;

if ((x - playerX) > rng)
{
    if (y < (room_height - 30))
    {
        motion_set(point_direction(x, y, x + 1, y + yy), spd);
        yy *= 1.2;
    }
    else
    {
        instance_destroy();
        
        with (gml_Script_instance_create(x, y, obj_axeFall))
        {
            direction = other.direction;
            image_index = other.image_index;
            image_angle = other.angle;
        }
    }
}
