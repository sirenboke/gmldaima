event_inherited();
image_speed = 0.05 * global.roomSpeed;
ospr_idle = spr_portalBoss1Idle;
ospr_move = spr_portalBoss1Idle;
ospr_attack = spr_portalBoss1Attack;
ospr_dead = spr_portalBoss1Dead;
spr_idle = ospr_idle;
spr_move = ospr_move;
spr_attack = ospr_attack;
spr_dead = ospr_dead;
name = global.floorName[global.portalStage][1];

if (room == r_underworld)
    soulType = global.portalStage - 1;

if (room == r_underworld_new)
    soulType = global.portalTower;

if (soulType == 4)
{
    obj_raidPortal.maxEnemies += 1;
    obj_raidPortal.enemies += 1;
    global.raidEnd = false;
    
    with (gml_Script_instance_create(x + 1000, y, obj_finalBoss))
    {
        myNumber = global.enemyNumber;
        x += 1000;
        state = UnknownEnum.Value_0;
    }
}

sprite_index = spr_move;
state = UnknownEnum.Value_0;
class = "alpha";
type = "demon";
ospd = 0.5 * global.roomSpeed;
baseSpeed = ospd;
maxStamina *= 4;
stamina = maxStamina;

if (room == r_1)
    level = round(1 + (random_range(global.stage - 2, global.stage + 4) * (1 + (global.stage / 30))));

if (room == r_underworld)
    level = round(1 + (global.portalStage * 200 * (1 + ((global.portalStage * 200) / 30))));

if (room == r_underworld_new)
{
    level = 5000 + round(global.portalTower * 200 * (1 + (global.portalTower / 5)) * (1 + (global.portalFloor / 20)));
    level += round(irandom_range(-(level * 0.1), level * 0.1));
}

var _scalingSource = global.stage;
level = round(irandom_range(_scalingSource + 15, _scalingSource + 25) * (1 + (_scalingSource / 25)));
myStatInfo[8][2] = 750 + (level * 15 * global.portalStage);
myStatInfo[8][2] *= (1 + (level / 1200) + (level / 400));
myStatInfo[8][3] = myStatInfo[8][2];
hp = myStatInfo[8][3];
myStatInfo[0][2] = 1.25 + (level / 2.8);
myStatInfo[0][2] *= (1 + (level / 5000) + (level / 1700));
myStatInfo[0][3] = myStatInfo[0][2];
rng = 10;
myStatInfo[1][4] = 3 + (level / 300);

if (myStatInfo[1][4] >= 23)
    myStatInfo[1][4] = 23;

myStatInfo[1][2] = myStatInfo[1][4];
myStatInfo[1][3] = myStatInfo[1][2];
myStatInfo[3][2] = 3 + (level / 2500);
myStatInfo[3][3] = myStatInfo[3][2];
myStatInfo[2][2] = 1 + (level / 100);

if (myStatInfo[2][2] >= 50)
    myStatInfo[2][2] = 50;

myStatInfo[2][3] = myStatInfo[2][2];
dmgReflection = 0;
myStatInfo[6][2] = 0;
myStatInfo[6][3] = 0;
myStatInfo[7][2] = 5;
myStatInfo[7][3] = myStatInfo[7][2];
mana = 0;
maxmana = 15;
myStatInfo[4][2] = 1.1;
myStatInfo[4][3] = myStatInfo[4][2];
buffed = 0;
attackType = "melee";
length = sprite_width / 2;
height = sprite_height;
tier = clamp(global.portalTower - 1, 1, 3);
tierReduction = 10;
myStatInfo[0][1] = myStatInfo[0][2];

if (instance_exists(obj_warrior))
    target = instance_nearest(x, y, obj_warrior);

if (soulType == 0)
    skill = 4;

if (soulType == 1)
    skill = 2;

if (soulType == 2)
    skill = 1;

if (soulType == 3)
    skill = 3;

if (soulType == 4)
    skill = 4;

if (soulType == 5)
    skill = 2;

if (soulType == 6)
    skill = 1;

var _dmgReduction = 0.2 + (tier / 20) + (global.finisKills / 200);
var _ccReduction = 0.2 + (tier / 20) + (level / 100000);

if (_ccReduction > 0.8)
    _ccReduction = 0.8;

show_debug_message(string(name) + "'s before dmg res: " + string(_dmgReduction) + ", cc res: " + string(_ccReduction));
var _passive = choose(0, 1, 2);

if (_passive == 0)
{
    if (choose(0, 1) == 0)
        omyResistance[0][1] -= _dmgReduction;
    else
        omyResistance[0][2] -= _dmgReduction;
}

if (_passive == 1)
    omyResistance[0][0] -= (_dmgReduction / 2);

if (_passive == 2)
{
    myStatInfo[5][2] = 10 * tier;
    myStatInfo[5][3] = myStatInfo[5][2];
}

omyResistance[1][0] -= _ccReduction;
omyResistance[1][1] -= (_ccReduction / 2);
omyResistance[2][0] -= _ccReduction;
omyResistance[2][1] -= (_ccReduction / 2);
var i;

for (i = 0; i <= global.damageTypes; i++)
    myResistance[0][i] = omyResistance[0][i];

for (i = 0; i <= 1; i++)
{
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

show_debug_message(string(name) + "'s after dmg res: " + string(myResistance[0][0]) + ", cc res: " + string(myResistance[0][i]));
x = (room_width * 2) + 100 + sprite_width;
y = room_height - 20;
myRelicSlots = 2;
var _relic1 = irandom_range(1, global.maxUniqueItems);
var _relic2;

do
    _relic2 = irandom_range(1, global.maxUniqueItems);
until (_relic2 != _relic1);

var _relicLevel1 = irandom_range(1, 20);
var _relicLevel2 = irandom_range(1, 20);
equippedUniqueItem[_relic1] = 1;
equippedUniqueItem[_relic2] = 1;
uniqueItemLevel[_relic1] = _relicLevel1;
uniqueItemLevel[_relic2] = _relicLevel2;
uniqueSlot[1] = _relic1;
uniqueSlot[2] = _relic2;

enum UnknownEnum
{
    Value_0
}
