if (!instance_exists(target))
{
    alarm[1] = 1;
    exit;
}

if (type == 1)
{
    if (instance_exists(target))
    {
        global.___struct___213 = function() constructor
        {
            self.target = argument[0];
            self.player = argument[1];
            self.dmg = argument[2];
            self.stacks = argument[3];
        };
        
        instance_create_depth(x, y, depth, obj_poisonStack_new, new function() constructor
        {
            self.target = argument[0];
            self.player = argument[1];
            self.dmg = argument[2];
            self.stacks = argument[3];
        }(target, player, poisonDmg, poisonStacks));
        
        with (instance_create_depth(x, y, depth - 1, obj_raidAnimation))
        {
            var _explosionRange = 0;
            sprite_index = choose(spr_smokeCloud1);
            image_angle = irandom(359);
            image_xscale = 1.5 + (_explosionRange / 100);
            image_yscale = 1.5 + (_explosionRange / 100);
            spd = room_speed * 1.5;
            color = 16777215;
            alpha = 0.9;
            fade = true;
            fadeSpeed = 0.9;
        }
        
        var _player = player;
        var _cloudSize = cloudSize;
        
        if (infectChance > irandom(99))
        {
            with (obj_enemy)
            {
                if (distance_to_point(other.x, y) <= _cloudSize)
                {
                    global.___struct___214 = function() constructor
                    {
                        self.target = argument[0];
                        self.dmg = argument[1];
                        self.player = argument[2];
                        self.warrior = argument[3];
                        self.stacks = 1;
                    };
                    
                    instance_create_depth(x, y - (height / 2), depth, obj_poisonStack_new, new function() constructor
                    {
                        self.target = argument[0];
                        self.dmg = argument[1];
                        self.player = argument[2];
                        self.warrior = argument[3];
                        self.stacks = 1;
                    }(id, other.poisonDmg, _player, _player.myWarrior));
                    part_emitter_region(global.smokebomb_partsys, global.poisonbomb_partemitter, x, x, y - (height / 2), y - (height / 2), 0, 1);
                    part_emitter_burst(global.smokebomb_partsys, global.poisonbomb_partemitter, global.poisonbomb_part, 1);
                }
            }
        }
    }
}

if (type == 2)
{
    global.___struct___215 = function() constructor
    {
        self.player = argument[0];
        self.warrior = argument[1];
        self.target = argument[2];
        self.dmg = argument[3];
        self.duration = argument[4];
        self.fireStacks = argument[5];
    };
    
    instance_create_depth(x, y, depth, obj_burnStack_new, new function() constructor
    {
        self.player = argument[0];
        self.warrior = argument[1];
        self.target = argument[2];
        self.dmg = argument[3];
        self.duration = argument[4];
        self.fireStacks = argument[5];
    }(player, player.myWarrior, target, fireDmg, duration, fireStacks));
}
