instance_destroy();

with (gml_Script_instance_create(x, y, obj_arrowFall))
{
    sprite_index = other.sprite_index;
    direction = other.direction;
    image_index = other.image_index;
    image_xscale = other.image_xscale;
    image_yscale = other.image_yscale;
}
