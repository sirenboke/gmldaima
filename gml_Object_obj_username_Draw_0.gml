draw_set_font(f_mid);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);

if (global.isTwitch == 0 && global.isKick == 0)
{
    gml_Script_scr_textgradient(x, y - 32, "Are you going to stream on Twitch(1) or Kick(2) [Kick temporarily not supported]?:", 65535, 4235519, undefined, 20, 1000);
}
else if (showmessage == true)
{
    draw_self();
    draw_text(x - 1, y + 1, string_hash_to_newline(msg + cursor));
    draw_text(x + 1, y + 1, string_hash_to_newline(msg + cursor));
    draw_text(x - 1, y - 1, string_hash_to_newline(msg + cursor));
    draw_text(x + 1, y - 1, string_hash_to_newline(msg + cursor));
    draw_set_color(c_black);
    draw_text(x, y, string_hash_to_newline(msg + cursor));
    gml_Script_scr_textgradient(x, y - 32, "Enter your Stream name here:", 65535, 4235519);
}
