draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_mid);
draw_sprite_ext(spr_building, 0, x, y - 60 - 22, 12.5, 6.8, 0, c_white, 1);

if (costText != "Maximum Level")
    gml_Script_scr_textoutline(x, y - 60 - 110, string_lower(msg[global.buildingMsgDisplay]), 16777215, 0, 20, 500);
else
    gml_Script_scr_textoutline(x, y - 60 - 110, string_lower(msg[2]), 16777215, 0, 20, 500);

var _x = 0;

if (cost2 > 0)
    _x = 30 + (string_width(costText + gml_Script_scr_bigNumber(cost2)) / 2);

if (costText != "Maximum Level")
{
    gml_Script_scr_textoutline(x - (_x / 2), y - 150, costText, c_cost, 0, 20, 500);
    draw_sprite_ext(spr_resourceBonus, 2, (x - (_x / 2)) + ((string_width(costText) / 2) + 10), y - 150, 1, 1, 0, -1, 1);
    
    if (cost < oCost)
        draw_sprite_ext(spr_statArrow, 1, (x - (_x / 2)) + ((string_width(costText) / 2) + 10) + 10, y - 150, 1.5, 1.5, 0, -1, 1);
    
    if (cost2 > 0)
    {
        gml_Script_scr_textoutline(x + (_x / 2), y - 150, gml_Script_scr_bigNumber(cost2), c_cost2, 0, 20, 500);
        draw_sprite_ext(spr_underworldIcons, 2, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10), y - 150, 0.5, 0.5, 0, -1, 1);
        
        if (cost2 < oCost2)
            draw_sprite_ext(spr_statArrow, 1, x + (_x / 2) + ((string_width(gml_Script_scr_bigNumber(cost2)) / 2) + 10) + 10, y - 150, 1.5, 1.5, 0, -1, 1);
    }
}
else
{
    gml_Script_scr_textoutline(x, y - 150, costText, c_cost, 0, 20, 500);
}

draw_set_font(f_special);
gml_Script_scr_textoutline(x - 130, (y - 60) + 25, "+" + gml_Script_scr_bigNumber((global.mineBonusValue - 1) * 100) + "%[x] mine gold", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x - 130, (y - 60) + 45, "+" + string(global.minerGuildLevel) + "%[x] gem chance", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x - 130, (y - 60) + 65, "+" + string(global.minerGuildLevel / 3) + " mining VP", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x, (y - 60) + 25, "+" + gml_Script_scr_bigNumber((global.hunterGuildLevel - 1) * 5 * global.hunterGuildLevel) + "%[x] raid gold", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x, (y - 60) + 45, "+" + string(global.hunterGuildLevel * 2) + "%[+] damage", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x, (y - 60) + 65, "+" + string(global.hunterGuildLevel / 3) + " raiding VP", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x + 130, (y - 60) + 25, "+" + gml_Script_scr_bigNumber((global.farmBonusValue - 1) * 100) + "%[x] farm food", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x + 130, (y - 60) + 45, "+" + string(global.farmerGuildLevel * 2) + "%[x] constitution", 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x + 130, (y - 60) + 65, "+" + string(global.farmerGuildLevel / 3) + " farming VP", 16777215, 0, 20, 600);

if (obj_quest.questType == "mine")
{
    draw_sprite_ext(spr_vocationOutline, 0, x - 120, y - 60 - 45, 1, 1, 0, c_white, 1);
    gml_Script_scr_textoutline(x - 120, (y - 60) + 5, "[+" + string(global.minerGuildLevel * 10) + "% bonus]", 16776960, 0, 20, 600);
}
else
{
    gml_Script_scr_textoutline(x - 120, (y - 60) + 5, "[+" + string(global.minerGuildLevel * 10) + "% bonus]", 4210752, 0, 20, 600);
}

if (obj_quest.questType == "kill")
{
    draw_sprite_ext(spr_vocationOutline, 0, x, y - 60 - 45, 1, 1, 0, c_white, 1);
    gml_Script_scr_textoutline(x, (y - 60) + 5, "[+" + string(global.hunterGuildLevel * 10) + "% bonus]", 16776960, 0, 20, 600);
}
else
{
    gml_Script_scr_textoutline(x, (y - 60) + 5, "[+" + string(global.hunterGuildLevel * 10) + "% bonus]", 4210752, 0, 20, 600);
}

if (obj_quest.questType == "farm")
{
    draw_sprite_ext(spr_vocationOutline, 0, x + 120, y - 60 - 45, 1, 1, 0, c_white, 1);
    gml_Script_scr_textoutline(x + 120, (y - 60) + 5, "[+" + string(global.farmerGuildLevel * 10) + "% bonus]", 16776960, 0, 20, 600);
}
else
{
    gml_Script_scr_textoutline(x + 120, (y - 60) + 5, "[+" + string(global.farmerGuildLevel * 10) + "% bonus]", 4210752, 0, 20, 600);
}

draw_sprite_ext(spr_guildIcons, 0, x - 120, y - 60 - 45, 1, 1, 0, c_white, 1);

