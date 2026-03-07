if (type <= 30)
{
    if (type == other.type)
    {
        if (parent == other.parent)
        {
            if (id < other.id)
            {
                if (is_real(value))
                {
                    value += other.value;
                    
                    if (value >= 1000000000000000000)
                    {
                        with (other)
                            instance_destroy();
                        
                        instance_destroy();
                        exit;
                    }
                }
                
                c1 = other.c1;
                c2 = other.c2;
                
                with (gml_Script_instance_create(other.xx, other.yy, obj_float))
                {
                    type = other.type;
                    value = other.value;
                    parent = other.parent;
                    
                    if (is_real(value))
                    {
                        if (value >= 100)
                            value = round(value);
                    }
                    
                    if (type == 30)
                    {
                        c1 = 16777215;
                        c2 = 16777215;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 26)
                    {
                        c1 = 16776960;
                        c2 = 65280;
                        str = "+";
                        str2 = " gems";
                    }
                    
                    if (type == 17)
                    {
                        c1 = 16777215;
                        c2 = 16776960;
                        str = "+";
                        str2 = "";
                    }
                    
                    if (type == 16 || type == 23)
                    {
                        c1 = 16777215;
                        c2 = 12632256;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 15)
                    {
                        c1 = 16777215;
                        c2 = 16777215;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 14)
                    {
                        c1 = 65280;
                        c2 = 128;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 13)
                    {
                        c1 = 16776960;
                        c2 = 65280;
                        str = "+";
                        str2 = "";
                    }
                    
                    if (type == 12 || type == 22)
                    {
                        c1 = 16777215;
                        c2 = 12632256;
                        str = "";
                        str2 = "";
                    }
                    
                    if (type == 11)
                    {
                        c1 = 16776960;
                        c2 = 8421376;
                        str = "+";
                        str2 = " TP";
                    }
                    
                    if (type == 10)
                    {
                        c1 = 16777215;
                        c2 = 12632256;
                        str = "";
                        str2 = "";
                    }
                    
                    if ((type == 9 || type == 21) && is_real(value))
                    {
                        c1 = 16777215;
                        c2 = 12632256;
                        str = "";
                        str2 = "";
                    }
                    
                    if (type == 8)
                    {
                        c1 = 255;
                        c2 = 128;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 7)
                    {
                        c1 = 65280;
                        c2 = 32768;
                        str = "+";
                        str2 = "";
                    }
                    
                    if (type == 6)
                    {
                        c1 = 255;
                        c2 = 128;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 5)
                    {
                        c1 = 65535;
                        c2 = 4235519;
                        str = "+";
                        str2 = " energy";
                    }
                    
                    if (type == 4)
                    {
                        c1 = 12632256;
                        c2 = 4210752;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 3)
                    {
                        c1 = 65280;
                        c2 = 32768;
                        str = "+";
                        str2 = "";
                    }
                    
                    if (type == 2)
                    {
                        c1 = other.c1;
                        c2 = other.c2;
                        str = "-";
                        str2 = "";
                    }
                    
                    if (type == 1)
                    {
                        c1 = 65535;
                        c2 = 4235519;
                        str = "+";
                        str2 = "";
                    }
                    
                    if (type == 0)
                    {
                        c1 = 16711935;
                        c2 = 8388736;
                        str = "+";
                        str2 = "";
                    }
                    
                    if (is_real(value))
                        text = str + gml_Script_scr_bigNumber(value) + str2;
                    
                    if (is_string(value) && type != 20)
                    {
                        text = string(value);
                        c1 = 16777215;
                        c2 = 16777215;
                    }
                    
                    if (is_string(value) && type == 20)
                    {
                        text = string(value);
                        c1 = 65535;
                        c2 = 4235519;
                    }
                    
                    if (is_string(value) && type == 21)
                    {
                        text = string(value);
                        c1 = 65535;
                        c2 = 4235519;
                    }
                    
                    if (is_string(value) && type == 24)
                    {
                        text = "Invulnerable!";
                        c1 = 65535;
                        c2 = 4235519;
                    }
                    
                    if (is_string(value) && type == 25)
                    {
                        text = "Level up!";
                        c1 = 16711935;
                        c2 = 8388736;
                    }
                }
                
                with (other)
                    instance_destroy();
                
                instance_destroy();
            }
        }
    }
}
