gml_Script_scr_clearDeathRain();
instance_destroy(obj_tempStat);

if (room == r_corrupted)
{
    var _challengeText = "";
    
    for (var i = 0; i < challengeAmount; i++)
        _challengeText += (" " + string(gml_Script_scr_updateChallengeString(challenge[i], global.globalChallengeValue[i]) + ","));
    
    _challengeText = string_delete(_challengeText, string_last_pos(",", _challengeText), 1);
    gml_Script_twitch_chat_say_direct("/me Currently on the Corrupted Dimension, Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel) + ". Handicaps:" + string(_challengeText) + ".");
    maxEnemies = round((global.corruptedSector * 10) + (global.corruptedLevel * 5));
    enemies = 0;
}

global.portalTimerMax = 300;

if (global.portalTimer < 0)
    global.portalTimer = 0;

global.stage = 4000 + (global.corruptedLevel * 100) + ((global.corruptedSector - 1) * 500 * power(1.1, global.corruptedSector - 1));
gml_Script_scr_playsound(s_portalClose, 0.9, 1.1, 0.2);
ds_list_sort(global.raidList0, true);
ds_list_sort(global.raidList1, true);

with (obj_warrior)
{
    if (ascended == true)
    {
        reposition = ds_list_find_index(raidList, string("Z" + string(raidPos) + string(player.levelRaid) + string(name)));
    }
    else
    {
        if (player.levelRaid < 10)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "A" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 10 && player.levelRaid <= 99)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "B" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 100 && player.levelRaid <= 999)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "C" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 1000 && player.levelRaid <= 9999)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "D" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 10000 && player.levelRaid <= 99999)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "E" + string(player.levelRaid) + string(name)));
        
        if (player.levelRaid >= 100000)
            reposition = ds_list_find_index(raidList, string(string(raidPos) + "F" + string(player.levelRaid) + string(name)));
    }
    
    myRaidNumber = reposition;
    showNumber = reposition;
    mainChar = false;
    
    if (raidList == global.raidList0)
    {
        xx = 400 - (myRaidNumber * 100);
        x = -50 - (myRaidNumber * 100);
        mainChar = true;
    }
    
    if (raidList == global.raidList1)
    {
        xx = 350 - (myRaidNumber * 100);
        x = -100 - (myRaidNumber * 100);
    }
    
    if (ds_list_size(global.raidList0) <= 0)
        mainChar = true;
    
    alarm[11] = room_speed * 90;
}

alarm[0] = room_speed;

with (obj_warrior)
{
    alarm[2] = 1;
    
    if (class == "warrior")
    {
        if (classSpecialization[2] == 1)
        {
            with (obj_warrior)
            {
                if (id != other.id)
                {
                    myStatInfo[3][2] += (other.myStatInfo[3][2] * 0.1);
                    omaxhp += (other.omaxhp * 0.1);
                    myStatInfo[6][2] += (other.myStatInfo[6][2] * 0.1);
                }
            }
        }
    }
}

for (var i = 0; i < challengeAmount; i++)
    gml_Script_scr_applyChallenge(i);

show_debug_message("Checking if Meteor Rain...");
var _chall = 0;

for (var c = 0; c < challengeAmount; c++)
{
    if (challenge[c] == 11)
    {
        var _challValue = global.globalChallengeValue[c];
        show_debug_message("Generating meteor rain at " + string(_challValue) + "% HP per hit!");
        
        with (gml_Script_instance_create(x, y, obj_challengeMeteors))
        {
            dmg = _challValue;
            player = -1;
            spd = room_speed * 5;
            fireStacks = 1;
            slow = 0.1;
            expand = 0.1;
            duration = 3;
            alarm[1] = room_speed * 600;
        }
    }
}
