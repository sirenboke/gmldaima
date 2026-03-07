draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text(500, 200, "Abbreviated Number");
draw_text(500, 250, gml_Script_Number_Abbreviate(global.money));
draw_text(500, 350, "Numbers Lineup");

for (var i = 0; i < array_length(global.money); i++)
    draw_text(500 - (40 * i), 400, string(global.money[i]));
