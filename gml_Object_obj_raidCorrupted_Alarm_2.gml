with (obj_warrior)
{
    if (myRaidNumber == 0 && enteredCombat == true)
    {
        var _chance = random_range(0.1, 1);
        
        if (_chance <= global.challenge_interruption)
        {
            gml_Script_scr_interrupt();
            gml_Script_scr_playsound(s_electric1, 1, 1, 0.5);
        }
    }
}

alarm[2] = room_speed;
