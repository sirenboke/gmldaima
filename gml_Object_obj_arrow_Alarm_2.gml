with (gml_Script_instance_create(x, y, obj_arrowFall))
{
    sprite_index = other.sprite;
    direction = other.direction;
    image_index = other.image_index;
    image_angle = other.image_angle;
}

skipDmg = true;
instance_destroy();
