show_debug_message("Enemy level: " + string(level));
gml_Script_scr_setAbility(skill);
icon = 0;

if (spr_idle == spr_enemy3)
    icon = 0;

if (spr_idle == spr_enemy4)
    icon = 1;

if (spr_idle == spr_skeleton1Idle)
    icon = 2;

if (spr_idle == spr_skeleton2Idle)
    icon = 3;

if (spr_idle == spr_skeleton3Idle)
    icon = 4;

if (spr_idle == spr_skeleton4Idle)
    icon = 5;

if (spr_idle == spr_skeleton5Idle)
    icon = 6;

if (spr_idle == spr_skeleton6Idle)
    icon = 7;

if (spr_idle == spr_mosquito1Idle)
    icon = 8;

if (spr_idle == spr_mosquito2Idle)
    icon = 9;

if (spr_idle == spr_bearIdle)
    icon = 10;

if (spr_idle == spr_bearIdle2)
    icon = 11;

if (spr_idle == spr_portalBoss1Idle)
    icon = 12;

if (spr_idle == spr_boss1)
    icon = 15;

if (spr_idle == spr_finis_idle)
    icon = 13;

if (spr_idle == spr_mosquitoBoss1Idle)
    icon = 14;

var _scalingSource = global.stage;

if (room == r_underworld)
    _scalingSource = global.portalStage * 200;

if (room == global.room_underworld && type != "final")
    type = "demon";

var _tierText = " ";
myStatInfo[3][2] += ((_scalingSource / 50) + power(1.002, _scalingSource));

if (hasCollision == 1)
{
    if (global.challenge_enemyCollision > 0 && global.challenge_enemyCollision >= random_range(0, 1))
        hasCollision = 0;
}

if (class != "alpha" && class != "boss")
{
    if (_scalingSource >= 10)
    {
        var _exponentialIncrease = power(_scalingSource, 1.005) - _scalingSource;
        
        for (var _elite = 0; _elite < 5; _elite++)
        {
            if (clamp(irandom(99 - _exponentialIncrease), 0, 99) == 0)
            {
                show_debug_message("Rolled Elite w/ " + string(_exponentialIncrease) + "% chance!");
                _exponentialIncrease /= 2;
                
                if (_exponentialIncrease < 0)
                    _exponentialIncrease = 0;
                
                tier += 1;
                
                if (tier > 6)
                    tier = 6;
                
                if (_scalingSource < (tier * 500))
                    break;
            }
        }
    }
}

myStatInfo[8][2] *= (1 + ((global.underworldLevel - 1) * 0.05 * (1 + (global.underworldLevel / 5))));
myStatInfo[8][3] = myStatInfo[8][2];

if (tier > 6)
    tier = 6;

for (var t = 1; t < tier; t++)
{
    tierReduction *= (t + 1);
    _tierText += "I";
    myStatInfo[0][2] *= 2;
    myStatInfo[3][2] *= (t + 1);
    myStatInfo[8][2] *= (t + 1);
    myStatInfo[9][2] *= 2;
    size += 0.25;
    show_debug_message("Enemy " + string(name) + " tier stats evolved to tier " + string(t + 1));
    
    for (var i = 0; i <= global.damageTypes; i++)
    {
        omyResistance[0][i] -= 0.1;
        
        if (omyResistance[0][i] < 0)
            omyResistance[0][i] = 0;
    }
    
    for (var i = 0; i <= 1; i++)
    {
        omyResistance[1][i] -= 0.05;
        omyResistance[2][i] -= 0.05;
        
        if (omyResistance[1][i] < 0.01)
            omyResistance[1][i] = 0.01;
        
        if (omyResistance[2][i] < 0.01)
            omyResistance[2][i] = 0.01;
    }
}

if (_tierText == " IIII")
    _tierText = " IV";

if (_tierText == " IIIII")
    _tierText = " V";

if (_tierText != " ")
    name += _tierText;

value = level * tier;

if (class == "boss")
    value *= 5;

maxStamina *= tier;
maxStamina *= global.challenge_enemyStamina;
stamina = maxStamina;
myStatInfo[8][2] *= global.challenge_enemyConst;
myStatInfo[0][3] = myStatInfo[0][2];
myStatInfo[3][3] = myStatInfo[3][2];
myStatInfo[8][3] = myStatInfo[8][2];
myStatInfo[9][3] = myStatInfo[9][2];

if (type != "final")
    hp = myStatInfo[8][3];

if (global.newUnderworld == true)
{
    if (type == "final")
    {
        if (global.portalTower < 5)
        {
            hp = myStatInfo[8][3];
        }
        else
        {
            if (hp < myStatInfo[8][3])
                hp *= (1 + ((global.underworldLevel - 1) * 0.05 * (1 + (global.underworldLevel / 5))));
            
            if (hp > myStatInfo[8][3])
                hp = myStatInfo[8][3];
        }
    }
}

