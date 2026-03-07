if (showText < maxShowText)
{
    showText += 1;
    
    if (showText != 9 && showText != 11 && showText != 13 && showText != 14)
        gml_Script_scr_playsound(s_executeDemon, 0.9, 1.1, 1);
    
    alarm[1] = room_speed * 2;
}
