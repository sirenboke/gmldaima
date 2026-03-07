event_inherited();
gml_Script_scr_alarm_initialize(50);
immune = false;
resurrect = 0;
summoned = 0;
bar_height = 0;
float_height = 0;
omyDamage[0] = 1;
myDamage[0] = omyDamage[0];
shield = 0;
decayableShield = 0;
shieldDecayTimer = 0;
shieldDecayDelay = (room_speed / 5) * 3;
shieldDamageAccumulator = 0;
target = -4;
displayHP = 0;
hpRegenHeal = 0;
oarmorReduction = 0;
armorReduction = oarmorReduction;
statusDurationBonus = 1;
poisonHit = false;
poisonDmg = 0;
poisonStacks = 0;
poisonTimer = 0;
poisonTimerMax = 0;
bleedTimer = 0;
bleedTimerMax = 0;
hemorrhageTrigger = 0;
hemorrhageTimer = 0;
hemorrhageTimerMax = 0;
burnTimer = 0;
burnTimerMax = 0;
burning = 0;
burnStacks = 0;
freezeStacks = 0;
freezeTimer = 0;
freezeTimerMax = 0;
frozen = 0;
canFreeze = true;
healReduction = 1;
odmgReflection = 0;
dmgReflection = 0;
aspdSteal = 0;
isHit = false;
isStunned = false;
isTrapped = false;
cantMiss = false;
speedBuff = 0;
baseSpeed = 1;
omoveSpeed = 1;
moveSpeed = omoveSpeed;
skillBuff = 0;
buffed = 0;
polymorphed = false;
knockup = false;
knockup_str = 0;
grav = 1;
castingAbility = false;
canAttack = true;
canMove = true;
hasCollision = true;
omaxshield = 0;
maxshield = omaxshield;
oshieldCapacity = 0;
shieldCapacity = oshieldCapacity;
shield = 0;
maxStamina = 150;
stamina = maxStamina;
staminaDrain = 1;
tired = false;
resurrect = 0;
resTimer = 1;

if (global.challenge_enemyRevive > 0)
{
    if (random_range(0.1, 1) < global.challenge_enemyRevive)
        resurrect = 1;
}

player = id;
show_debug_message(player);
name = "";
size = 2;

for (var i = 0; i < 5; i++)
{
    for (var ii = 0; ii < 4; ii++)
        status[i][ii] = 0;
}

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

for (var i = 0; i < 10; i++)
{
    for (var ii = 0; ii < 5; ii++)
        myStatInfo[i][ii] = 0;
}

for (var i = 0; i < 10; i++)
    myAbilityInfo[i] = 0;

skill = 1;
alarm[0] = 1;

for (var i = 0; i <= global.damageTypes; i++)
{
    omyResistance[0][i] = 1;
    myResistance[0][i] = omyResistance[0][i];
    omyDamage[i] = 1;
    myDamage[i] = omyDamage[i];
}

for (var i = 0; i <= 1; i++)
{
    omyResistance[1][i] = 1;
    myResistance[1][i] = omyResistance[1][i];
    omyResistance[2][i] = 1;
    myResistance[2][i] = omyResistance[2][i];
}

dead = false;
myPetID = 0;

for (var p = 0; p <= global.maxPets; p++)
{
    for (var pr = 0; pr <= global.maxUniqueItems; pr++)
        myPetEquippedRelic[p][pr] = 0;
    
    for (var ps = 1; ps <= 5; ps++)
    {
        petRelicSlot[p][ps] = 0;
        myPetRelicSlotEffect[p][ps] = 1;
    }
}

for (var ui = 1; ui <= global.maxUniqueItems; ui += 1)
{
    gotUniqueItem[ui] = 1;
    equippedUniqueItem[ui] = 0;
    
    if (myPetID > 0)
    {
        if (equippedUniqueItem[ui] == 1 && myPetEquippedRelic[myPetID][ui] == 1)
            equippedUniqueItem[ui] = 0;
    }
    
    uniqueItemLevel[ui] = 1;
    uniqueItemCorruption[ui] = 1;
}

gotUniqueItem[0] = 1;
equippedUniqueItem[0] = 1;
uniqueItemLevel[0] = 1;
myRelicSlots = 0;
uniqueSlot[0] = 0;

for (var sr = 1; sr <= 5; sr += 1)
{
    uniqueSlot[sr] = 0;
    
    if (myPetID > 0)
    {
        for (var cr = 1; cr <= 5; cr += 1)
        {
            if (uniqueSlot[sr] == petRelicSlot[myPetID][cr])
                uniqueSlot[sr] = 0;
        }
    }
}

alarm[4] = room_speed;

if (!variable_instance_exists(id, "tier"))
    tier = 1;

if (!variable_instance_exists(id, "tierReduction"))
    tierReduction = 1;
