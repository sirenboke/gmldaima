if (instance_number(obj_textevent) > 1 || instance_number(obj_textbox) > 0)
{
    instance_destroy();
    exit;
}

myVoice = snd_voice2;
myTextCol = 16777215;
myPortrait = -1;
myFont = fnt_dialogue;
myName = "None";
myTextbox = -4;
gml_Script_reset_dialogue_defaults();
