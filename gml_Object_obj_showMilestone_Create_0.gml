alarm[1] = 1;
x = (room_width / 2) - 250;
y = (room_height / 2) - 150;
alpha = 0.5;
rot = 0;
myNumber = global.milestoneCounter;
global.milestoneCounter += 1;
alarm[2] = room_speed * (myNumber + 1);
alarm[0] = room_speed * 10;

with (obj_showMilestone)
{
    if (myNumber > other.myNumber)
    {
        alarm[2] = other.alarm[0] + room_speed;
        alarm[0] = alarm[2] + ((myNumber - other.myNumber) * room_speed * 10);
    }
}

if (instance_number(obj_showMilestone) <= 1)
{
    alarm[2] = room_speed;
    alarm[0] = room_speed * 10;
}

show_debug_message("Milestone #" + string(myNumber) + " reached!");
