for (var ui = 1; ui <= global.maxUniqueItems; ui += 1)
{
    equippedUniqueItem[ui] = player.equippedUniqueItem[ui];
    uniqueItemLevel[ui] = player.uniqueItemLevel[ui];
}

ascended = player.ascended;
raidPos = player.raidPos;
myPetID = player.myPetID;

if (myPetID != 0)
{
    with (gml_Script_instance_create(x, y, obj_pet))
    {
        other.pet = id;
        player = other.id;
        depth = other.depth - 1;
        type = other.myPetID;
        alarm[2] = 1;
        ability = other.player.myPetInfo[other.myPetID][2];
        level = other.player.myPetInfo[other.myPetID][4];
    }
}
else
{
    pet = 0;
}

if (global.djinnInfo[3][0] == 1)
{
    maxStamina *= (1 + (global.djinnInfo[3][2] / 100));
    baseSpeed *= (1 + (global.djinnInfo[3][2] / 100));
    moveSpeed *= (1 + (global.djinnInfo[3][2] / 100));
    omoveSpeed *= (1 + (global.djinnInfo[3][2] / 100));
    show_debug_message("Energy and speed multiplied by Djinn");
}

raidType = player.raidType;
maxPos = 700;

if (raidType == 0)
    maxPos = 700;

if (raidType == 1)
    maxPos = 560;

for (var i = 0; i <= global.damageTypes; i++)
{
    omyResistance[0][i] = player.myResistance[0][i];
    myResistance[0][i] = omyResistance[0][i];
    omyDamage[i] = player.myDamage[i];
    myDamage[i] = omyDamage[i];
}

for (var i = 0; i <= 1; i++)
{
    omyResistance[1][i] = player.myResistance[1][i];
    myResistance[1][i] = omyResistance[1][i];
    omyResistance[2][i] = player.myResistance[2][i];
    myResistance[2][i] = omyResistance[2][i];
}

otierReduction = player.myTier;
tierReduction = otierReduction;
show_debug_message("Dmg buff = " + string(myDamage[0]));
extraSpeed = player.extraSpeed;
omoveSpeed *= (1 + extraSpeed);

if (string(class) == "rogue")
    omoveSpeed *= 1.3;

moveSpeed = omoveSpeed;
tempNumber = player.tempNumber;
relicRegen = 0;
player.getRaidItems = true;
potion = 1 + player.myTier;
myAura = player.myAura;
cantMiss = false;
pierce = false;

if (class == "warrior")
{
    scr_attack = gml_Script_scr_attack_melee;
    s_attack = s_attack1;
    maxmana = 10;
    orng = 20;
    myAlarm = 1;
}

if (class == "rogue")
{
    scr_attack = gml_Script_scr_attack_melee;
    s_attack = s_attack1;
    maxmana = 10;
    orng = 10;
    myAlarm = 1;
}

if (class == "farmer")
{
    scr_attack = gml_Script_scr_attack_melee;
    s_attack = s_attack1;
    maxmana = 15;
    orng = 10;
    myAlarm = 1;
}

if (class == "archer")
{
    scr_attack = gml_Script_scr_attack_ranged;
    spr_rangedTorso = spr_archerTorso;
    spr_rangedLegs = spr_archerLegs;
    s_attack = s_arrow1;
    myAlarm = 6;
    maxmana = 10;
    orng = 750;
    
    if (ds_list_size(global.raidListMelee) > 0)
    {
        myDamage[0] = omyDamage[0] + 0.1;
    }
    else
    {
        myDamage[0] = omyDamage[0];
        gml_Script_scr_statChange(0.1, -1, 11, undefined, undefined);
    }
}

if (class == "mage")
{
    scr_attack = gml_Script_scr_attack_ranged;
    spr_rangedTorso = spr_wizardTorso;
    spr_rangedLegs = spr_wizardLegs;
    s_attack = s_electric2;
    myAlarm = 1;
    maxmana = 10;
    orng = 450;
}

avi = player.avatar;
spr_idle = player.spr_idle;
spr_move = player.spr_move;
spr_attack = player.spr_attack;
spr_dead = player.spr_dead;
sprite_index = spr_move;
spr_cast = spr_idle;
specialized = player.specialized;

for (var s = 0; s <= 2; s++)
    classSpecialization[s] = 0;

if (specialized > 0)
{
    if (class == "mage")
    {
        spr_rangedTorso = asset_get_index("spr_wizardTorso" + string(specialized));
        spr_rangedLegs = asset_get_index("spr_wizardLegs" + string(specialized));
        
        if (specialized == 2)
            s_attack = s_swordAttack1;
        
        if (specialized == 3)
            s_attack = s_spark1;
    }
}

myAbilityInfo[0] = player.myAbilityInfo[0];

for (var _a = 0; _a < 10; _a++)
    myAbilityInfo[_a] = player.myAbilityInfo[_a];

show_debug_message(myAbilityInfo[1]);

