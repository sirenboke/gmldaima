self.scr_relicEffect_7 = function(arg0)
{
    if (_player.myWarrior.equippedUniqueItem[7] != 1 && _player.myPetEquippedRelic[myPetID][7] != 1)
    {
        arg0 *= 2;
    }
    else
    {
        arg0 *= (global.uniqueItem[7][2] + (_player.myWarrior.uniqueItemLevel[7] - 1));
        
        for (var re = 1; re <= floor(_player.myPetInfo[myPetID][4] / 10); re++)
        {
            if (_player.petRelicSlot[myPetID][re] == 7)
                arg0 *= ((global.uniqueItem[7][2] + (_player.myWarrior.uniqueItemLevel[7] - 1)) * _player.myPetRelicSlotEffect[myPetID][re]);
        }
    }
    
    return arg0;
};
