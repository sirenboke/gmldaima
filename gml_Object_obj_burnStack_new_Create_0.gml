alarm[0] = 1;

if (!variable_instance_exists(id, "duration"))
    duration = room_speed;
else
    duration *= room_speed;

if (variable_instance_exists(id, "warrior"))
{
    if (instance_exists(warrior))
    {
        if (variable_instance_exists(warrior, "statusDurationBonus"))
            duration *= warrior.statusDurationBonus;
    }
}

if (instance_exists(target))
    duration *= target.myResistance[2][1];

if (duration <= 0 || !variable_instance_exists(id, "player") || !variable_instance_exists(id, "target"))
{
    instance_destroy();
    exit;
}

if (duration < 1)
    duration = 1;

alarm[1] = duration;
alarm[2] = room_speed / 5;
image_xscale = 2;
image_yscale = 2;
image_index = 0;
image_speed = 0.2;
totalstacks = 0;
stackOwners = array_create(0);
stackDamage = array_create(0);
stackTimestamp = array_create(0);
totalBurnInstances = 0;
var _dmgPerStack = dmg;

for (var i = 0; i < fireStacks; i++)
{
    array_push(stackOwners, player);
    array_push(stackDamage, _dmgPerStack);
    array_push(stackTimestamp, current_time);
    totalBurnInstances++;
}

dmg *= fireStacks;
var _id = id;
expired = false;

if (instance_exists(target))
{
    with (target)
    {
        var _burnsExpiring = 0;
        
        with (obj_burnStack_new)
        {
            if (target == other.id && id != _id)
            {
                if (alarm[1] > -1 && alarm[1] < (room_speed * 0.5))
                    _burnsExpiring++;
            }
        }
        
        if (_burnsExpiring > 0)
        {
            expired = true;
            
            if (global.dev)
                show_debug_message("🔥 BURN CANCELED - Another burn is expiring (preventing inheritance)");
            
            with (_id)
                instance_destroy();
            
            exit;
        }
    }
}
