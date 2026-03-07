if (distance_to_point(xx, yy) > 3)
{
    motion_add(point_direction(x, y, xx, yy), 0.1);
    
    if (speed > 10)
        speed = 10;
}
else
{
    if (type == "mine")
        obj_build_guildhall.minerGuildXP += value;
    
    if (type == "farm")
        obj_build_guildhall.farmerGuildXP += value;
    
    if (type == "kill")
        obj_build_guildhall.hunterGuildXP += value;
    
    global.rewardChestProgress += ((1 + (obj_build_guildhall.level / 5)) * (obj_build_guildhall.level / 10));
    audio_sound_pitch(s_xpOrb, random_range(9, 12));
    audio_play_sound(s_xpOrb, 0, 0);
    
    with (gml_Script_instance_create(xx, yy, obj_float))
    {
        type = 0;
        value = other.value;
        text = "+" + string(value) + "xp";
        c1 = 16711935;
        c2 = 8388736;
        parent = type;
    }
    
    instance_destroy();
}
