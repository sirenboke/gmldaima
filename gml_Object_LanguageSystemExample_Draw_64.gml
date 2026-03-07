draw_set_font(f_small);
draw_set_color(c_white);
draw_text(10, 10, "1 - ENGLISH");
draw_text(10, 30, "2 - TURKISH");
draw_text(10, 50, "3 - GERMAN");

for (var i = 0; i < gml_Script_lang_length(); i++)
{
    var languageName = gml_Script_lang_get(i).name;
    draw_text(10, 96 + (i * 20), languageName);
}

draw_text(room_width / 2, room_height / 2, "TRANSLATE : " + gml_Script_lang("PLAY"));
draw_text(room_width / 2, (room_height / 2) + 20, "STATIC TRANSLATE : " + text);
