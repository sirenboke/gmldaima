if (result == 0)
{
    c1 = 65280;
    c2 = 32768;
    text1 = "You won!";
}
else
{
    c1 = 255;
    c2 = 128;
    text1 = "You lost!";
}

draw_set_font(f_mid);
draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(x - 300, room_height - 300, x + 300, room_height, 0);
draw_set_alpha(1);

if (alarm[1] == -1)
{
    if (alarm[0] < (room_speed * 10))
    {
        if (global.enemyRaid == true && result == 1)
        {
            if (round(global.townHP - townLost) > 0)
                gml_Script_scr_textshadow(x, y + 120, "You got defeated!\nThe town lost " + gml_Script_scr_bigNumber(round(townLost * (global.stage / 100))) + " gold, " + gml_Script_scr_bigNumber(round(townLost * (global.stage / 100) * 1.5)) + " food and " + gml_Script_scr_bigNumber(round(townLost)) + " HP!", 16777215, 0, 20, 600);
            else
                gml_Script_scr_textshadow(x, y + 120, "You got defeated!\nEnemies looted all your resources...", 16777215, 0, 20, 600);
        }
        else
        {
            if (global.extraRewardsTimer < global.extraRewardsTimerMax && global.enemyRaid == false)
            {
                gml_Script_scr_textshadow(x, y + 120, "Raiders earned extra rewards! [" + string(global.raidTime) + "s, Time bonus +50%]");
                gml_Script_scr_textshadow(x, y + 140, "+" + gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus)) + " [+" + gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus * 0.5)) + "]");
                draw_sprite_ext(spr_resourceBonus, 2, x + 20 + (string_width(gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus)) + " [+" + gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus * 0.5)) + "]") / 2), y + 153, 1, 1, 0, c_white, 1);
                gml_Script_scr_textshadow(x, y + 160, "+" + gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus)) + " [+" + gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus * 0.5)) + "]");
                draw_sprite_ext(spr_xpBonus, 1, x + 20 + (string_width(gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus)) + " [+" + gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus * 0.5)) + "]") / 2), y + 173, 1, 1, 0, c_white, 1);
                gml_Script_scr_textshadow(x, y + 180, "Enemies slain: " + gml_Script_scr_bigNumber(global.raidKills));
                gml_Script_scr_textshadow(x, y + 200, "And an extra " + gml_Script_scr_bigNumber(round(global.raidGold * global.globalGoldBonus)) + " [+" + gml_Script_scr_bigNumber(round(global.raidGold * global.globalGoldBonus * 0.5)) + "]        for the town!", 16777215, 0, 20, 800);
                draw_sprite_ext(spr_resourceBonus, 2, x + ((string_width("And an extra " + gml_Script_scr_bigNumber(round(global.raidGold * global.globalGoldBonus)) + " [+" + gml_Script_scr_bigNumber(round(global.raidGold * global.globalGoldBonus * 0.5)) + "]    ") - string_width("    for the town!")) / 2), y + 213, 1, 1, 0, c_white, 1);
            }
            
            if (global.extraRewardsTimer >= global.extraRewardsTimerMax || global.enemyRaid == true)
            {
                gml_Script_scr_textshadow(x, y + 120, "Raiders earned extra rewards! [" + string(global.raidTime) + "s, No time bonus]");
                gml_Script_scr_textshadow(x, y + 140, "+" + gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus)));
                draw_sprite_ext(spr_resourceBonus, 2, x + 20 + (string_width(gml_Script_scr_bigNumber(round((global.raidGold / global.raidNumber) * global.globalGoldBonus))) / 2), y + 153, 1, 1, 0, c_white, 1);
                gml_Script_scr_textshadow(x, y + 160, "+" + gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus)));
                draw_sprite_ext(spr_xpBonus, 1, x + 20 + (string_width(gml_Script_scr_bigNumber(round(global.raidXP * global.globalXPBonus))) / 2), y + 173, 1, 1, 0, c_white, 1);
                gml_Script_scr_textshadow(x, y + 180, "Enemies slain: " + gml_Script_scr_bigNumber(global.raidKills));
                gml_Script_scr_textshadow(x, y + 200, "And an extra " + gml_Script_scr_bigNumber(round(global.raidGold * global.globalGoldBonus)) + "        for the town!", 16777215, 0, 20, 800);
                draw_sprite_ext(spr_resourceBonus, 2, x + ((string_width("And an extra " + gml_Script_scr_bigNumber(round(global.raidGold * global.globalGoldBonus)) + "    ") - string_width("    for the town!")) / 2), y + 213, 1, 1, 0, c_white, 1);
            }
        }
    }
}
