gml_Script_scr_playsound(s_playerSpawn, 0.9, 1.1, 0.5);
var _cost1text = gml_Script_scr_bigNumber(cost1) + " " + string(cost1type);
var _cost2text = "";

if (cost2 > 0)
    _cost2text = " and " + gml_Script_scr_bigNumber(cost2) + " " + string(cost2type);

costText = _cost1text;

if (_cost2text != "")
    costText += _cost2text;

cost1typeString = cost1type;
cost2typeString = cost2type;

if (cost1type == "gold")
    cost1type = global.gold;

if (cost1type == "souls")
    cost1type = global.souls;

if (cost2type == "gems")
    cost2type = global.gems;

if (cost2type == "blood gems")
    cost2type = global.bloodgems;

gml_Script_twitch_chat_say_direct("/me " + string(name) + " proposes to upgrade " + string(buildName) + " for " + string(costText) + ", type " + string(global.cmdPrefix) + "y to accept or " + string(global.cmdPrefix) + "n to oppose (Need " + string(minVotes) + " votes to accept/cancel this action). [" + string(round(alarm[1] / room_speed)) + "s left]");
