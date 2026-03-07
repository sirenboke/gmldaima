self.instance_create = function(arg0, arg1, arg2)
{
    var myDepth = gml_Script_object_get_depth(arg2);
    return instance_create_depth(arg0, arg1, myDepth, arg2);
};
