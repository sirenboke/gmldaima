if (instance_exists(obj_enemy))
{
    target = instance_nearest(x, y, obj_enemy);
    
    if (instance_exists(target))
    {
        depth = target.depth;
        target.alarm[2] = -1;
        var _stat1 = target.myStatInfo[0][3] / 10;
        var _stat2 = target.myStatInfo[3][3] / 2;
        var _stat3 = target.myStatInfo[4][3];
        target.spr_move = spr_polymorph;
        target.spr_idle = spr_polymorph;
        target.spr_attack = spr_polymorphAttack;
        
        with (target)
        {
            gml_Script_scr_statChange(_stat1, -1, 0, other.duration, undefined);
            gml_Script_scr_statChange(_stat2, -1, 3, other.duration, undefined);
            gml_Script_scr_statChange(_stat3, -1, 4, other.duration, undefined);
        }
        
        polymorphed = true;
    }
}

with (gml_Script_instance_create(x, y - (sprite_height / 2), obj_smokeAnimation))
    depth = other.depth - 1;
