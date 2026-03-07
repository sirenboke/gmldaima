if (instance_exists(player))
{
    with (player)
    {
        gml_Script_scr_statChange(other.value, other.Sign, other.type, undefined, undefined, other.cap, other.reducible, other.Return);
        show_debug_message("buff (" + string(other.Sign) + " " + string(other.value) + " on stat " + string(other.type) + ") ended on " + string(name));
    }
}

instance_destroy();
