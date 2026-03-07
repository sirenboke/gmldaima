if (global.isTwitch != 0 || global.isKick != 0)
{
    if (instance_exists(obj_confirm) && obj_confirm.alarm[2] == -1)
    {
        if (string_width(string_hash_to_newline(keyboard_string)) < (sprite_width - 32))
            msg = keyboard_string;
        else
            keyboard_string = msg;
    }
}
