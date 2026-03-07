if (result != -1)
{
    if (!instance_exists(obj_combatGraphs))
    {
        with (gml_Script_instance_create(x, y, obj_combatGraphs))
            result = other.result;
    }
}
