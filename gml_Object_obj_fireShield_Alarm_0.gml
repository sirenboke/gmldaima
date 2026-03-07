if (instance_exists(obj_warrior))
{
    with (obj_warrior)
    {
        if (fireshieldDmg > 0)
        {
        }
    }
}

audio_sound_gain(ember, 0, room_speed);
instance_destroy();
