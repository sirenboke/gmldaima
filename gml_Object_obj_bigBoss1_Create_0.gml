event_inherited();
image_speed = 0.05 * global.roomSpeed;

if (!variable_instance_exists(id, "finalWarSpawn"))
    finalWarSpawn = -1;

var bossType = choose(0, 1, 2);
var _scalingSource = global.bossStage;

if (room == r_1)
{
    if (obj_raid.boss == true)
        _scalingSource = global.bossStage;
    else
        _scalingSource = global.stage;
}

if (room == r_underworld_new || room == r_corrupted)
    _scalingSource = global.stage;

show_debug_message("Boss scaling: " + string(_scalingSource));

if (obj_raid.raidType != 0 || finalWarSpawn != -1)
{
    if (room == r_1)
        bossType = obj_raid.specialRaid[floor(global.stage / 50)][4];
}

if (bossType == 0)
{
    ospr_idle = spr_bearIdle2;
    ospr_move = spr_bearWalk2;
    ospr_attack = spr_bearAttack2;
    ospr_dead = spr_bearDead2;
    name = "Furious Bear";
    attackType = "melee";
    rng = 10;
    myStatInfo[6][2] = 50 + (5 * (((_scalingSource / 5) * _scalingSource) / 4));
    myStatInfo[6][2] *= power(1.1, 1 + (_scalingSource / 100));
    myStatInfo[6][3] = myStatInfo[6][2];
}

if (bossType == 1)
{
    ospr_idle = spr_skeleton6Idle;
    ospr_move = spr_skeleton6Move;
    ospr_attack = spr_skeleton6Attack;
    ospr_dead = spr_skeleton6Dead;
    name = "Undead Knight";
    attackType = "melee";
    rng = 10;
    myStatInfo[6][2] = 20 + (2 * (((_scalingSource / 10) * _scalingSource) / 5));
    myStatInfo[6][2] *= power(1.1, 1 + (_scalingSource / 100));
    myStatInfo[6][3] = myStatInfo[6][2];
    myStatInfo[5][2] = 0.5 * (((_scalingSource / 50) * _scalingSource) / 20);
    myStatInfo[5][3] = myStatInfo[5][2];
}

if (bossType == 2)
{
    ospr_idle = spr_mosquitoBoss1Idle;
    ospr_move = spr_mosquitoBoss1Idle;
    ospr_attack = spr_mosquitoBoss1Attack;
    ospr_dead = spr_mosquitoBoss1Dead;
    name = "Queen Mosquito";
    attackType = "ranged";
    rng = 500 + (_scalingSource / 20);
    myStatInfo[5][2] = 0.5 * (((_scalingSource / 25) * _scalingSource) / 10);
    myStatInfo[5][3] = myStatInfo[5][2];
}

size += 0.25;
spr_idle = ospr_idle;
spr_move = ospr_move;
spr_attack = ospr_attack;
spr_dead = ospr_dead;
sprite_index = spr_move;
state = UnknownEnum.Value_0;
class = "boss";
type = "basic";
maxStamina *= 2;
stamina = maxStamina;

if (room == r_1 || room == r_underworld_new || room == r_corrupted)
    level = round(irandom_range(_scalingSource + 15, _scalingSource + 25) * (1 + (_scalingSource / 25)));

if (room == r_1 && global.enemyRaid == true)
    level = round(_scalingSource / 2) + 3;

myStatInfo[8][2] = 350 + (level * 9.7);
myStatInfo[8][2] *= (1 + (level / 700) + (level / 200));
myStatInfo[8][3] = myStatInfo[8][2];
hp = myStatInfo[8][3];
myStatInfo[0][2] = round(1 + (level / 2.5));
myStatInfo[0][2] *= (1 + (level / 3500) + (level / 1500));
myStatInfo[0][3] = myStatInfo[0][2];
ospd = 0.6 * global.roomSpeed;
baseSpeed = ospd;
myStatInfo[1][4] = 0.8 + (level / 280);

if (myStatInfo[1][4] >= 25)
    myStatInfo[1][4] = 25;

myStatInfo[1][2] = myStatInfo[1][4];
myStatInfo[1][3] = myStatInfo[1][2];
myStatInfo[3][2] = 1.6 + (level / 3000);
myStatInfo[3][3] = myStatInfo[3][2];
myStatInfo[2][2] = 5 + (level / 200);

if (myStatInfo[2][2] >= 50)
    myStatInfo[2][2] = 50;

