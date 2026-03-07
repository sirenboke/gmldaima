if (instance_exists(from))
{
    x = from.x;
    first = from.first;
}
else
{
    instance_destroy();
}

if (global.stageType == "Grassland" || global.stageType == "Snow Trail")
{
    if (!instance_exists(obj_stageTransition))
        alpha = 0.1 + (obj_fog.light / 215);
    
    if (global.stageType == "Grassland")
        image_index = 0;
    
    if (global.stageType == "Snow Trail")
        image_index = 4;
}

if (room != r_1)
    alpha = 0;

image_alpha = alpha;
