if (used == false)
{
    with (obj_player)
    {
        if (getRaidItems == true)
        {
            if (level >= other.level)
            {
                if (myItemInfo[other._itemType][0] < other.tier || (myItemInfo[other._itemType][0] == other.tier && myItemInfo[other._itemType][1] < other.subTier))
                {
                    myItemInfo[other._itemType][0] = other.tier;
                    myItemInfo[other._itemType][1] = other.subTier;
                    
                    with (other)
                        equipped = true;
                    
                    gml_Script_scr_playsound(choose(s_equip1, s_equip2, s_equip3, s_equip4), 0.9, 1.1, 1);
                }
            }
        }
    }
}

alarm[2] = room_speed;
