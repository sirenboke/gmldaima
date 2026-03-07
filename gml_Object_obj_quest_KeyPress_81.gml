if (global.dev && !global.console)
{
    gml_Script_instance_create(x, y, obj_quest);
    instance_destroy();
}
