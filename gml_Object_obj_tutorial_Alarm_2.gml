var _text2 = cyclePersonalTip;
var _text2Name = "";
text2 = p[_text2];

with (obj_player)
{
    if (tutorial == true)
    {
        if (_text2 == 0)
        {
            if (global.academyBuilt == 1 && skillPoints > (totalSkillPoints / 3))
                _text2Name += (string(name) + ", ");
        }
        
        if (_text2 == 1)
        {
            var _gotRelics = 0;
            var _equippedRelics = 0;
            
            for (var i = 1; i < global.maxUniqueItems; i++)
            {
                if (gotUniqueItem[i] >= 1)
                    _gotRelics = 1;
                
                if (equippedUniqueItem[i] == 1)
                    _equippedRelics = 1;
            }
            
            if (_gotRelics == 1 && _equippedRelics == 0 && level >= 100)
                _text2Name += (string(name) + ", ");
        }
        
        if (_text2 == 2)
        {
            var _gotAura = 0;
            var _myAura = 0;
            
            for (var i = 1; i <= global.totalAuras; i++)
            {
                if (gotAura[i] > 0)
                    _gotAura = 1;
                
                if (myAura > 0)
                    _myAura = 1;
            }
            
            if (_gotAura == 1 && _myAura == 0)
                _text2Name += (string(name) + ", ");
        }
        
        if (_text2 == 3)
        {
            var _gotPet = 0;
            
            for (var i = 1; i <= global.maxPets; i++)
            {
                if (gotPet[i] > 0)
                    _gotPet = 1;
            }
            
            if (_gotPet == 1 && myPetID == 0)
                _text2Name += (string(name) + ", ");
        }
    }
}

if (_text2Name != "")
{
    _text2Name = string_copy(_text2Name, 1, string_length(_text2Name) - 2);
    gml_Script_twitch_chat_say_direct("/me " + string(text2) + " (" + string(_text2Name) + ")");
}

cyclePersonalTip += 1;

if (cyclePersonalTip > personalTipsList)
    cyclePersonalTip = 0;

alarm[2] = room_speed * 120;
