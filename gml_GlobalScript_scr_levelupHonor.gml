self.scr_levelupHonor = function()
{
    honorLevel += 1;
    maxHonor = round(power(honorLevel + 5, 2));
    
    if (honor < maxHonor)
    {
        gml_Script_scr_playsound(s_levelUp2, 0.9, 1.1, 2);
        gml_Script_scr_playsound(s_levelUp3, 0.9, 1.1, 2);
        
        if (avoidSpam <= 2)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached Honor level " + string(honorLevel) + "!");
    }
    
    avoidSpam = 10;
};
