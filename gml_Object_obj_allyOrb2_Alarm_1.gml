if (instance_exists(obj_enemy))
{
    for (var i = 0; i < (instance_number(obj_enemy) + 1); i += 1)
        enemy[i] = instance_find(obj_enemy, i);
    
    if (enemy[myID] != -4)
    {
        target = enemy[myID];
        yy = random_range(target.y - (target.height / 3), target.y - (target.height / 1.5));
        
        with (gml_Script_instance_create(target.x, target.y - (target.height / 1.5), obj_float))
        {
            type = 2;
            value = other.dmg;
            text = "-" + string(value);
            c1 = 255;
            c2 = 128;
            parent = other.target;
        }
        
        gml_Script_scr_playsound(s_swordhit1, 0.9, 1.1, 0.2);
        
        with (target)
        {
            hp -= other.dmg;
            
            if ((hp - other.dmg) <= 0)
            {
                gml_Script_scr_playsound(s_swordhit2, 0.9, 1.1, 1);
                gml_Script_scr_death_enemy();
            }
        }
    }
    else
    {
        instance_destroy();
    }
}
else
{
    instance_destroy();
}
