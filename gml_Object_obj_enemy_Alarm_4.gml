hpRegenHeal = myStatInfo[6][3];
var _relic18dmg = relic18dmg;

if (myStatInfo[6][3] > 0)
{
    var _relic5effect = gml_Script_scr_relicEffect(player, 0, 5);
    relicRegen = floor(myStatInfo[6][3] * (1 - (hp / myStatInfo[8][3])) * _relic5effect);
    hpRegenHeal = myStatInfo[6][3] + relicRegen;
    relic18dmg = hpRegenHeal * gml_Script_scr_relicEffect(player, 0, 18);
    _relic18dmg = relic18dmg;
    
    if (hp < myStatInfo[8][3] || shield < maxshield)
        gml_Script_scr_enemy_heal(hpRegenHeal / 5);
}

if (instance_exists(obj_warrior))
{
    with (obj_warrior)
    {
        if (state == UnknownEnum.Value_2)
        {
            if (target != -1)
            {
                if (target == other.id)
                {
                    if (_relic18dmg > 0)
                    {
                        gml_Script_scr_player_takeDamage(_relic18dmg, 4, other, undefined, 0, undefined, undefined, 0, 1);
                        show_debug_message("Relic 18 should be hitting " + string(name) + ", target ID: " + string(target) + ", enemy ID: " + string(other.id) + ".");
                        show_debug_message("Relic 18 hit for " + string(_relic18dmg) + " true damage.");
                    }
                }
            }
        }
    }
}

if (instance_exists(target) && (target != -4 && target > 0) && instance_exists(target.player))
{
    var _fireshieldReflect = target.fireshieldReflect;
    var _fireTarget = other.id;
    var _player = other.target.player;
    var _warrior = other.target;
    
    if (state == UnknownEnum.Value_2)
    {
        if (target.dmgReflection > 0)
            gml_Script_scr_enemy_takeDamage(target.dmgReflection, 2, target.player, 0, undefined, undefined, 1);
    }
    
    if (_fireshieldReflect > 0)
    {
        if (state == UnknownEnum.Value_2)
        {
            if (choose(0, 1, 2, 3, 4) == 0)
            {
                global.___struct___216 = function() constructor
                {
                    self.player = argument[0];
                    self.warrior = argument[1];
                    self.target = argument[2];
                    self.dmg = argument[3];
                    self.duration = 3;
                    self.fireStacks = 1;
                };
                
                instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                {
                    self.player = argument[0];
                    self.warrior = argument[1];
                    self.target = argument[2];
                    self.dmg = argument[3];
                    self.duration = 3;
                    self.fireStacks = 1;
                }(_player, _warrior, _fireTarget, _fireshieldReflect));
            }
        }
    }
}

if (alarm[2] != -1 || buffed != 0)
{
    var _relic19shield = myStatInfo[4][3] * 10 * gml_Script_scr_relicEffect(player, 0, 19);
    
    if (_relic19shield > 0)
        gml_Script_scr_shield(_relic19shield);
}

if (state == UnknownEnum.Value_2)
{
    if (stamina > 0 && tired == false)
    {
        tired = false;
        
        if (stamina > maxStamina)
            stamina = maxStamina;
        
        stamina -= staminaDrain;
    }
    else
    {
        stamina = 0;
        tired = true;
        state = UnknownEnum.Value_5;
    }
}

if (stamina == 0)
{
    tired = true;
    state = UnknownEnum.Value_5;
}

if (tired == true)
{
    stamina += ((staminaDrain + (tierReduction / 20)) * 2.5 * tier);
    
    if (stamina >= maxStamina)
    {
        stamina = maxStamina;
        tired = false;
        state = UnknownEnum.Value_0;
    }
}

if (bleedTimer > 0)
    bleedTimer -= 0.2;
else
    hemorrhageTrigger = 0;

if (hemorrhageTimer > 0)
    hemorrhageTimer -= 0.2;

alarm[4] = room_speed / 5;

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_5 = 5
}
