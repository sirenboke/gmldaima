if (global.dev == 1)
{
    sub = 1;
    xp += (maxxp * 100);
    
    if (myAbilityInfo[4] < global.maxAbilityLevel)
    {
        myAbilityInfo[7] += myAbilityInfo[8];
        
        if (myAbilityInfo[7] >= myAbilityInfo[8])
        {
            myAbilityInfo[4] += 1;
            myAbilityInfo[7] -= myAbilityInfo[8];
            myAbilityInfo[8] = myAbilityInfo[4] * 300;
            
            if (myAbilityInfo[4] <= (global.maxAbilityLevel / 2))
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " leveled up ability " + string(myAbilityInfo[0] + 1) + " (" + string(myAbilityInfo[1]) + " " + string(myAbilityInfo[6]) + ") to level " + string(myAbilityInfo[4]) + "!");
            }
            else if (myAbilityInfo[4] == ((global.maxAbilityLevel / 2) + 1))
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " maxed ability " + string(myAbilityInfo[0] + 1) + " (" + string(myAbilityInfo[1]) + " " + string(myAbilityInfo[6]) + ") and unlocked extra effects for it!");
                myAbilityInfo[5] += 1;
                myAbilityInfo[6] = string_repeat("I", myAbilityInfo[5]);
                
                if (global.milestone[8][4] == 0)
                {
                    with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                    {
                        type = 8;
                        icon = 0;
                        name = other.name;
                    }
                }
            }
            else if (myAbilityInfo[4] == global.maxAbilityLevel)
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " maxed ability " + string(myAbilityInfo[0] + 1) + " (" + string(myAbilityInfo[1]) + " " + string(myAbilityInfo[6]) + ")! You can now specialize as a " + string(global.skillSpecialization[classType][myAbilityInfo[0]]) + ".");
                
                if (global.milestone[9][4] == 0)
                {
                    with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
                    {
                        type = 9;
                        icon = 1;
                        name = other.name;
                    }
                }
            }
            else
            {
                gml_Script_twitch_chat_say("/me " + string(name) + " leveled up ability " + string(myAbilityInfo[0] + 1) + " (" + string(myAbilityInfo[1]) + " " + string(myAbilityInfo[6]) + ") to level " + string(myAbilityInfo[4] - (global.maxAbilityLevel / 2)) + "!");
            }
        }
    }
}
