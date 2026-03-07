focusCamera = false;
lastRaidTime = 0;
getRaidItems = false;
usePortal = 1;
useRedPortal = 1;
defeated = false;
readyRaid = 0;
image_speed = 0.01;
length = sprite_width / 2;
height = sprite_height + 4;
gotoX = 0;
gotoY = 0;
afkTimer = 3600;
afk = false;
afkdraw = false;
afkicon = 0;
afkRewardPenalty = 1;
afksemi = 0;
shield = 0;
alarm[3] = room_speed * afkTimer;
alarm[5] = room_speed * afkTimer;
wasGuarding = false;
maxVocationLevel = 15;
avoidSpam = 0;
personalMessages = 0;
alarm[2] = room_speed;
gml_Script_scr_alarm_initialize(10);
pointsAmount = 0;
voted = false;

for (var i = 0; i <= global.damageTypes; i++)
{
    combatDamageDealt[i] = 0;
    combatDamageReceived[i] = 0;
    combatDamageMitigated[i] = 0;
}

questBonus = 1;
reputation = 0;
guildTick = false;

if (instance_exists(obj_quest))
    questReputation = obj_quest.questReputation;
else
    questReputation = 10;

reputationCompleted = false;
