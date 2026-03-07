with (obj_showMilestone)
{
    if (myNumber > other.myNumber)
    {
        alarm[2] = other.alarm[0] + room_speed;
        alarm[0] = alarm[2] + ((myNumber - other.myNumber) * room_speed * 10);
    }
}

show_debug_message("Milestone #" + string(myNumber) + " ended.");
