global.userName = "";
showmessage = false;
checkname = "";
x = room_width / 2;
y = room_height / 2;
msg = "";
limit = 11;
cursor = "|";
delay = room_speed;
alarm[0] = delay;
global.isTwitch = 0;
global.isKick = 0;

if (global.isKick == 1)
    global.isKick = 0;

global.isTwitch = 1;

if (showmessage == false)
{
    keyboard_string = "";
    msg = "";
    showmessage = true;
}
