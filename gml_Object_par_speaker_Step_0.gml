var dr = detection_radius;

if (point_in_rectangle(playerobject.x, playerobject.y, x - dr, y - dr, x + dr, y + dr))
{
    if (myTextbox != -4)
    {
        if (!instance_exists(myTextbox))
        {
            myTextbox = -4;
            exit;
        }
    }
    else if (keyboard_check_pressed(interact_key))
    {
        if (instance_exists(obj_textbox))
            exit;
        
        event_user(0);
        gml_Script_create_dialogue(myText, mySpeaker, myEffects, myTextSpeed, myTypes, myNextLine, myScripts, myTextCol, myEmotion, myEmote);
    }
}
else if (myTextbox != -4)
{
    with (myTextbox)
        instance_destroy();
    
    myTextbox = -4;
}
