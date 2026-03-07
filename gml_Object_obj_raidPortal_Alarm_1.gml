gml_Script_scr_clearDeathRain();
instance_destroy(obj_tempStat);

if (room == r_underworld)
{
    if (global.portalStage < 8)
    {
        maxEnemies = round(30 + (global.portalStage / 10));
        gml_Script_twitch_chat_say("/color BlueViolet");
        gml_Script_twitch_chat_say_direct("/me Currently on Floor " + string(0 - (global.portalStage - 1)) + ".");
        gml_Script_twitch_chat_say("/color FireBrick");
    }
    else
    {
        maxEnemies = 0;
        gml_Script_twitch_chat_say("/color BlueViolet");
        gml_Script_twitch_chat_say_direct("/me Currently on the Core of the Underworld.");
        gml_Script_twitch_chat_say("/color FireBrick");
    }
    
    enemies = 0;
    global.extraRewardsTimerMax = 90 + (global.portalStage * 30);
    
    if (global.portalStage == 8)
        global.extraRewardsTimerMax = 60;
}

if (room == r_underworld_new)
{
    if (global.portalTower < 5)
        gml_Script_twitch_chat_say_direct("/me Currently on Tower " + string(global.portalTower) + ", Floor " + string(global.portalFloor) + ".");
    else
        gml_Script_twitch_chat_say_direct("/me Currently in the Underworld Core.");
    
    maxEnemies = round(20 + (global.portalTower * 10) + (global.portalFloor * 5));
    enemies = 0;
    global.extraRewardsTimerMax = 300 - (global.portalTower * 30);
    global.maxPortalFloor = 4 + global.portalTower;
    
    if (global.onlyFinis == 1)
        maxEnemies = 0;
}

global.portalTimerMax = 300 - (global.portalTower * 30);
global.portalTimer -= 60;

if (global.portalTimer < 0)
    global.portalTimer = 0;

if (global.dev == 1)
    global.portalTimerMax = 100000;

if (global.onlyFinis == 1)
    global.portalTimerMax = 0;

if (global.portalFloor == 1)
    global.portalTimer = 0;

global.stage = global.portalTower * 200 * (1 + (global.portalFloor / 10)) * (1 + (global.portalTower / 10));
gml_Script_scr_playsound(s_portalClose, 0.9, 1.1, 0.2);
global.extraRewardsTimer = 0;
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
var chest = choose(0, 1, 2);

if (chest == 0)
    gml_Script_instance_create(random_range(room_width + 100, room_width + 500), room_height - 20, obj_chest);

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