if (obj_quest.questType != "mine")
    draw_sprite_ext(spr_guildIcons, 0, x - 120, y - 60 - 45, 1, 1, 0, c_black, 0.8);

draw_sprite_ext(spr_blackbar, 0, x - 120 - 20, y - 60 - 72, 40, 1, 0, c_white, 1);
draw_sprite_ext(spr_xpbarsmall, 0, (x - 120 - 20) + 1, y - 60 - 72, (minerGuildXP / minerGuildMaxXP) * 38, 1, 0, c_white, 1);

if (minerGuildXP >= minerGuildMaxXP)
{
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    global.minerGuildLevel += 1;
    minerGuildXP -= minerGuildMaxXP;
    minerGuildMaxXP *= 2;
    global.mineBonusValue = 1.05 + ((global.minerGuildLevel / 50) * global.minerGuildLevel * (global.minerGuildLevel / 5));
    gml_Script_scr_updateBuildings();
    ini_write_real("Guilds", "Miner Level", global.minerGuildLevel);
    ini_write_real("Guilds", "Miner XP", minerGuildXP);
    ini_write_real("Guilds", "Miner Max XP", minerGuildMaxXP);
    ini_close();
    gml_Script_scr_playsound(s_raidWin, 0.9, 1.1, 0.7);
    gml_Script_twitch_chat_say("/me Miner's Guild level increased to level " + string(global.minerGuildLevel) + "!");
}

draw_sprite_ext(spr_guildIcons, 1, x, y - 60 - 45, 1, 1, 0, c_white, 1);

if (obj_quest.questType != "kill")
    draw_sprite_ext(spr_guildIcons, 1, x, y - 60 - 45, 1, 1, 0, c_black, 0.8);

draw_sprite_ext(spr_blackbar, 0, x - 20, y - 60 - 72, 40, 1, 0, c_white, 1);
draw_sprite_ext(spr_xpbarsmall, 0, (x - 20) + 1, y - 60 - 72, (hunterGuildXP / hunterGuildMaxXP) * 38, 1, 0, c_white, 1);

if (hunterGuildXP >= hunterGuildMaxXP)
{
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    global.hunterGuildLevel += 1;
    hunterGuildXP -= hunterGuildMaxXP;
    hunterGuildMaxXP *= 2;
    ini_write_real("Guilds", "Hunter Level", global.hunterGuildLevel);
    ini_write_real("Guilds", "Hunter XP", hunterGuildXP);
    ini_write_real("Guilds", "Hunter Max XP", hunterGuildMaxXP);
    ini_close();
    gml_Script_scr_updateBuildings();
    
    with (obj_player)
        gml_Script_scr_updateStats();
    
    gml_Script_scr_playsound(s_raidWin, 0.9, 1.1, 0.7);
    gml_Script_twitch_chat_say("/me Hunter's Guild level increased to level " + string(global.hunterGuildLevel) + "!");
}

draw_sprite_ext(spr_guildIcons, 2, x + 120, y - 60 - 45, 1, 1, 0, c_white, 1);

if (obj_quest.questType != "farm")
    draw_sprite_ext(spr_guildIcons, 2, x + 120, y - 60 - 45, 1, 1, 0, c_black, 0.8);

draw_sprite_ext(spr_blackbar, 0, (x + 120) - 20, y - 60 - 72, 40, 1, 0, c_white, 1);
draw_sprite_ext(spr_xpbarsmall, 0, ((x + 120) - 20) + 1, y - 60 - 72, (farmerGuildXP / farmerGuildMaxXP) * 38, 1, 0, c_white, 1);

if (farmerGuildXP >= farmerGuildMaxXP)
{
    ini_open(string(global.platformDir) + "Village Data/Data.ini");
    global.farmerGuildLevel += 1;
    farmerGuildXP -= farmerGuildMaxXP;
    farmerGuildMaxXP *= 2;
    global.farmBonusValue = 1.05 + ((global.farmerGuildLevel / 50) * global.farmerGuildLevel * (global.farmerGuildLevel / 5));
    gml_Script_scr_updateBuildings();
    ini_write_real("Guilds", "Farmer Level", global.farmerGuildLevel);
    ini_write_real("Guilds", "Farmer XP", farmerGuildXP);
    ini_write_real("Guilds", "Farmer Max XP", farmerGuildMaxXP);
    ini_close();
    gml_Script_scr_playsound(s_raidWin, 0.9, 1.1, 0.7);
    gml_Script_twitch_chat_say("/me Farmer's Guild level increased to level " + string(global.farmerGuildLevel) + "!");
}

draw_set_font(f_special);
draw_set_halign(fa_center);
gml_Script_scr_textoutline(x - 120, y - 60 - 20, "lv." + string(global.minerGuildLevel), 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x, y - 60 - 20, "lv." + string(global.hunterGuildLevel), 16777215, 0, 20, 600);
gml_Script_scr_textoutline(x + 120, y - 60 - 20, "lv." + string(global.farmerGuildLevel), 16777215, 0, 20, 600);
