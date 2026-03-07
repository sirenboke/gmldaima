if (cost <= global.maxGold)
{
    if (cost <= global.gold)
        c_cost = 65535;
    else
        c_cost = 4235519;
}
else
{
    c_cost = 255;
}

if (cost2 <= global.gems)
    c_cost2 = 65280;
else
    c_cost2 = 4235519;

if (costText == "Maximum Level")
    c_cost = 65280;

msg[0] = string(global.cmdPrefix) + "upg " + string(name) + " (lv." + string(level) + ")";
msg[1] = string(global.cmdPrefix) + "spend " + string(name) + "*# (lv." + string(level) + ")";

if (cost2 > 0)
    msg[1] = string(global.cmdPrefix) + "spend gold/gems " + string(name) + "*# (lv." + string(level) + ")";

msg[2] = string(name) + " (lv." + string(level) + ")";
