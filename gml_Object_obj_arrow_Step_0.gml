if (!place_meeting(x, y, obj_enemy))
    hit = false;

if (pierce == false)
{
    if (!instance_exists(target) || !instance_exists(player))
    {
        with (gml_Script_instance_create(x, y, obj_arrowFall))
        {
            sprite_index = other.sprite;
            image_index = other.image_index;
            direction = other.direction;
            image_angle = other.image_angle;
            sprite_color = other.sprite_color;
        }
        
        instance_destroy();
        skipDmg = true;
    }
}

if (x >= (500 + rng))
{
    with (gml_Script_instance_create(x, y, obj_arrowFall))
    {
        sprite_index = other.sprite;
        direction = other.direction;
        image_index = other.image_index;
        image_angle = other.image_angle;
        sprite_color = other.sprite_color;
    }
    
    instance_destroy();
    skipDmg = true;
}
