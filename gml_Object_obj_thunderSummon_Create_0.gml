event_inherited();

if (instance_exists(obj_enemy))
{
    target = instance_nearest(x, y, obj_enemy);
    
    if (target.x <= 1500)
    {
        x = target.x;
    }
    else
    {
        instance_destroy();
        exit;
    }
}
else
{
    target = -4;
}

alarm[0] = 1;
alpha = 1;
image_speed = 0;
image_index = irandom(image_number - 1);
image_xscale = choose(-1, 1);
gml_Script_scr_playsound(s_thunder, 0.9, 1.1, 0.2);
