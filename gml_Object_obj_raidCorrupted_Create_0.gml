maxEnemies = 5;
enemies = 0;
global.globalChallengeValue = [];
challenge = [];

for (var i = 0; i < 8; i++)
{
    challenge[i] = -1;
    global.globalChallengeValue[i] = -1;
}

challengeAmount = 1;
global.raidKills = 0;
c_dmgType[0] = 16777215;
c_dmgType[1] = 255;
c_dmgType[2] = 16776960;
c_dmgType[3] = 65535;
c_dmgType[4] = 16777215;
c_dmgType[5] = 16777215;
timer = room_speed;
