if (y <= 150)
{
    draw_set_font(f_mid);
    draw_set_halign(fa_right);
    x = room_width - 510;
}

if (y >= (room_height - 400))
    draw_set_font(f_mid);

draw_set_font(f_special);
draw_set_halign(fa_center);

if (text == "Dodged!")
{
    c1 = 16777215;
    c2 = 12632256;
}

draw_text_colour(x + 1, y, string_hash_to_newline(text), c_black, c_black, c_black, c_black, alpha);
draw_text_colour(x - 1, y, string_hash_to_newline(text), c_black, c_black, c_black, c_black, alpha);
draw_text_colour(x, y + 2, string_hash_to_newline(text), c_black, c_black, c_black, c_black, alpha);
draw_text_colour(x, y - 1, string_hash_to_newline(text), c2, c2, c2, c2, alpha);
draw_text_colour(x, y, string_hash_to_newline(text), c1, c1, c2, c2, alpha);
y -= (yMove * global.roomSpeed);
yMove -= 0.04;
x += (xMove * global.roomSpeed);
alpha -= (0.01 * global.roomSpeed);

if (alpha <= 0)
    instance_destroy();
