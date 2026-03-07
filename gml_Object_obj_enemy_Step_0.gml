with (obj_trees)
{
    if (depth < other.depth)
    {
        if (distance_to_object(other) < 50)
            alpha = 0.2 + (distance_to_object(other) / 50);
    }
}

moveSpeed = baseSpeed;

if (canMove == false)
    moveSpeed = 0;

switch (state)
{
    case UnknownEnum.Value_0:
        gml_Script_scr_idle_enemy();
        break;
    
    case UnknownEnum.Value_1:
        gml_Script_scr_move_enemy();
        break;
    
    case UnknownEnum.Value_2:
        gml_Script_scr_attack_enemy();
        break;
    
    case UnknownEnum.Value_5:
        gml_Script_scr_rest_enemy();
        break;
}

gml_Script_scr_alarm_step();

if (instance_exists(target) && target != -1)
{
    if (target.x > x)
        image_xscale = -size;
    
    if (target.x < x)
        image_xscale = size;
}
else
{
    image_xscale = size;
    image_yscale = size;
}

if (alarm[0] == -1)
{
    if (knockup_str > 0)
    {
        y -= knockup_str;
        knockup_str *= 0.95;
        knockup = true;
    }
    else if (y >= yyy && castingAbility == false && isStunned == false)
    {
        canAttack = true;
        canMove = true;
        knockup = false;
    }
    
    if (knockup == true)
    {
        canAttack = false;
        canMove = false;
    }
    
    if (y < yyy && knockup_str == 0)
    {
        y += grav;
        grav *= 1.2;
    }
    
    if (y >= yyy)
    {
        y = yyy;
        grav = 1;
    }
}

if (sprite_index == spr_move)
    image_speed = moveSpeed / 2 / global.roomSpeed;

if (sprite_index == spr_idle)
    image_speed = 0.01 * global.roomSpeed;

if (gml_Script_scr_alarm_get(11) != -1)
{
    if (state != UnknownEnum.Value_5)
        state = UnknownEnum.Value_0;
    
    image_speed = 0;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_5 = 5
}
