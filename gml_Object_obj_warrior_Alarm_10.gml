if (poisonAuraDmg > 0)
{
    if (instance_exists(obj_enemy))
    {
        var _player = player;
        
        with (obj_enemy)
        {
            if (distance_to_point(other.x, y) <= 300)
            {
                poisonAuraDmg = other.poisonAuraDmg;
                
                global.___struct___228 = function() constructor
                {
                    self.target = argument[0];
                    self.dmg = argument[1];
                    self.player = argument[2];
                    self.warrior = argument[3];
                    self.stacks = argument[4];
                };
                
                instance_create_depth(x, y - (height / 2), depth, obj_poisonStack_new, new function() constructor
                {
                    self.target = argument[0];
                    self.dmg = argument[1];
                    self.player = argument[2];
                    self.warrior = argument[3];
                    self.stacks = argument[4];
                }(id, other.poisonAuraDmg, _player, _player.myWarrior, other.poisonStacksBomb));
            }
        }
    }
    
    alarm[10] = room_speed;
}
