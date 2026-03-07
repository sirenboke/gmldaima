self.scr_pet_skill2 = function(arg0)
{
    if (instance_exists(player))
    {
        var value = 0.02 + (arg0 / 300);
        value *= arg0;
        
        with (player)
        {
            if (isStunned)
                gml_Script_scr_alarm_start(11, 1, gml_Script_scr_stun_end);
            
            poisonStacks = 0;
            bleedTimer = 0;
            hemorrhageTimer = 0;
            
            if (moveSpeed < omoveSpeed)
                moveSpeed = omoveSpeed;
            
            speedBuff += value;
        }
    }
};
