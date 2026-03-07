event_inherited();
image_speed = 0.05 * global.roomSpeed;
ospr_idle = spr_bearIdle;
ospr_move = spr_bearWalk;
ospr_attack = spr_bearAttack;
ospr_dead = spr_bearDead;
spr_idle = ospr_idle;
spr_move = ospr_move;
spr_attack = ospr_attack;
spr_dead = ospr_dead;
name = "Bear";
sprite_index = spr_move;
state = UnknownEnum.Value_0;
class = "basic";

if (global.gotWitch == false)
    type = "basic";
else
    type = choose("basic", "demon");

if (room == global.room_underworld)
    type = "demon";

if (room == r_1 || room == r_underworld_new || room == r_corrupted)
    level = round(1 + (random_range(global.stage - 2, global.stage + 4) * (1 + (global.stage / 30))));

if (room == r_underworld)
    level = round(1 + (random_range((global.portalStage * 200) - 2, (global.portalStage * 200) + 4) * (1 + ((global.portalStage * 200) / 30))));

myStatInfo[8][2] = 75 + (level * 2.7);
myStatInfo[8][2] *= (1 + (level / 2000) + (level / 500));
myStatInfo[8][3] = myStatInfo[8][2];
hp = myStatInfo[8][3];
myStatInfo[0][2] = 1.25 + (level / 2.5);
myStatInfo[0][2] *= (1 + (level / 3800) + (level / 1700));
myStatInfo[0][3] = myStatInfo[0][2];
rng = 10;
ospd = 1 * global.roomSpeed;
baseSpeed = ospd;
myStatInfo[1][4] = 0.8 + (level / 300);

if (myStatInfo[1][4] >= 23)
    myStatInfo[1][4] = 23;

myStatInfo[1][2] = myStatInfo[1][4];
myStatInfo[1][3] = myStatInfo[1][2];
myStatInfo[3][2] = 1.2 + (level / 5000);
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
attackType = "melee";
mana = 0;
maxmana = 15;
myStatInfo[4][2] = 1.1;
myStatInfo[4][3] = myStatInfo[4][2];
buffed = 0;
length = sprite_width / 2;
height = sprite_height;

if (instance_exists(obj_warrior))
    target = instance_nearest(x, y, obj_warrior);

x = (room_width * 2) + 100 + sprite_width;
y = room_height - 20;
omyResistance[0][0] -= (0.05 + (tier / 20));
omyResistance[1][0] = 0.8;
omyResistance[1][1] = 0.9;
omyResistance[2][0] = 0.8;
omyResistance[2][1] = 0.9;

for (var i = 0; i <= global.damageTypes; i++)
    myResistance[0][i] = omyResistance[0][i];

for (var i = 0; i <= 1; i++)
{
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

myStatInfo[0][1] = myStatInfo[0][2];
skill = 2;

enum UnknownEnum
{
    Value_0
}
