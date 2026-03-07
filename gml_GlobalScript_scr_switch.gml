self.scr_switch = function(arg0)
{
    if (global.challenge_canSwitch == 0)
        exit;
    
    var _next = "";
    
    if (dying == false)
    {
        if (name == arg0 && myRaidNumber == 0 && (!instance_exists(obj_raidResults) && !instance_exists(obj_raidPortalResults)))
        {
            var _listSize;
            
            if (raidList == global.raidList0)
                _listSize = ds_list_size(global.raidListMelee);
            
            if (raidList == global.raidList1)
                _listSize = ds_list_size(global.raidListRanged);
            
            if (_listSize > 1)
            {
                if (raidList == global.raidList1)
                {
                    global.xpGoto[1] = -2;
                    
                    if (instance_exists(obj_rangedLegs))
                    {
                        with (obj_rangedLegs)
                            instance_destroy();
                        
                        with (obj_rangedTorso)
                            instance_destroy();
                    }
                }
                
                if (raidList == global.raidList0)
                    global.xpGoto[0] = -2;
                
                with (obj_warrior)
                {
                    if (raidList == other.raidList)
                    {
                        myRaidNumber -= 1;
                        
                        if (myRaidNumber == 0)
                        {
                            _next = name;
                            
                            if (class == "warrior" && specialized == 3)
                            {
                                if (myAbilityInfo[0] == 2 && myRaidNumber == 0)
                                {
                                    mana = maxmana;
                                    gml_Script_scr_castAbility();
                                }
                            }
                        }
                        
                        if (raidList == global.raidList0)
                            xx = 400 - (myRaidNumber * 100);
                        
                        if (raidList == global.raidList1)
                            xx = 350 - (myRaidNumber * 100);
                    }
                }
                
                myRaidNumber = _listSize - 1;
                
                if (raidList == global.raidList0)
                    xx = 400 - (myRaidNumber * 100);
                
                if (raidList == global.raidList1)
                    xx = 350 - (myRaidNumber * 100);
                
                show_debug_message("From " + string(name) + ": " + string(myRaidNumber));
                gml_Script_twitch_chat_say_direct("/me " + string(name) + " just switched. " + string(_next) + " is now entering the combat!");
                enteredCombat = false;
                immune = true;
                state = UnknownEnum.Value_0;
                alarm[2] = 1;
                
                with (obj_tempStat)
                {
                    if (player == other.id)
                        alarm[0] = 1;
                }
                
                var sz = array_length(custom_alarm) - 1;
                
                for (var i = 0; i < sz; i++)
                {
                    if (custom_alarm[i][0] > -1)
                    {
                        custom_alarm[i][0] = -1;
                        
                        if (script_exists(custom_alarm[i][1]))
                            script_execute(custom_alarm[i][1]);
                    }
                }
            }
        }
    }
};

enum UnknownEnum
{
    Value_0
}
