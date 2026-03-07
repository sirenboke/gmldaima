event_inherited();
image_speed = 0.05 * global.roomSpeed;
x = (room_width * 2) + 100 + sprite_width;
y = room_height - 20;
var enemy = 1;

if (global.stage > 1000)
    enemy = choose(0, 1, 2);
else
    enemy = choose(1, 2);

if (room == r_1 || room == r_underworld_new || room == r_corrupted)
    level = round(1 + (random_range(global.stage - 4, global.stage + 2) * (1 + (global.stage / 35))));

if (room == global.room_underworld)
    type = "demon";

if (room == r_underworld)
    level = round(1 + (random_range((global.portalStage * 200) - 4, (global.portalStage * 200) + 2) * (1 + ((global.portalStage * 200) / 35))));

if (level < 1)
    level = 1;

if (enemy == 0)
{
    ospr_idle = spr_mosquito1Idle;
    ospr_move = spr_mosquito1Idle;
    ospr_attack = spr_mosquito1Attack;
    ospr_dead = spr_mosquito1Dead;
    name = "Molestia";
    ospd = 0.75 * global.roomSpeed;
    baseSpeed = ospd;
    skill = 4;
    rng = 500 + (level / 10);
    
    if (rng > 800)
        rng = 800;
    
    myStatInfo[8][2] = 4 + (level / 4);
    myStatInfo[8][3] = myStatInfo[8][2];
    myStatInfo[0][2] = 0.08 + (level / 30);
    myStatInfo[1][4] = random_range(1.5, 2) + (level / 350);
    
    if (myStatInfo[1][4] >= 25)
        myStatInfo[1][4] = 25;
    
    myStatInfo[1][2] = myStatInfo[1][4];
    myStatInfo[1][3] = myStatInfo[1][2];
    myStatInfo[3][2] = 1 + (level / 2100);
    myStatInfo[2][2] = 5 + (level / 20);
    y = room_height - 120;
    height = sprite_get_height(spr_mosquito1Idle) - 40;
    attackType = "ranged";
}

if (enemy == 1)
{
    ospr_idle = spr_enemy3;
    ospr_move = spr_enemy3;
    ospr_attack = spr_enemy3Attack;
    ospr_dead = spr_enemy3Dead;
    name = "Piglet";
    ospd = 0.6 * global.roomSpeed;
    baseSpeed = ospd;
    skill = 1;
    rng = 10;
    myStatInfo[8][2] = 5 + (level / 1.4);
    myStatInfo[8][3] = myStatInfo[8][2];
    myStatInfo[0][2] = 0.12 + (level / 5);
    myStatInfo[1][4] = random_range(0.5, 1.2) + (level / 300);
    
    if (myStatInfo[1][4] >= 22)
        myStatInfo[1][4] = 22;
    
    myStatInfo[1][2] = myStatInfo[1][4];
    myStatInfo[1][3] = myStatInfo[1][2];
    myStatInfo[3][2] = 1 + (level / 1900);
    myStatInfo[2][2] = 5 + (level / 500);
    height = sprite_get_height(spr_enemy3) + 20;
    attackType = "melee";
    hasCollision = false;
}

if (enemy == 2)
{
    ospr_idle = spr_enemy4;
    ospr_move = spr_enemy4;
    ospr_attack = spr_enemy4Attack;
    ospr_dead = spr_enemy4Dead;
    name = "Stinky";
    ospd = 0.5 * global.roomSpeed;
    baseSpeed = ospd;
    skill = 9;
    rng = 10;
    myStatInfo[8][2] = 8 + (level * 2);
    myStatInfo[8][3] = myStatInfo[8][2];
    myStatInfo[0][2] = 0.15 + (level / 4);
    myStatInfo[1][4] = random_range(0.8, 1.5) + (level / 400);
    
    if (myStatInfo[1][4] >= 20)
        myStatInfo[1][4] = 20;
    
    myStatInfo[1][2] = myStatInfo[1][4];
    myStatInfo[1][3] = myStatInfo[1][2];
    myStatInfo[3][2] = 1 + (level / 2000);
    myStatInfo[2][2] = 5 + (level / 200);
    height = sprite_get_height(spr_enemy4) + 20;
    attackType = "melee";
}

spr_idle = ospr_idle;
spr_move = ospr_move;
spr_attack = ospr_attack;
spr_dead = ospr_dead;
myStatInfo[0][2] *= (1 + (level / 4500) + (level / 1500));
myStatInfo[8][2] *= (1 + (level / 2000) + (level / 800));
myStatInfo[8][3] = myStatInfo[8][2];
sprite_index = spr_move;
state = UnknownEnum.Value_0;
class = "basic";
type = "basic";

if (global.gotWitch == false)
    type = "basic";
else
    type = choose("basic", "demon");

if (room == global.room_underworld)
    type = "demon";

hp = myStatInfo[8][3];
myStatInfo[0][3] = myStatInfo[0][2];
myStatInfo[3][3] = myStatInfo[3][2];

if (myStatInfo[2][2] >= 80)
    myStatInfo[2][2] = 80;

myStatInfo[2][3] = myStatInfo[2][2];
dmgReflection = 0;
myStatInfo[6][2] = 0;
myStatInfo[6][3] = 0;
myStatInfo[7][2] = 10;
myStatInfo[7][3] = myStatInfo[7][2];
myStatInfo[5][2] = 0;
myStatInfo[5][3] = myStatInfo[5][2];
alarm[4] = room_speed;
mana = 0;
maxmana = 10;
myStatInfo[4][2] = 1.2;
myStatInfo[4][3] = myStatInfo[4][2];
buffed = 0;
length = sprite_width / 1.5;

if (instance_exists(obj_warrior))
    target = instance_nearest(x, y, obj_warrior);

myStatInfo[0][1] = myStatInfo[0][2];

if (enemy == 0)
    skill = 4;

if (enemy == 1)
    skill = 1;

if (enemy == 2)
    skill = 9;

enum UnknownEnum
{
    Value_0
}
