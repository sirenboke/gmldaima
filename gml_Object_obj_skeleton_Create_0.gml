event_inherited();
image_speed = 0.05 * global.roomSpeed;
var skeletonType = choose(1, 2, 3, 4, 5);
ospr_idle = asset_get_index("spr_skeleton" + string(skeletonType) + "Idle");
ospr_move = asset_get_index("spr_skeleton" + string(skeletonType) + "Move");
ospr_attack = asset_get_index("spr_skeleton" + string(skeletonType) + "Attack");
ospr_dead = asset_get_index("spr_skeleton" + string(skeletonType) + "Dead");
spr_idle = ospr_idle;
spr_move = ospr_move;
spr_attack = ospr_attack;
spr_dead = ospr_dead;
name = "Skeleton";
sprite_index = spr_move;
state = UnknownEnum.Value_0;
class = "basic";

if (global.gotWitch == false)
    type = "undead";
else
    type = choose("undead", "demon");

if (room == r_1 || room == r_underworld_new || room == r_corrupted)
    level = round(1 + (random_range(global.stage - 4, global.stage + 2) * (1 + (global.stage / 35))));

if (room == global.room_underworld)
    type = "demon";

if (room == r_underworld)
    level = round(1 + (random_range((global.portalStage * 200) - 4, (global.portalStage * 200) + 2) * (1 + ((global.portalStage * 200) / 35))));

if (level < 1)
    level = 1;

myStatInfo[8][2] = 45 + (level * 2.6);
myStatInfo[8][2] *= (1 + (level / 2500) + (level / 800));
myStatInfo[8][3] = myStatInfo[8][2];
hp = myStatInfo[8][3];
myStatInfo[0][2] = 0.35 + (level / 2.7);
myStatInfo[0][2] *= (1 + (level / 4000) + (level / 1500));
myStatInfo[0][3] = myStatInfo[0][2];
rng = 10;
ospd = 0.75 * global.roomSpeed;
baseSpeed = ospd;
myStatInfo[1][4] = random_range(0.8, 1.2) + (level / 400);

if (myStatInfo[1][4] >= 18)
    myStatInfo[1][4] = 18;

myStatInfo[1][2] = myStatInfo[1][4];
myStatInfo[1][3] = myStatInfo[1][2];
myStatInfo[3][2] = 1.2 + (level / 4000);
myStatInfo[3][3] = myStatInfo[3][2];
myStatInfo[2][2] = 1 + (level / 50);

if (myStatInfo[2][2] >= 60)
    myStatInfo[2][2] = 60;

myStatInfo[2][3] = myStatInfo[2][2];
dmgReflection = 0;
myStatInfo[6][2] = 0;
myStatInfo[6][3] = 0;
myStatInfo[7][2] = 10;
myStatInfo[7][3] = myStatInfo[7][2];
attackType = "melee";
mana = 0;
maxmana = 10;
myStatInfo[4][2] = 1.5;
myStatInfo[4][3] = myStatInfo[4][2];
omyResistance[1][0] = 0.6;
omyResistance[1][1] = 0.9;
omyResistance[2][0] = 0.6;
omyResistance[2][1] = 0.9;

for (var i = 0; i <= global.damageTypes; i++)
    myResistance[0][i] = omyResistance[0][i];

for (var i = 0; i <= 1; i++)
{
    myResistance[1][i] = omyResistance[1][i];
    myResistance[2][i] = omyResistance[2][i];
}

buffed = 0;
length = sprite_width / 1.5;
height = sprite_height;

if (instance_exists(obj_warrior))
    target = instance_nearest(x, y, obj_warrior);

x = (room_width * 2) + 100 + sprite_width;
y = room_height - 20;
myStatInfo[0][1] = myStatInfo[0][2];
myStatInfo[5][2] = 10 * tier;
myStatInfo[5][3] = myStatInfo[5][2];
skill = 7;

if (skeletonType == 1)
    skill = 1;

if (skeletonType == choose(2, 3))
    skill = 3;

if (skeletonType == 4)
    skill = 7;

if (skeletonType == 5)
    skill = 9;

if (skeletonType == 3 || skeletonType == 4 || skeletonType == 5 || skeletonType == 6)
    omaxshield = myStatInfo[8][3] * (skeletonType / 10);

enum UnknownEnum
{
    Value_0
}
