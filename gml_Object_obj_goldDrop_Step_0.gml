if (place_meeting(x, y, obj_warrior))
{
    target = instance_nearest(x, y, obj_warrior);
    global.creditsGold += value;
    global.raidGold += value;
    audio_play_sound(s_goldbag2, 0, 0);
    instance_destroy();
}

if (x < -10)
    instance_destroy();

if (y < (room_height - 20))
    y += (1 * global.roomSpeed);

if (y > (room_height - 20))
    y = room_height - 20;
