event_inherited();
image_speed = 0.05 * global.roomSpeed;
name = "Finis Vitae";

if (global.finisKills > 0)
    name = "Hollow Finis Vitae (v" + string(global.finisKills) + ")";

if (room == r_underworld)
    soulType = global.portalStage - 1;

if (room == r_underworld_new)
    soulType = global.maxPortalTower;

ospr_idle = spr_finis_idle;
ospr_move = spr_finis_idle;
ospr_attack = spr_finis_idle;
ospr_dead = spr_finis_idle;
size = 3;

if (global.portalTower == global.maxPortalTower)
    size = 3.5 + (global.finisKills / 10);

spr_idle = ospr_idle;
spr_move = ospr_move;
spr_attack = ospr_attack;
spr_dead = ospr_dead;
sprite_index = spr_move;
state = UnknownEnum.Value_0;
class = "alpha";
type = "final";
ospd = 0.5 * global.roomSpeed;
baseSpeed = ospd;
maxStamina *= 10;
stamina = maxStamina;

if (room == r_1)
    level = round(1 + (random_range(global.stage - 2, global.stage + 4) * (1 + (global.stage / 30))));

if (room == global.room_underworld)
    level = 666666;

ini_open(string(global.platformDir) + "Village Data/Data.ini");
bonuses = ini_read_real("Underworld", "Finis Kills", 0);
myStatInfo[8][2] = 10000000000000 * (1 + (bonuses / 10));
myStatInfo[8][3] = myStatInfo[8][2];

if (global.portalTower == global.maxPortalTower)
{
    hp = ini_read_real("Underworld", "Final Boss HP", myStatInfo[8][3]);
    
    if (hp <= 0)
        hp = myStatInfo[8][3];
}
else
{
    hp = myStatInfo[8][3];
}

if (hp <= 0)
    hp = myStatInfo[8][3];

if (hp > myStatInfo[8][3])
    hp = myStatInfo[8][3];

ini_close();
myStatInfo[0][2] = 10000 * (1 + (bonuses / 10));

if (global.portalTower == global.maxPortalTower)
    myStatInfo[0][2] *= 5;

myStatInfo[0][3] = myStatInfo[0][2];
rng = 900;
myStatInfo[1][4] = 10 + bonuses;

if (myStatInfo[1][4] >= 25)
    myStatInfo[1][4] = 25;

myStatInfo[1][2] = myStatInfo[1][4];
myStatInfo[1][3] = myStatInfo[1][2];
myStatInfo[3][2] = 50;

if (global.portalTower == global.maxPortalTower)
    myStatInfo[3][2] = 500;

myStatInfo[3][2] *= ((bonuses / 20) + 1);
myStatInfo[3][3] = myStatInfo[3][2];
myStatInfo[2][2] = 50;

if (myStatInfo[2][2] >= 50)
    myStatInfo[2][2] = 50;

myStatInfo[2][3] = myStatInfo[2][2];
dmgReflection = 0;
myStatInfo[6][2] = 0;
myStatInfo[6][3] = 0;
myStatInfo[7][2] = 50;
myStatInfo[7][3] = myStatInfo[7][2];
attackType = "ranged";
mana = 0;
maxmana = 30;
myStatInfo[4][2] = 1.1;
myStatInfo[4][3] = myStatInfo[4][2];
buffed = 0;
length = sprite_width / 2;
height = sprite_height;
hasCollision = false;
tierReduction = 100;
myStatInfo[0][1] = myStatInfo[0][2];
skill = 1 + irandom(global.enemyAbilityMax);

if (instance_exists(obj_warrior))
    target = instance_nearest(x, y, obj_warrior);

var _ccReduction = 0 + (bonuses / 100);
omyResistance[0][0] -= (bonuses / 50);
omyResistance[0][1] -= (bonuses / 20);
omyResistance[0][2] -= (bonuses / 20);
omyResistance[0][3] -= (bonuses / 20);
omyResistance[1][0] = 0.5;
omyResistance[1][1] = 0.8;
omyResistance[2][0] = 0.3;
omyResistance[2][1] = 0.8;
omyResistance[1][0] -= _ccReduction;
omyResistance[1][1] -= (_ccReduction / 2);
omyResistance[2][0] -= _ccReduction;
omyResistance[2][1] -= (_ccReduction / 2);

for (var i = 0; i <= global.damageTypes; i++)
{
    if (omyResistance[0][i] <= 0)
        omyResistance[0][i] = 0;
    
    myResistance[0][i] = omyResistance[0][i];
}

for (var i = 0; i <= 1; i++)
{
    if (omyResistance[1][i] <= 0.01)
        omyResistance[1][i] = 0.01;
    
    if (omyResistance[2][i] <= 0.01)
        omyResistance[2][i] = 0.01;
    
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

x = (room_width * 2) + 100 + sprite_width;
y = room_height - 20;
myRelicSlots = 3;
var _relic1 = irandom_range(1, global.maxUniqueItems);
var _relic2;

do
    _relic2 = irandom_range(1, global.maxUniqueItems);
until (_relic2 != _relic1);

var _relic3;

do
    _relic3 = irandom_range(1, global.maxUniqueItems);
until (_relic3 != _relic1 && _relic3 != _relic2);

var _relicLevel1 = irandom_range(10, 40);
var _relicLevel2 = irandom_range(10, 40);
var _relicLevel3 = irandom_range(10, 40);
equippedUniqueItem[_relic1] = 1;
equippedUniqueItem[_relic2] = 1;
equippedUniqueItem[_relic3] = 1;
uniqueItemLevel[_relic1] = _relicLevel1;
uniqueItemLevel[_relic2] = _relicLevel2;
uniqueItemLevel[_relic3] = _relicLevel3;
uniqueSlot[1] = _relic1;
uniqueSlot[2] = _relic2;
uniqueSlot[3] = _relic3;

enum UnknownEnum
{
    Value_0
}
