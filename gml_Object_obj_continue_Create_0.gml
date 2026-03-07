var firsttime = 0;
ini_open(string(global.platformDir) + "Core Data/Login.ini");
var decoded = ini_read_string("Login", "Status", "0");

if (decoded != "-offline-")
{
    if (decoded != "0")
    {
        repeat (4)
            firsttime = base64_decode(decoded);
        
        firsttime = real(base64_decode(firsttime));
    }
}
else
{
    firsttime = 1;
}

ini_close();

if (global.isTwitch == 0 && global.isKick == 0)
    alarm[0] = -1;

if (firsttime == 1)
{
    ini_open(string(global.platformDir) + "Core Data/Active Players.ini");
    savedMaxPlayers = ini_read_real("Saved Players", "Last Save", -1);
    ini_close();
    text = "Continue";
    x = room_width / 2;
    y = (room_height / 2) + 4;
}
else
{
    instance_destroy();
}

alarm[0] = room_speed * 20;
