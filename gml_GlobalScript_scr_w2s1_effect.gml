self.scr_w2s1_effect = function()
{
    gml_Script_instance_create(x, y, obj_pusher);
    alarm[2] = -1;
    show_debug_message("shield master ended");
};