myStatInfo[2][3] = myStatInfo[2][2];
myStatInfo[7][2] = 5;
myStatInfo[7][3] = myStatInfo[7][2];
mana = 0;
maxmana = 20;
myStatInfo[4][2] = 1;
myStatInfo[4][3] = myStatInfo[4][2];
buffed = 0;
length = sprite_width / 1.5;
height = sprite_height;

if (instance_exists(obj_warrior))
    target = instance_nearest(x, y, obj_warrior);

x = (room_width * 2) + 500 + sprite_width;
y = room_height - 20;

if (room == r_1 && obj_raid.boss == true)
    tier += global.bossTier;

myStatInfo[0][1] = myStatInfo[0][2];

if (tierReduction < 2)
    tierReduction = 2;

odmgReflection = 0;
dmgReflection = odmgReflection;
skill = choose(1, 2, 3, 4, 7, 8, 9);
var _dmgReduction = 0.1 + (tier / 50) + (level / 100000);
var _ccReduction = 0.1 + (tier / 50) + (level / 200000);
var _res = choose(0, 1, 2);

if (_res == 0)
    omyResistance[0][1] -= _dmgReduction;

if (_res == 1)
    omyResistance[0][2] -= _dmgReduction;

if (_res == 2)
    omyResistance[0][2] -= _dmgReduction;

omyResistance[1][0] -= _ccReduction;
omyResistance[1][1] -= (_ccReduction / 2);
omyResistance[2][0] -= _ccReduction;
omyResistance[2][1] -= (_ccReduction / 2);

for (var i = 0; i <= global.damageTypes; i++)
    myResistance[0][i] = omyResistance[0][i];

for (var i = 0; i <= 1; i++)
{
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

hpLength = string_width(string(gml_Script_scr_bigNumber(round(hp)))) + 20;

if (hpLength < (length / 2))
    hpLength = length / 2;

myRelicSlots = 1;
var _relic = irandom_range(1, global.maxUniqueItems);
var _raidType = obj_raid.raidType;

if (_raidType == 0 && finalWarSpawn != -1)
{
    if ((finalWarSpawn % 50) == 0)
        _raidType += 1;
    
    if ((finalWarSpawn % 250) == 0)
        _raidType += 1;
    
    if ((finalWarSpawn % 1000) == 0)
        _raidType += 1;
}

if (_raidType == 1 || _raidType == 2 || _raidType == 3)
    _relic = choose(obj_raid.specialRaid[global.stage / 50][1], obj_raid.specialRaid[global.stage / 50][2], obj_raid.specialRaid[global.stage / 50][3]);

var _relicLevel = irandom_range(1, 20) + round(_scalingSource / 200);
equippedUniqueItem[_relic] = 1;
uniqueItemLevel[_relic] = _relicLevel;
uniqueSlot[1] = _relic;

if (_scalingSource > 500)
    tier += 1;

if (_scalingSource > 1000)
    tier += 1;

if (_scalingSource > 1500)
    tier += 1;

if (_scalingSource > 2000)
    tier += 1;

if (_scalingSource > 2500)
    tier += 1;

if (room == r_1)
{
    if (_raidType == 2 || _raidType == 3)
    {
        tier += (_raidType - 1);
        myRelicSlots = 3;
        
        if (omyResistance[0][1] > 0)
            omyResistance[0][1] = 0;
        
        if (_raidType == 3)
        {
            if (omyResistance[0][2] > 0)
                omyResistance[0][2] = 0;
        }
        
        var _relic1 = obj_raid.specialRaid[global.stage / 50][1];
        var _relic2 = obj_raid.specialRaid[global.stage / 50][2];
        var _relic3 = obj_raid.specialRaid[global.stage / 50][3];
        var _relicLevel1 = irandom_range(10, 40) + round(_scalingSource / 200);
        var _relicLevel2 = irandom_range(10, 40) + round(_scalingSource / 200);
        var _relicLevel3 = irandom_range(10, 40) + round(_scalingSource / 200);
        equippedUniqueItem[_relic1] = 1;
        equippedUniqueItem[_relic2] = 1;
        equippedUniqueItem[_relic3] = 1;
        uniqueItemLevel[_relic1] = _relicLevel1;
        uniqueItemLevel[_relic2] = _relicLevel2;
        uniqueItemLevel[_relic3] = _relicLevel3;
        uniqueSlot[1] = _relic1;
        uniqueSlot[2] = _relic2;
        uniqueSlot[3] = _relic3;
    }
}

show_debug_message("Boss create event");

enum UnknownEnum
{
    Value_0
}