if (specialized != 0)
{
    for (var i = 0; i < global.globalSpecialBranches; i += 1)
    {
        var _extraPoints = floor(player.mySpecialInfo[player.classType][specialized - 1][myAbilityInfo[0]][i] / 3);
        mySpecialBuff[i] = (player.mySpecialInfo[player.classType][specialized - 1][myAbilityInfo[0]][i] + _extraPoints) * global.globalSpecialInfo[player.classType][specialized - 1][myAbilityInfo[0]][i][2];
        show_debug_message("Special Points total effect on Branch " + string(i) + ": " + string(mySpecialBuff[i]));
    }
    
    if (class == "warrior" && specialized == 2)
    {
        orng = 300;
        scr_attack = gml_Script_scr_attack_ranged;
    }
}

image_index = irandom(image_number - 1);
buffed = 0;

for (var i = 0; i < 10; i++)
{
    for (var ii = 0; ii < 5; ii++)
        myStatInfo[i][ii] = player.myStatInfo[i][ii];
    
    myStatInfo[i][1] = myStatInfo[i][3];
    myStatInfo[i][2] = myStatInfo[i][3];
    myStatInfo[i][5] = myStatInfo[i][4] * 5;
}

myStatInfo[7][5] = 100;
myStatInfo[1][5] = 30;
myStatInfo[2][5] = 100;
rng = orng;
mana = myStatInfo[4][3] / 2;

if (mana > (maxmana / 2))
    mana = maxmana / 2;

level = player.level;
maxxp = player.maxxp;
xp = player.xp;
raids = player.raids;
mygold = 0;
honor = player.honor;
kills = player.kills;
hp = player.hp;

if (room == r_corrupted)
{
    show_debug_message("Checking if must reduce stats...");
    var _chall = 0;
    
    for (var c = 0; c < obj_raidCorrupted.challengeAmount; c++)
    {
        if (obj_raidCorrupted.challenge[c] == 8)
        {
            var _challValue = 1 - global.globalChallengeValue[c];
            show_debug_message("Reducing all stats by " + string(_challValue) + "!");
            
            for (var i = 0; i < 10; i++)
            {
                myStatInfo[i][1] *= _challValue;
                myStatInfo[i][2] *= _challValue;
                myStatInfo[i][3] *= _challValue;
                myStatInfo[i][4] *= _challValue;
                myStatInfo[i][5] *= _challValue;
            }
            
            hp *= _challValue;
        }
    }
}

if (hp > myStatInfo[8][3])
    hp = myStatInfo[8][3];

displayHP = myStatInfo[8][3];
dmgReflection = 0;
omaxshield = 0;
maxshield = omaxshield;
oshieldCapacity = 0;
shieldCapacity = oshieldCapacity;
shield = 0;
regenShieldMax = 0;
regenShield = 0;
decayableShield = 0;
shieldDecayTimer = 0;
shieldDecayDelay = (room_speed / 5) * 3;
shieldDamageAccumulator = 0;
length = sprite_width / 2;
height = sprite_height;
y = room_height - 20;
myRaidingLevel = player.myRaidingLevel;
myGuardLevel = player.myGuardLevel;
resurrect = 0;
resTimer = gml_Script_scr_relicEffect(player, 0, 1);

if (resTimer > 0)
    resurrect = 1;

oshieldCapacity = gml_Script_scr_relicEffect(player, oshieldCapacity, 3);

if (oshieldCapacity > 0)
{
    shieldCapacity = oshieldCapacity;
    omaxshield = floor(myStatInfo[8][3] * shieldCapacity);
    maxshield = omaxshield;
    shield = 0;
}

abilityCastTime = myAbilityInfo[9];
abilityCastTime /= (1 + gml_Script_scr_relicEffect(player, 1, 4));
myDamage[3] *= 1 + (gml_Script_scr_relicEffect(player, 0, 20) * 10);
show_debug_message("Special damage bonus: " + string(myDamage[3]));
statusDurationBonus *= (1 + (gml_Script_scr_relicEffect(player, 0, 20) * 10));
abilityCastTime = round(abilityCastTime);

if (abilityCastTime < 1)
    abilityCastTime = 1;

abilityDurationBonus += gml_Script_scr_relicEffect(player, 0, 19);
show_debug_message("Ability duration multiplier: " + string(abilityDurationBonus) + "x");
show_debug_message(string(name) + ": (" + string(id) + ")");
relic18dmg = hpRegenHeal * gml_Script_scr_relicEffect(player, 0, 18);
fightKills = 0;
fightHonor = 0;
fightGold = 0;
showNumber = ds_list_find_index(raidList, myRaidNumber);
totalListNumber = ds_list_size(raidList);
showHitDMG = player.showHitDMG;

if (myRaidNumber == 0)
    raidAction = "fighting";

if (myRaidNumber > 0)
    raidAction = "alive";

if (myRaidNumber < 0)
    raidAction = "defeated";

gml_Script_scr_alarm_start(1, room_speed, gml_Script_scr_initializeStats);

if (player.myTier == 0)
    textColor = 16777215;

if (player.myTier == 1)
    textColor = 65535;

if (player.myTier == 2)
    textColor = 4235519;

if (player.myTier == 3)
    textColor = 16777215;

mask_index = spr_warrior_idle;
