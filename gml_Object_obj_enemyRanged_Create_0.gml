event_inherited();
image_speed = 0.05 * global.roomSpeed;
ospr_idle = spr_mosquito2Idle;
ospr_move = spr_mosquito2Idle;
ospr_attack = spr_mosquito2Attack;
ospr_dead = spr_mosquito2Dead;
spr_idle = ospr_idle;
spr_move = ospr_move;
spr_attack = ospr_attack;
spr_dead = ospr_dead;
name = "Fly";
sprite_index = spr_move;
state = UnknownEnum.Value_0;
class = "basic";

if (global.gotWitch == false)
    type = "basic";
else
    type = choose("basic", "demon");

if (room == global.room_underworld)
    type = "demon";

if (room == r_1)
    level = round(1 + (random_range(global.stage - 2, global.stage + 4) * (1 + (global.stage / 30))));

if (room == r_underworld)
    level = round(1 + (random_range((global.portalStage * 200) - 2, (global.portalStage * 200) + 4) * (1 + ((global.portalStage * 200) / 30))));

if (room == r_underworld_new)
{
    level = round(global.portalTower * 200 * (1 + (global.portalTower / 5)) * (1 + (global.portalFloor / 20)));
    level += round(irandom_range(-(level * 0.1), level * 0.1));
}

ospd = 0.75 * global.roomSpeed;
baseSpeed = ospd;
rng = 500 + (level / 10);

if (rng > 900)
    rng = 900;

myStatInfo[8][2] = 40 + (level * 1.5);
myStatInfo[8][3] = myStatInfo[8][2];
myStatInfo[0][2] = 0.08 + (level / 25);
myStatInfo[1][4] = random_range(1.5, 2) + (level / 350);

if (myStatInfo[1][4] >= 25)
    myStatInfo[1][4] = 25;

myStatInfo[1][2] = myStatInfo[1][4];
myStatInfo[1][3] = myStatInfo[1][2];
myStatInfo[3][2] = 2 + (level / 2100);
myStatInfo[3][3] = myStatInfo[3][2];
myStatInfo[2][2] = 5 + (level / 20);
y = room_height - 120;
height = sprite_get_height(spr_mosquito2Idle) - 40;
myStatInfo[8][2] *= (1 + (level / 2000) + (level / 500));
myStatInfo[8][3] = myStatInfo[8][2];
hp = myStatInfo[8][3];
myStatInfo[0][2] *= (1 + (level / 3800) + (level / 1700));
myStatInfo[0][3] = myStatInfo[0][2];

if (myStatInfo[2][2] >= 50)
    myStatInfo[2][2] = 50;

myStatInfo[2][3] = myStatInfo[2][2];
dmgReflection = 0;
myStatInfo[6][2] = 0;
myStatInfo[6][3] = 0;
myStatInfo[7][2] = 25;
myStatInfo[7][3] = myStatInfo[7][2];
attackType = "ranged";
omyResistance[1][0] = 1;
omyResistance[1][1] = 0.8;
omyResistance[2][0] = 1;
omyResistance[2][1] = 0.8;

for (var i = 0; i <= global.damageTypes; i++)
    myResistance[0][i] = omyResistance[0][i];

for (var i = 0; i <= 1; i++)
{
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

mana = 0;
maxmana = 15;
myStatInfo[4][2] = 1.2;
myStatInfo[4][3] = myStatInfo[4][2];
buffed = 0;
skill = 8;
length = sprite_width / 2;

if (instance_exists(obj_warrior))
    target = instance_nearest(x, y, obj_warrior);

x = (room_width * 2) + 100 + sprite_width;
myStatInfo[0][1] = myStatInfo[0][2];
skill = 8;

enum UnknownEnum
{
    Value_0
}
