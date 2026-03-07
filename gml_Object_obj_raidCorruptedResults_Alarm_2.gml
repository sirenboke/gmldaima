gml_Script_twitch_chat_say_direct("/me You restored Sector " + string(global.corruptedSector) + ":" + string(global.corruptedLevel) + ". You can now consume a Corruption Shard with !vote#.");

if (result != -1)
{
    if (!instance_exists(obj_combatGraphs))
    {
        with (gml_Script_instance_create(x, y, obj_combatGraphs))
            result = other.result;
    }
}

if (result != 1)
{
    alarm[1] = room_speed * 60;
    global.usedCorruptedRewards = [];
    
    for (var i = 0; i < 3; i++)
    {
        with (instance_create_layer((room_width / 2) - 250 - 400, (room_height / 2) - 100, "Cards", obj_corruptedCard))
        {
            myID = i;
            x += (400 * myID);
        }
    }
}

with (obj_raidCorrupted)
{
    alarm[0] = -1;
    alarm[1] = -1;
    
    for (var i = 0; i < 4; i++)
    {
        challenge[i] = -1;
        global.globalChallengeValue[i] = -1;
    }
}

if (instance_exists(obj_corruptedIsland))
{
    with (obj_corruptedIsland)
        votes = 0;
}

global.challenge_canSwitch = 1;
global.challenge_canPot = 1;
global.challenge_relicEffect = 1;
global.challenge_petRelicEffect = 1;
global.challenge_enemyCollision = 0;
obj_corruptedControl.accepted = false;
