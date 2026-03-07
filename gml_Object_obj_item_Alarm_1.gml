status *= (1 + (global.hunterGuildLevel / 20));
tierChance = clamp(irandom_range(status * 0.7, status * 1.2), 0, 2000);

if (irandom(9) < 3)
    tierChance /= random_range(1.5, 3);

tierChance = round(tierChance);
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

if (tier < 14)
{
    upgChance = irandom_range(0, (tier * 6) + tier);
    
    if (upgChance == 0)
        tier += 1;
}

level -= (global.hunterGuildLevel * 2);

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

level += subTier;

if (level <= 0)
    level = 1;

image_index = tier;
