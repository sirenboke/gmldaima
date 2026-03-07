if (alarm[0] > (room_speed * 2))
{
    with (gml_Script_instance_create(x + irandom_range(-170, 170), y + irandom_range(-2, 4), obj_blessingParticles))
    {
        color = 65535;
        alpha = random_range(0.1, 0.3);
        spd = 0.008;
    }
    
    alarm[1] = room_speed / 4;
}
