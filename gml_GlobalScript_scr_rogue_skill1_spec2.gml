self.scr_rogue_skill1_spec2 = function()
{
    var _range = 600;
    var _target = -1;
    var _recastSpeed = 3;
    
    if (skillBuff == 0)
    {
        skillBuff = 10;
        buffed = skillBuff;
    }
    
    if (instance_exists(obj_enemy) && buffed > 0)
    {
        var levelScaling = global.maxAbilityLevel / 2;
        var _abilityDmg = myStatInfo[0][3] * (1.2 + ((levelScaling / 3) * (1 + (levelScaling / 20)))) * (1 + (myStatInfo[0][3] / 10000));
        _abilityDmg /= 1000;
        var _player = player;
        var _max = instance_number(obj_enemy);
        var _check = -1;
        var _lowestHP = -1;
        
        for (var i = 0; i < _max; i++)
        {
            _check = instance_find(obj_enemy, i);
            
            if ((_check.x - x) <= _range)
            {
                if (_lowestHP == -1)
                    _lowestHP = _check;
                else if (_check.hp < _lowestHP.hp)
                    _lowestHP = _check;
            }
        }
        
        _target = _lowestHP;
        
        if (instance_exists(_target))
        {
            with (instance_create_depth(x, y - (sprite_height / 1.5), _target.depth - 10, obj_shuriken))
            {
                player = _player;
                playerX = _player.x;
                rng = 600;
                target = _target;
                dmg = _abilityDmg;
                cantMiss = other.cantMiss;
                pierce = false;
                bounces = 0;
                arrowdmgReduction = 1;
            }
            
            buffed -= 1;
            
            if (buffed <= 0)
            {
                skillBuff = 0;
                canAttack = true;
                canMove = true;
                targetFixed = false;
                exit;
            }
            
            targetFixed = true;
            target = _target;
            canAttack = false;
            canMove = false;
            show_debug_message("placholder next target = " + string(_target));
            gml_Script_scr_alarm_start(4, _recastSpeed, gml_Script_scr_rogue_skill1_spec2);
        }
        else
        {
            skillBuff = 0;
            buffed = 0;
            canAttack = true;
            canMove = true;
            targetFixed = false;
        }
    }
    else
    {
        skillBuff = 0;
        buffed = 0;
        targetFixed = false;
        canAttack = true;
        canMove = true;
    }
};
