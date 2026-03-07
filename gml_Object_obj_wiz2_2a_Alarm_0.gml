with (gml_Script_instance_create(x, y, obj_raidAnimation))
{
    sprite_index = spr_spark_electrical;
    image_index = 0;
    image_angle = irandom(359);
    image_xscale = 0.5;
    image_yscale = 0.5;
    spd = room_speed / 3;
    color = 8388736;
}

instance_destroy();
