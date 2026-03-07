if (global.totalCorruption >= 100)
{
    gml_Script_twitch_chat_say_direct("/me The Final War will begin in 10 minutes... You can feel the ground tremble beneath your feet as millions of demonic creatures invade the world you tried to save. Everyone get ready to fight! (no commands needed to join, just make sure you have your desired build equipped!)");
    obj_raid.alarm[9] = room_speed * 600;
    obj_raid.alarm[4] = -1;
    global.finalWar = true;
    obj_fog.alarm[3] = room_speed * 300;
}
