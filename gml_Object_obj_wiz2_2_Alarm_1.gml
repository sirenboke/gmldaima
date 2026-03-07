with (gml_Script_instance_create(x, y, obj_wiz2_2a))
{
    player = other.player;
    dmg = other.dmg;
    depth = other.depth - 2;
}

alarm[1] = room_speed;
