self.scr_setAbility = function(arg0)
{
    myAbilityInfo[0] = arg0 - 1;
    myAbilityInfo[1] = global.enemyAbilityInfo[myAbilityInfo[0]][1];
    myAbilityInfo[2] = global.enemyAbilityInfo[myAbilityInfo[0]][2];
    myAbilityInfo[3] = global.enemyAbilityInfo[myAbilityInfo[0]][3];
    myAbilityInfo[4] = 1;
    myAbilityInfo[5] = 1;
    myAbilityInfo[6] = string_repeat("I", myAbilityInfo[5]);
    myAbilityInfo[9] = global.enemyAbilityInfo[myAbilityInfo[0]][4] * room_speed;
    abilityCastTime = myAbilityInfo[9];
};
