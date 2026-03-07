if (global.townHP < global.townMaxHP)
    global.townHP += (0.1 + (0.1 * instance_number(obj_player)));

if (global.townHP > global.townMaxHP)
    global.townHP = global.townMaxHP;

alarm[0] = room_speed;

if (maxSeconds < 0)
{
    maxSeconds = 59;
    maxMinutes -= 1;
}

if (maxMinutes < 0)
{
    maxMinutes = 59;
    maxHours -= 1;
}

if (maxHours < 0)
{
    maxHours = 24;
    maxDays -= 1;
}

if (global.seasonTime >= 604800 && global.lockedClass == true)
    global.lockedClass = false;
