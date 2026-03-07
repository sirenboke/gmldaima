if (instance_exists(player) && instance_exists(player.myWarrior))
{
    var _target = instance_place(x, y, obj_enemy);
    
    if (_target != -4)
    {
        if (lastHit != _target)
        {
            global.___struct___218 = function() constructor
            {
                self.player = argument[0];
                self.warrior = argument[1];
                self.target = argument[2];
                self.dmg = argument[3];
                self.duration = 2;
                self.fireStacks = argument[4];
            };
            
            instance_create_depth(_target.x, _target.y, depth, obj_burnStack_new, new function() constructor
            {
                self.player = argument[0];
                self.warrior = argument[1];
                self.target = argument[2];
                self.dmg = argument[3];
                self.duration = 2;
                self.fireStacks = argument[4];
            }(other.player, other.player.myWarrior, _target, other.dmg, other.fireStacks));
        }
        
        with (_target)
            gml_Script_scr_enemy_takeDamage(other.dmg, 4, other.player, undefined, undefined, 0);
        
        with (player.myWarrior)
        {
            if (mySpecialBuff[3] > 0)
                gml_Script_scr_player_heal(other.dmg * mySpecialBuff[3]);
        }
    }
    
    lastHit = _target;
    alarm[1] = room_speed / 5;
}
