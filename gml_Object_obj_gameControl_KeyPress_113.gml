global.console = !global.console;

if (!instance_exists(obj_console))
{
    instance_create_depth(0, 200, depth - 1, obj_console);
    global.console = true;
}
else
{
    instance_destroy(obj_console);
    global.console = false;
}
