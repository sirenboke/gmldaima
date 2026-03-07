var _dmg = dmg;
var _player = player;
var _warrior = warrior;
var _armorRed = armorReduction;
var _burnChance = 0;

if ((burnChance * 100) > irandom(99))
    _burnChance = 1;

with (obj_enemy)
{
    if (place_meeting(x, y, other))
    {
        gml_Script_scr_statChange(_armorRed, -1, 3);
        gml_Script_scr_enemy_takeDamage(_dmg, 1, _player, undefined, undefined, undefined, 1);
        
        if (_burnChance == 1 && instance_exists(_warrior))
        {
            global.___struct___223 = function() constructor
            {
                self.player = argument[0];
                self.warrior = argument[1];
                self.target = argument[2];
                self.dmg = argument[3];
                self.fireStacks = 1;
            };
            
            instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
            {
                self.player = argument[0];
                self.warrior = argument[1];
                self.target = argument[2];
                self.dmg = argument[3];
                self.fireStacks = 1;
            }(_player, _warrior, id, _dmg));
        }
    }
}

alarm[0] = frequency;
