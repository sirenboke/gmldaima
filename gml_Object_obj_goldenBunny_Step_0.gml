if (image_xscale == 1)
    x -= (0.2 * global.roomSpeed);

if (image_xscale == -1)
    x += (0.2 * global.roomSpeed);

part_emitter_region(global.light_partsys, global.aura_partemitter, x - 10, x + 10, y - 50, y, 1, 0);
part_emitter_burst(global.light_partsys, global.aura_partemitter, global.aura_part, 1);

with (obj_trees)
{
    if (depth < other.depth)
    {
        if (distance_to_object(obj_goldenBunny) < 50)
            alpha = 0.2 + (distance_to_object(obj_goldenBunny) / 50);
    }
}

if (hp <= 0)
{
    global.creditsBunnies += 1;
    gml_Script_twitch_chat_say("/color GoldenRod");
    gml_Script_twitch_chat_say_direct("/me You found a Golden Bunny (" + string(global.creditsBunnies) + "/" + string(global.totalBunnies) + ")! Everyone in the Town got " + gml_Script_scr_bigNumber(lootPoints) + " room00Talent and the Town gained " + gml_Script_scr_bigNumber(lootGold) + " gold and " + gml_Script_scr_bigNumber(lootGems) + " room00Gem !");
    gml_Script_twitch_chat_say("/color FireBrick");
    gml_Script_scr_playsound(s_goldenBunnyLoot1, 1, 1.2, 1);
    gml_Script_scr_playsound(s_levelUp3, 1, 1.2, 1);
    global.gold = gml_Script_scr_addValue(global.gold, lootGold);
    global.gems += lootGems;
    
    repeat (25)
    {
        with (gml_Script_instance_create(x, y, obj_goldDrop2))
            value = 1;
        
        with (gml_Script_instance_create(x, y, obj_scroll))
            value = 1;
    }
    
    with (obj_player)
    {
        if (ascended == false)
        {
            skillPoints += other.lootPoints;
            totalSkillPoints += other.lootPoints;
        }
    }
    
    obj_twitch.alarm[0] = room_speed;
    instance_destroy();
}
