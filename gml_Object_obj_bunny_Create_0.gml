event_inherited();
image_speed = 0.1 * global.roomSpeed;

if (x < (room_width / 2))
    image_xscale = -1;

if (x > (room_width / 2))
    image_xscale = 1;

var shiny = irandom(10000);

if (shiny == 0)
{
    global.totalBunnies += 1;
    gml_Script_instance_create(x, y, obj_goldenBunny);
    instance_destroy();
}
else
{
    if (global.keeperBuilt == 1)
    {
        var pet = irandom(20);
        
        if (global.raiding)
        {
            if (pet == 0 && !instance_exists(obj_wildPet))
            {
                gml_Script_instance_create(x, y, obj_wildPet);
                instance_destroy();
            }
        }
    }
    
    if (choose(0, 1) == 0)
        instance_destroy();
}
