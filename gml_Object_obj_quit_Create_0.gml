if (show_question("Save and quit?"))
{
    with (instance_create_depth(x, y, -10000, obj_transition_out))
        blank = true;
}
else
{
    global.closing = false;
    instance_destroy();
}
