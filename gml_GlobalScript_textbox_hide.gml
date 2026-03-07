self.textbox_hide = function(arg0)
{
    if (arg0 == true)
    {
        if (instance_exists(textbox))
        {
            with (textbox)
            {
                textbox_visible = false;
                gml_Script_instance_deactivate_object_hook(option_object1);
                gml_Script_instance_deactivate_object_hook(option_object2);
                gml_Script_instance_deactivate_object_hook(option_object3);
            }
        }
    }
    else if (instance_exists(textbox))
    {
        with (textbox)
        {
            textbox_visible = true;
            instance_activate_object(option_object1);
            instance_activate_object(option_object2);
            instance_activate_object(option_object3);
        }
    }
};
