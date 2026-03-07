self.scr_playerSubscribe = function(arg0)
{
    myRelicSlots = 0;
    
    if (level >= 100)
        myRelicSlots = 1;
    
    if (level >= 500)
        myRelicSlots = 2;
    
    if (level >= 1000)
        myRelicSlots = 3;
    
    if (myTier < 2)
        myTier = 2;
    
    if (myRelicSlots < 2)
        myRelicSlots = 2;
    
    if (myBuildSlots < 3)
        myBuildSlots = 3;
    
    for (var i = 0; i < global.totalDiaryQuests; i += 1)
        diaryQuest[i][2] = 1;
    
    if (sub != 1)
    {
        sub = 1;
        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
        autoPot = ini_read_real("Misc", "Auto Potion", 1);
        autoAbility = ini_read_real("Misc", "Auto Ability", 1);
        autoSwitch = ini_read_real("Misc", "Auto Switch", 1);
        autoLoot = ini_read_real("Misc", "Auto Loot", 1);
        autoBuy = ini_read_real("Misc", "Auto Buy", 1);
        ini_close();
        ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
        
        if (ini_read_real("Misc", "Sub", 0) == 0)
        {
            ini_close();
            achievement[23] += 1;
            gml_Script_scr_gainHonor(50);
            gml_Script_twitch_chat_say("/color GoldenRod");
            gml_Script_twitch_chat_say("/me " + string(arg0) + " thanks for supporting the game! You earned " + string(global.cmdPrefix) + "!Legend Status, a sub-only 10%[x] XP and resource gain bonus, obtained Kenji's " + string(global.cmdPrefix) + "!Diary and gained 50 Honor! room00Raid (all the rewards are received on every stream you play)");
            gml_Script_twitch_chat_say("/color FireBrick");
            ini_open(string(global.platformDir) + string(myAccDir) + "Account Data.ini");
        }
        
        ini_write_real("Misc", "Sub", 1);
        gml_Script_scr_updateStats();
        ini_close();
    }
    else
    {
        ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
        autoAbility = ini_read_real("Misc", "Auto Ability", 0);
        autoSwitch = ini_read_real("Misc", "Auto Switch", 0);
        autoPot = ini_read_real("Misc", "Auto Potion", 0);
        autoPotHP = ini_read_real("Misc", "Auto Potion HP", 0.3);
        autoLoot = ini_read_real("Misc", "Auto Loot", 0);
        autoBuy = ini_read_real("Misc", "Auto Buy", 0);
        ini_close();
    }
};

self.scr_playerUnsubscribe = function(arg0)
{
    if (level >= 250)
        myTier = 1;
    
    if (level >= 500)
        myTier = 2;
    
    if (level >= 1000)
        myTier = 3;
    
    if (level >= 2500)
        myTier = 4;
    
    myRelicSlots = 0;
    myBuildSlots = 2;
    
    if (level >= 100)
        myRelicSlots = 1;
    
    if (myTier == 2)
    {
        myRelicSlots = 2;
        myBuildSlots = 3;
    }
    
    if (myTier == 3)
    {
        myRelicSlots = 3;
        myBuildSlots = 4;
    }
    
    if (myTier == 4)
    {
        myRelicSlots = 3;
        myBuildSlots = 4;
    }
    
    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
    sub = 0;
    autoPot = ini_read_real("Misc", "Auto Potion", 0);
    autoAbility = ini_read_real("Misc", "Auto Ability", 0);
    
    if (level < 500)
    {
        autoAbility = 0;
        ini_write_real("Misc", "Auto Ability", 0);
    }
    
    autoPotHP = ini_read_real("Misc", "Auto Potion HP", 0.3);
    
    if (ascended == false)
        autoSwitch = 0;
    
    autoLoot = 0;
    autoBuy = 0;
    ini_write_real("Misc", "Sub", 0);
    ini_close();
    
    if (fullDiary == 0)
    {
        for (var i = 0; i < global.totalDiaryQuests; i += 1)
        {
            diaryQuest[i][2] = 0;
            
            if ((i % 5) == 0)
                diaryQuest[i][2] = 1;
        }
    }
};
