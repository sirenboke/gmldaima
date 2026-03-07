inShop = true;

if (itemType == 0)
{
    tierChance = irandom_range(status * 0.6, status * 1.1);
    
    if (irandom(9) < 3)
        tierChance /= random_range(1.5, 3);
    
    c1 = 16777215;
    tier = 1;
    level = irandom_range(1, 5);
    
    if (tierChance >= 10)
    {
        tier = 2;
        level = irandom_range(1, 10);
    }
    
    if (tierChance >= 20)
    {
        tier = 3;
        level = irandom_range(5, 20);
    }
    
    if (tierChance >= 50)
    {
        tier = 4;
        level = irandom_range(30, 50);
    }
    
    if (tierChance >= 80)
    {
        tier = 5;
        level = irandom_range(60, 80);
    }
    
    if (tierChance >= 120)
    {
        tier = 6;
        level = irandom_range(90, 110);
    }
    
    if (tierChance >= 170)
    {
        tier = 7;
        level = irandom_range(120, 150);
    }
    
    if (tierChance >= 230)
    {
        tier = 8;
        level = irandom_range(160, 190);
    }
    
    if (tierChance >= 300)
    {
        tier = 9;
        level = irandom_range(200, 240);
    }
    
    if (tierChance >= 400)
    {
        tier = 10;
        level = irandom_range(250, 300);
    }
    
    if (tierChance >= 550)
    {
        tier = 11;
        level = irandom_range(350, 450);
    }
    
    if (tierChance >= 700)
    {
        tier = 12;
        level = irandom_range(500, 700);
    }
    
    if (tierChance >= 1000)
    {
        tier = 13;
        level = irandom_range(800, 1000);
    }
    
    subTierChance = irandom(9);
    subTier = 1;
    tierText = "I";
    
    if (subTierChance > 5)
    {
        subTier = 2;
        tierText = "II";
    }
    
    if (subTierChance > 8)
    {
        subTier = 3;
        tierText = "III";
    }
    
    cost = 20 + round((power(tier, 6) + power(subTier + 1, (tier / 2) + 1) + irandom_range(tier * 10, tier * 50)) * power(1 + (tier / 1.8), 2));
    cost -= (10 * power(obj_build_shop.level, 1.5));
    
    if (cost < 25)
        cost = 25;
    
    if (cost >= 1000000)
    {
        cost = ceil(cost / 1000000) * 1000000;
        costText = gml_Script_scr_bigNumber(ceil(cost / 1000000));
    }
    else
    {
        costText = gml_Script_scr_bigNumber(ceil(cost));
    }
    
    if (tier < 13)
    {
        upgChance = irandom_range(0, (tier * 6) + tier);
        
        if (upgChance == 0)
            tier += 1;
    }
    
    if (tier <= 7)
    {
        sprite_index = spr_newItems;
        tierImage = 1;
    }
    else
    {
        sprite_index = spr_newItems_tier2;
        tierImage = 2;
    }
    
    level *= 3;
    level -= (obj_build_shop.level * 10);
    
    if (level <= 0)
        level = 1;
    
    image_index = tier;
    type = "Item " + string(_itemType);
    name = global.globalItemInfo[_itemType][0];
    obj_build_shop.itemLevel[number] = level;
    obj_build_shop.itemType[number] = type;
    obj_build_shop._itemType[number] = _itemType;
    obj_build_shop.itemTier[number] = tier;
    obj_build_shop.itemSubTier[number] = subTier;
    obj_build_shop.itemTierText[number] = tierText;
}

if (itemType == 1)
{
    upgChance = -1;
    c1 = 4235519;
    cost = 2;
    obj_build_shop.itemNumber[number] = image_index;
    obj_build_shop.itemAmount[number] = amount;
    
    with (obj_player)
        boughtItem[other.number] = other.amount;
}

obj_build_shop.itemCost[number] = cost;
obj_build_shop.itemRealType[number] = itemType;
obj_build_shop.itemName[number] = name;