for (var i = 0; i < 10; i++)
{
    myStatInfo[i][1] = myStatInfo[i][3];
    myStatInfo[i][2] = myStatInfo[i][3];
    myStatInfo[i][4] = myStatInfo[i][2] * 4;
    myStatInfo[i][5] = myStatInfo[i][4] * 5;
}

myStatInfo[7][5] = 100;
myStatInfo[1][5] = 30;
myStatInfo[2][5] = 100;

for (var i = 0; i <= global.damageTypes; i++)
    myResistance[0][i] = omyResistance[0][i];

for (var i = 0; i <= 1; i++)
{
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

hpRegenHeal = myStatInfo[6][3];
shield = omaxshield;
displayHP = myStatInfo[8][3];
image_xscale = size;
image_yscale = size;
height = sprite_get_height(spr_idle) * image_yscale;
bar_height = y - height;

if (bar_height < (room_height - 230))
    bar_height = room_height - 230;

float_height = bar_height - 15;

if (float_height < (room_height - 230))
    float_height = bar_height + 30;

spr_cast = spr_idle;

if (string_pos("Molestia", name) || string_pos("Fly", name) || string_pos("Queen Mosquito", name))
{
    y = room_height - 120;
    height -= 40;
}

length = sprite_get_width(spr_idle) * image_xscale;
mask_index = spr_idle;
yyy = y;

for (var i = 0; i <= global.damageTypes; i++)
{
    if (omyResistance[0][i] < 0.01)
        omyResistance[0][i] = 0.01;
    
    myResistance[0][i] = omyResistance[0][i];
}

for (var i = 0; i <= 1; i++)
{
    if (omyResistance[1][i] < 0.01)
        omyResistance[1][i] = 0.01;
    
    if (omyResistance[2][i] < 0.01)
        omyResistance[2][i] = 0.01;
    
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

oshieldCapacity = gml_Script_scr_relicEffect(player, oshieldCapacity, 3);

if (oshieldCapacity > 0)
{
    shieldCapacity = oshieldCapacity;
    omaxshield = floor(myStatInfo[8][3] * shieldCapacity);
    maxshield = omaxshield;
    shield = 0;
}

resurrect = 0;
resTimer = gml_Script_scr_relicEffect(player, 0, 1);

if (resTimer > 0)
    resurrect = 1;

relic18dmg = hpRegenHeal * gml_Script_scr_relicEffect(player, 0, 18);
abilityCastTime = myAbilityInfo[9];
abilityCastTime /= (1 + gml_Script_scr_relicEffect(player, 1, 4));
myDamage[3] *= 1 + (gml_Script_scr_relicEffect(player, 0, 20) * 10);
show_debug_message("Special damage bonus: " + string(myDamage[3]));
statusDurationBonus *= (1 + (gml_Script_scr_relicEffect(player, 0, 20) * 10));
abilityCastTime = round(abilityCastTime);

if (abilityCastTime < 1)
    abilityCastTime = 1;

abilityDurationBonus = 1;
abilityDurationBonus += gml_Script_scr_relicEffect(player, 0, 19);
show_debug_message("Ability duration multiplier: " + string(abilityDurationBonus) + "x");
relic13dmgred = gml_Script_scr_relicEffect(player, 0, 13);

if (relic13dmgred > 0)
{
    var _relic13shield = myStatInfo[8][3] * (gml_Script_scr_relicEffect(player, 0, 13) - 1);
    show_debug_message("Relic 13 damage redirection (divided by): " + string(relic13dmgred) + ", shielded for " + string(_relic13shield));
    gml_Script_scr_shield(_relic13shield);
}

if (equippedUniqueItem[21] == 1 && equippedUniqueItem[22] == 1 && equippedUniqueItem[23] == 1)
{
    myDamage[0] += (gml_Script_scr_relicEffect(player, 0, 21) + gml_Script_scr_relicEffect(player, 0, 22) + gml_Script_scr_relicEffect(player, 0, 23)) / 2;
    show_debug_message("Global damage bonus from 3 Odd Stones set: " + string(gml_Script_scr_relicEffect(player, 0, 21) + gml_Script_scr_relicEffect(player, 0, 22) + gml_Script_scr_relicEffect(player, 0, 23)));
}

if (room == r_corrupted)
{
    for (var i = 0; i < obj_raidCorrupted.challengeAmount; i++)
    {
        var _challenge = obj_raidCorrupted.challenge[i];
        var _value = global.globalChallengeValue[i];
        
        switch (_challenge)
        {
            case 1:
                omyResistance[0][1] -= _value;
                myResistance[0][1] -= _value;
                break;
            
            case 2:
                omyResistance[0][2] -= _value;
                myResistance[0][2] -= _value;
                break;
            
            case 3:
                omyResistance[0][3] -= _value;
                myResistance[0][3] -= _value;
                break;
            
            case 23:
                omyResistance[2][0] -= _value;
                myResistance[2][1] -= _value;
            
            case 24:
                omyResistance[1][0] -= _value;
                myResistance[1][1] -= _value;
        }
    }
}
