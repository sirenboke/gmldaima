if (type != other.type && id > other.id && player == other.player)
{
    alarm[1] = 1;
    alarm[0] = room_speed * 5;
    show = false;
}

if (type == other.type && id > other.id && player == other.player)
{
    if (sign(value) == sign(other.value))
    {
        value += other.value;
        
        if (value > 0)
        {
            c1 = 65280;
            text = "+" + string(value);
        }
        
        if (value < 0)
        {
            c1 = 255;
            text = string(value);
        }
        
        instance_destroy(other);
    }
}
