self.scr_creatureKeeper_train = function()
{
    with (obj_player)
    {
        if (petTraining != 0)
        {
            if (myPetInfo[petTraining][4] >= (obj_build_creaturekeeper.level + 4))
            {
                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                ini_write_real("Pets", "My Pet Training", 0);
                ini_close();
                myPetInfo[petTraining][5] = 0;
                var _petText = "";
                
                if (myPetID == 0)
                {
                    myPetID = petTraining;
                    _petText = " Pet #" + string(myPetID) + " (" + string(myPetInfo[myPetID][1]) + " - lv." + string(myPetInfo[myPetID][4]) + ") is now your companion.";
                    
                    if (myPlayerPet != 0)
                    {
                        with (myPlayerPet)
                            instance_destroy();
                    }
                    
                    myPlayerPet = instance_create_depth(x, y, depth - 1, obj_petPlayer);
                    
                    with (myPlayerPet)
                    {
                        player = other.id;
                        type = other.myPetID;
                    }
                }
                
                gml_Script_twitch_chat_say("/me " + string(name) + " Your Pet #" + string(petTraining) + " (" + string(myPetInfo[petTraining][1]) + ") can not be trained any further." + string(_petText));
                petTraining = 0;
            }
            else if (mygold >= obj_build_creaturekeeper.goldCost && myfood >= obj_build_creaturekeeper.foodCost)
            {
                mygold -= ceil(obj_build_creaturekeeper.goldCost);
                myfood -= ceil(obj_build_creaturekeeper.foodCost);
                
                if (myPetInfo[petTraining][5] < myPetInfo[petTraining][6])
                {
                    myPetInfo[petTraining][5] += ceil(((obj_build_creaturekeeper.foodCost + obj_build_creaturekeeper.goldCost) / 100) * (1 + global.corruptionShardEffect[12]));
                    show_debug_message(string(name) + " Pet #" + string(petTraining) + " " + string(myPetInfo[petTraining][4]) + " training tick (" + string(myPetInfo[petTraining][5]) + "/" + string(myPetInfo[petTraining][6]) + ")");
                }
                else
                {
                    myPetInfo[petTraining][4] += 1;
                    var _str = "";
                    
                    if ((myPetInfo[petTraining][4] % 10) == 0)
                        _str = " and unlocked a new Relic Slot";
                    
                    gml_Script_twitch_chat_say("/me " + string(name) + " Pet #" + string(petTraining) + " (" + string(myPetInfo[petTraining][1]) + ") evolved to level " + string(myPetInfo[petTraining][4]) + _str + "! (+5%[+] Relic effect on all unlocked slots)");
                    myPetInfo[petTraining][5] -= myPetInfo[petTraining][6];
                    myPetInfo[petTraining][6] = myPetInfo[petTraining][4] * 1000 * myPetInfo[petTraining][4];
                    
                    if (myPetInfo[petTraining][4] >= 5 && diaryQuest[49][0] < 5)
                        gml_Script_scr_addDiaryProgress(10, 4);
                    
                    if (myPetInfo[petTraining][4] >= 10 && diaryQuest[49][0] < 10)
                        gml_Script_scr_addDiaryProgress(10, 5);
                    
                    if (myPetInfo[petTraining][4] >= 20 && diaryQuest[49][0] < 20)
                        gml_Script_scr_addDiaryProgress(10, 10);
                    
                    if (myPetInfo[petTraining][4] >= 30 && diaryQuest[49][0] < 30)
                        gml_Script_scr_addDiaryProgress(10, 10);
                    
                    for (var re = 1; re <= 5; re++)
                    {
                        myPetRelicSlotEffect[petTraining][re] = (0.1 + (0.05 * myPetInfo[petTraining][4])) - (re * 0.5);
                        
                        if (myPetRelicSlotEffect[petTraining][re] < 0)
                            myPetRelicSlotEffect[petTraining][re] = 0;
                    }
                    
                    ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                    ini_write_real("Pets", "My Pet " + string(petTraining) + " Level", myPetInfo[petTraining][4]);
                    ini_write_real("Pets", "My Pet " + string(petTraining) + " XP", myPetInfo[petTraining][5]);
                    ini_close();
                }
            }
            else
            {
                ini_open(string(global.platformDir) + string(myCharDir) + "Data.ini");
                ini_write_real("Pets", "My Pet " + string(petTraining) + " XP", myPetInfo[petTraining][5]);
                ini_write_real("Pets", "My Pet Training", 0);
                ini_close();
                var _petText = "";
                
                if (myPetID == 0)
                {
                    myPetID = petTraining;
                    _petText = " Pet #" + string(myPetID) + " (" + string(myPetInfo[myPetID][1]) + " - lv." + string(myPetInfo[myPetID][4]) + ") is now your companion.";
                    
                    if (myPlayerPet != 0)
                    {
                        with (myPlayerPet)
                            instance_destroy();
                    }
                    
                    myPlayerPet = instance_create_depth(x, y, depth - 1, obj_petPlayer);
                    
                    with (myPlayerPet)
                    {
                        player = other.id;
                        type = other.myPetID;
                    }
                }
                
                gml_Script_twitch_chat_say("/me " + string(name) + " You do not have enough resources to maintain the training for your Pet #" + string(petTraining) + " (" + string(myPetInfo[petTraining][1]) + ") so the training has stopped." + string(_petText));
                petTraining = 0;
            }
        }
    }
    
    gml_Script_scr_alarm_start(0, room_speed, gml_Script_scr_creatureKeeper_train);
};
