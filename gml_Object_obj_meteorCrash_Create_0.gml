event_inherited();
scale = 2;
alpha = 1;
alpha2 = 0.8;
ember = 0;
disappear = false;
challenge = false;
image_yscale = 2;
image_index = 1;
image_speed = 0;
alarm[1] = 1;

with (gml_Script_instance_create(x, y, obj_raidAnimation))
{
    sprite_index = spr_explosion1;
    image_xscale = 1.5;
    image_yscale = 1.5;
    depth = other.depth - 2;
}

gml_Script_scr_playsound(s_meteorImpact, 0.4, 0.8, 0.3);
ember = gml_Script_scr_playsound(s_campfire, 0.8, 1, 0.6);
