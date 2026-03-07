self.scr_levelup = function()
{
    if (ascended == true)
    {
        xp = maxxp - 1;
        exit;
    }
    
    xp -= maxxp;
    level += 1;
    
    with (gml_Script_instance_create(x, y - (height / 2), obj_float))
    {
        type = 25;
        value = "Level up!";
        text = value;
        c1 = 16711935;
        c2 = 8388736;
        parent = other.id;
    }
    
    gml_Script_scr_addDiaryProgress(1, 1);
    
    if (level >= 250)
    {
        if (global.milestone[0][4] == 0)
        {
            with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
            {
                type = 0;
                icon = 0;
                name = other.name;
            }
        }
    }
    
    if (level >= 500)
    {
        if (global.milestone[1][4] == 0)
        {
            with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
            {
                type = 1;
                icon = 1;
                name = other.name;
            }
        }
    }
    
    if (level >= 1000)
    {
        if (global.milestone[2][4] == 0)
        {
            with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
            {
                type = 2;
                icon = 2;
                name = other.name;
            }
        }
    }
    
    if (level >= 2500)
    {
        if (global.milestone[3][4] == 0)
        {
            with (gml_Script_instance_create(room_width / 2, room_height / 2, obj_showMilestone))
            {
                type = 3;
                icon = 3;
                name = other.name;
            }
        }
    }
    
    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
    var oldMaxHP = myStatInfo[8][3];
    maxxp = round(((10 + power(level + 5, 2.3)) * (level + 20)) / 8);
    gml_Script_scr_updateStats();
    var healHP = myStatInfo[8][3] - oldMaxHP;
    hp += healHP;
    
    if (hp > myStatInfo[8][3])
        hp = myStatInfo[8][3];
    
    ini_write_real("Stats", "Level", level);
    ini_write_real("Stats", "HP", hp);
    
    with (obj_warrior)
    {
        if (name == other.name)
        {
            level = other.level;
            xp = other.xp;
            maxxp = other.maxxp;
            part_emitter_region(global.light_partsys, global.level_partemitter, x - 40, x + 40, y - 20, y, 0, 1);
            part_emitter_burst(global.light_partsys, global.level_partemitter, global.level_part1, 15 + (level / 10));
        }
    }
    
    part_emitter_region(global.light_partsys, global.level_partemitter, x - 20, x + 20, y - 10, y, 0, 1);
    part_emitter_burst(global.light_partsys, global.level_partemitter, global.level_part1, 8 + (level / 10));
    var honorAmount = 0;
    pointsAmount += 1;
    
    if ((level % 10) == 0)
        pointsAmount += 5;
    
    if ((level % 50) == 0)
        pointsAmount += 5;
    
    if ((level % 100) == 0)
        pointsAmount += 10;
    
    if (level > 500 || myTier >= 2)
        pointsAmount += 1;
    
    if (level > 1000)
        pointsAmount += 1;
    
    if (level == 100)
    {
        if (myRelicSlots == 0)
            myRelicSlots = 1;
    }
    
    if (level == 250)
    {
        if (myTier < 1)
        {
            myTier = 1;
            autoPot = 1;
            myRelicSlots = 1;
            pointsAmount += 50;
            achievement[14] += 1;
        }
    }
    
    if (level == 500)
    {
        if (myTier < 2)
        {
            myTier = 2;
            autoAbility = 1;
            myRelicSlots = 2;
            myBuildSlots = 3;
            pointsAmount += 50;
            achievement[15] += 1;
        }
    }
    
    if (level == 1000)
    {
        if (myTier < 3)
        {
            myTier = 3;
            myRelicSlots = 3;
            myBuildSlots = 4;
            pointsAmount += 50;
            achievement[16] += 1;
        }
    }
    
    if (level == 2500)
    {
        if (myTier < 4)
        {
            myTier = 4;
            myRelicSlots = 3;
            pointsAmount += 50;
            achievement[17] += 1;
        }
    }
    
    if (xp < maxxp)
    {
        gml_Script_scr_playsound(s_levelUp2, 0.9, 1.1, 2);
        gml_Script_scr_playsound(s_levelUp3, 0.9, 1.1, 2);
        
        if (level == 50)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! You are getting stronger! (+" + string(pointsAmount) + " talent points)");
        
        if (level == 100)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! You are incredible! (+" + string(pointsAmount) + " talent points)");
        
        if (level == 150)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! Your name will be remembered... (+" + string(pointsAmount) + " talent points)");
        
        if (level == 200)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! ...how did you do it? (+" + string(pointsAmount) + " talent points)");
        
        if (level == 250)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + " and obtained " + string(global.cmdPrefix) + "!Hero Status! Thanks for your effort " + string(name) + ", it will be rewarded. (+" + string(pointsAmount) + " talent points)");
        
        if (level == 300)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! I knew you would get here, don't stop now. (+" + string(pointsAmount) + " talent points)");
        
        if (level == 350)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! I can see the legend inside you! (+" + string(pointsAmount) + " talent points)");
        
        if (level == 400)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! Your power... it is growing day by day... (+" + string(pointsAmount) + " talent points)");
        
        if (level == 450)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! Only a few make it to this point. Congratulations. (+" + string(pointsAmount) + " talent points)");
        
        if (level == 500)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! You obtained the " + string(global.cmdPrefix) + "!Legend Status, it is an honor having you by our side " + string(name) + ". (+" + string(pointsAmount) + " talent points)");
        
        if (level == 1000)
            gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + gml_Script_scr_bigNumber(level) + "! You obtained the " + string(global.cmdPrefix) + "!Demigod Status, your power and dedication is outstanding! (+" + string(pointsAmount) + " talent points)");
        
        if (level == 2500)
            gml_Script_twitch_chat_say_direct("/me " + string(name) + " has reached level " + gml_Script_scr_bigNumber(level) + "! You can now " + string(global.cmdPrefix) + "!Ascend! Best of luck in your new journey room00Raid (+" + string(pointsAmount) + " talent points)");
        
        if (global.chatSpam == 0 && avoidSpam == 0)
        {
            if (level > 1000)
                gml_Script_twitch_chat_say("/me " + string(name) + " is closer to becoming a God! (lv." + gml_Script_scr_bigNumber(level) + ", +" + string(pointsAmount) + " talent points).");
            
            if (level > 500 && level < 1000)
                gml_Script_twitch_chat_say("/me " + string(name) + " is legendary! (lv." + string(level) + ", +" + string(pointsAmount) + " talent points).");
            
            if ((level % 50) != 0 && level < 500)
                gml_Script_twitch_chat_say("/me " + string(name) + " has reached level " + string(level) + "! (+" + string(pointsAmount) + " talent points).");
        }
        
        if (sub == 1)
        {
            if (myTier < 2)
                myTier = 2;
            
            if (myRelicSlots < 2)
                myRelicSlots = 2;
            
            if (myBuildSlots < 3)
                myBuildSlots = 3;
        }
        
        avoidSpam = 10;
        skillPoints += pointsAmount;
        totalSkillPoints += pointsAmount;
        achievement[21] += pointsAmount;
        ini_write_real("Stats", "Skill Points", skillPoints);
        ini_write_real("Stats", "Total Skill Points", totalSkillPoints);
        pointsAmount = 0;
    }
    
    ini_close();
    
    if (xp < 0)
        xp = 0;
};
