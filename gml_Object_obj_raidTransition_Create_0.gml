alpha = 0;
in = true;
ended = false;
randQuote = global.startQuotes[irandom(global.startMaxQuotes)];
lastRoom = room;
audio_sound_gain(obj_gameControl.theme, 0, 3000);
event_inherited();

if (instance_exists(obj_combatGraphs))
{
    with (obj_combatGraphs)
    {
        if (alarm[0] != -1)
            alarm[0] = room_speed;
    }
}
