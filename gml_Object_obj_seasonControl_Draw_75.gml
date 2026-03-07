if (gml_Script_live_call())
    return global.live_result;

draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_font(f_mid);
var _datetime = date_current_datetime();
var _time = gml_Script_scr_dateFormat(_datetime, "%H:%M");
draw_set_halign(fa_center);

if (room != r_seasonEnd)
    totalSeconds += (1 / room_speed);

var t = 86400;
var days = totalSeconds div t;
t = 3600;
var hours = (totalSeconds div t) % 24;
t = 60;
var minutes = (totalSeconds div t) % 60;
t = 1;
var seconds = (totalSeconds div t) % 60;
days = string(days) + "d ";

if (hours < 10)
    hours = "0" + string(hours) + "h ";
else
    hours = string(hours) + "h ";

if (minutes < 10)
    minutes = "0" + string(minutes) + "m ";
else
    minutes = string(minutes) + "m ";

if (seconds < 10)
    seconds = "0" + string(seconds) + "s ";
else
    seconds = string(seconds) + "s ";

if (string_digits(days) == "0")
    days = "";

if (string_digits(hours) == "0")
    hours = "";

var timerDisplay = days + hours + minutes + seconds;
timePlayedString = timerDisplay;

if (room != r_seasonEnd)
{
    draw_set_halign(fa_right);
    gml_Script_scr_textoutline(1415, 58, _time, 16777215, 0, 34, 1000);
    draw_set_halign(fa_left);
    
    if (!global.console)
        gml_Script_scr_textoutline(10, 95, "UPS: " + string(fps) + "/30", 16777215, 0, 20, 500);
}
else
{
    draw_set_halign(fa_right);
    gml_Script_scr_textoutline(room_width - 90, 40, "Server time: " + string(_time), 16777215, 0, 34, 1000);
    gml_Script_scr_textoutline(room_width - 90, 20, "Campaign: #" + string(global.season - 1) + " lasted " + timerDisplay, 16777215, 0, 34, 1000);
    obj_seasonEnd.showCampaignTime = timePlayedString;
    draw_set_halign(fa_left);
}

if (room != r_seasonEnd)
{
    draw_set_font(f_big);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    gml_Script_scr_textoutline(room_width - 250, 25, "CAMPAIGN #" + string(global.season), 16777215, 0, 34, 5000);
    draw_set_font(f_mid);
    
    if (global.finalWar == false)
    {
        if (global.totalCorruption > 0)
        {
            if (alarm[3] == -1)
            {
                if (floor(tabDisplay) == 1)
                    gml_Script_scr_textoutline(room_width - 250, 58, "World ?Corruption: " + string(global.totalCorruption) + "%", 255, 0, 34, 1000);
                
                if (floor(tabDisplay) == 0)
                    gml_Script_scr_textoutline(room_width - 250, 58, "Time played: " + timerDisplay, 16777215, 0, 34, 1000);
            }
            else
            {
                gml_Script_scr_textoutline(room_width - 250, 58, "The end is here... (" + string(round(alarm[3] / room_speed / 60)) + "m)", 255, 0, 34, 1000);
            }
        }
        else
        {
            gml_Script_scr_textoutline(room_width - 250, 58, "Time played: " + timerDisplay, 16777215, 0, 34, 1000);
        }
    }
    else
    {
        draw_set_halign(fa_center);
        gml_Script_scr_textshadow(room_width - 250, 58, "The end is here...", 255, 0, 34, 1000);
        
        if (obj_raid.alarm[9] > 0)
        {
            draw_set_font(f_big);
            draw_sprite_ext(spr_building, 0, room_width / 2, (room_height / 2) + 10, 25, 2, 0, c_white, 1);
            gml_Script_scr_textoutlineBIG(room_width / 2, room_height / 2, "WAR STARTING IN: " + string(round(obj_raid.alarm[9] / room_speed)) + " SECONDS", 255, 0, 20, 1000);
        }
    }
}
