self.scr_relicEffect_14 = function()
{
    if (equippedUniqueItem[14] == 1 || player.myPetEquippedRelic[myPetID][14] == 1)
    {
        if (choose(0, 1) == 0)
        {
            var _dmg = 1;
            _dmg = global.uniqueItem[14][2] + (uniqueItemLevel[14] / 10);
            _dmg = gml_Script_scr_petRelic(player, _dmg, 14);
            return _dmg;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 1;
    }
};
