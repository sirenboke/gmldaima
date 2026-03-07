if (alarm[0] == 1)
{
    if (instance_exists(player))
    {
        var _player = player;
        
        if (instance_exists(other))
        {
            with (other)
            {
                if (myRaidNumber == 0 && immune == false)
                {
                    var _target = id;
                    gml_Script_scr_player_takeDamage(_player.myStatInfo[9][3], 2, _player, 0, 0);
                    
                    global.___struct___210 = function() constructor
                    {
                        self.player = argument[0];
                        self.bleedHealReduction = 0.5;
                        self.duration = 3;
                        self.target = argument[1];
                    };
                    
                    instance_create_depth(x, y, depth, obj_bleedEffect, new function() constructor
                    {
                        self.player = argument[0];
                        self.bleedHealReduction = 0.5;
                        self.duration = 3;
                        self.target = argument[1];
                    }(_player, _target));
                    gml_Script_scr_playsound(s_enemyBite, 0.9, 1.1, 0.2);
                }
            }
        }
    }
}
