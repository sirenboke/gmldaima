image_speed = 0.05;
image_xscale = 2;
image_yscale = 2;

if (room == r_1)
    s_walking = s_footstepForest;
else
    s_walking = s_walk1;

xx = x;

if (room == r_corrupted)
    layer_add_instance(layer_get_id("Cleared"), self);

canMove = true;
statSuffix[0] = "";
statSuffix[1] = "/s";
statSuffix[2] = "%";
statSuffix[3] = "";
statSuffix[4] = "/hit";
statSuffix[5] = "%";
statSuffix[6] = "/s";
statSuffix[7] = "%";
statSuffix[8] = "";
statSuffix[9] = "";
gml_Script_scr_alarm_initialize(50);
castingAbility = false;
abilityCastTime = room_speed;
abilityDurationBonus = 1;
statusDurationBonus = 1;
canAttack = true;
skillBuff = 0;
skillTimer = 0;
buffed = 0;
charging = false;
isStunned = false;
displayHP = 0;
type = "basic";
w3s3_distance = 0;
lastEnemyHit = -1;
sprint = -1;
totalArrows = 1;
explosiveArrow = false;
explosionRange = 200;
lightningArrow = false;
lightBounces = 0;
lightBounceRng = 0;
lightningDmg = 0;
fireArrow = false;
poisonArrow = false;
iceArrow = false;
targetWeaker = false;
fireshieldDmg = 0;
fireshieldArmor = 0;
fireshieldReflect = 0;
simStacks = 0;
redirectDmg = 0;
redirectTo = -2;
extraMaxHP = 0;
aspdDebuff = 0;
aspdDebuffTimer = 0;
extraSpeed = 0;
speedBuff = 0;
omoveSpeed = 1;
moveSpeed = omoveSpeed;
baseSpeed = 1;
poisonAuraDmg = 0;
multipleHit = false;
multipleHitDmg = 0;
arrowdmgReduction = 0.3;
frequency = room_speed * 1;
poisonStacksBomb = 0;
maxStamina = 200;
maxStamina *= (1 + global.corruptionShardEffect[15]);
stamina = maxStamina;
simDmg = 0;
simHP = 0;
simInt = 0;
hpRegenHeal = 0;
critMulti = 2 + global.corruptionShardEffect[0];
armorReduction = 0;
tierReduction = 1;
oHealReduction = 1;
healReduction = oHealReduction;
bleedTimer = 0;
bleedTimerMax = 0;
hemorrhageTrigger = 0;
hemorrhageTimer = 0;
hemorrhageTimerMax = 0;
poisonDmg = 0;
poisonHit = false;
poisonStacks = 0;
poisonTimer = 0;
poisonTimerMax = 0;
fireDuration = 0;
fireStacks = 0;
burnTimer = 0;
burnTimerMax = 0;
burning = 0;
burnStacks = 0;
freezeStacks = 0;
freezeTimer = 0;
freezeTimerMax = 0;
frozen = false;
canFreeze = true;
focusHpRegen = 0;
__extraAspd = 0;
__extraLifeSteal = 0;
__extraCrit = 0;
__extraStr = 0;

for (var i = 0; i < 5; i++)
{
    for (var ii = 0; ii < 4; ii++)
        status[i][ii] = 0;
}

oonHitTrue = 0;
oonHitHeal = 0;
onHitTrue = oonHitTrue;
onHitHeal = oonHitHeal;
oonHitSpecial = 0;
onHitSpecial = oonHitSpecial;
oonHitFire = 0;
onHitFire = oonHitFire;
obasicOnHitTrue = 0;
basicOnHitTrue = obasicOnHitTrue;
absorb = false;
__fury = 0;
thirdAttack = 0;
tempNumber = 0;
enteredCombat = false;
immune = true;

if (instance_exists(obj_enemy))
    obj_enemy.immune = false;

raidAction = "none";
state = UnknownEnum.Value_0;
dying = false;
target = -4;
targetFixed = false;
meInRange = false;
allyInRange = false;
alarm[0] = 1;
alarm[4] = room_speed;
pet = 0;

enum UnknownEnum
{
    Value_0
}
