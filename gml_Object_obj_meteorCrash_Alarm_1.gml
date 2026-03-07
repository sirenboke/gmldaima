var _player = player;
var _warrior;

if (challenge == false)
    _warrior = _player.myWarrior;

var _dmg = dmg;
var _duration = 1;
var _fireStacks = fireStacks;
var _slow = slow;

if (alpha2 >= 0.5 || alarm[0] > (room_speed / 2))
{
    if (challenge == false)
    {
        if (instance_exists(obj_enemy))
        {
            with (obj_enemy)
            {
                if (distance_to_object(other) <= other.size)
                {
                    if (_slow > 0)
                        gml_Script_scr_statChange(_slow, -1, 10, 2, undefined);
                    
                    var _target = id;
                    
                    global.___struct___219 = function() constructor
                    {
                        self.player = argument[0];
                        self.warrior = argument[1];
                        self.dmg = argument[2];
                        self.duration = argument[3];
                        self.fireStacks = argument[4];
                        self.target = argument[5];
                    };
                    
                    instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                    {
                        self.player = argument[0];
                        self.warrior = argument[1];
                        self.dmg = argument[2];
                        self.duration = argument[3];
                        self.fireStacks = argument[4];
                        self.target = argument[5];
                    }(_player, _warrior, _dmg, _duration, _fireStacks, _target));
                }
            }
        }
    }
    else if (instance_exists(obj_warrior))
    {
        with (obj_warrior)
        {
            if (distance_to_object(other) <= other.size)
            {
                if (_slow > 0)
                    gml_Script_scr_statChange(_slow, -1, 10, 2, undefined);
                
                var _target = id;
                
                global.___struct___220 = function() constructor
                {
                    self.player = argument[0];
                    self.warrior = argument[1];
                    self.dmg = argument[2];
                    self.duration = argument[3];
                    self.fireStacks = argument[4];
                    self.target = argument[5];
                };
                
                instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
                {
                    self.player = argument[0];
                    self.warrior = argument[1];
                    self.dmg = argument[2];
                    self.duration = argument[3];
                    self.fireStacks = argument[4];
                    self.target = argument[5];
                }(_player, _player, _dmg, _duration, _fireStacks, _target));
            }
        }
    }
}

alarm[1] = room_speed;
