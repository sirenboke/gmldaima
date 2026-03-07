self.instance_deactivate_all_hook = function(arg0)
{
    instance_deactivate_all(arg0);
    instance_activate_object(obj_gmlive);
};

self.instance_deactivate_layer_hook = function(arg0)
{
    instance_deactivate_layer(arg0);
    instance_activate_object(obj_gmlive);
};

self.instance_deactivate_object_hook = function(arg0)
{
    instance_deactivate_object(arg0);
    instance_activate_object(obj_gmlive);
};

self.instance_deactivate_region_hook = function(arg0, arg1, arg2, arg3, arg4, arg5)
{
    instance_deactivate_region(arg0, arg1, arg2, arg3, arg4, arg5);
    instance_activate_object(obj_gmlive);
};
