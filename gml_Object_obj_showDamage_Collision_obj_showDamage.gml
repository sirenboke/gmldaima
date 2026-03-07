if (type == other.type)
{
    if (parent == other.parent)
    {
        if (id < other.id)
        {
            if (is_real(value))
                value += other.value;
            
            c1 = other.c1;
            c2 = other.c2;
            
            with (gml_Script_instance_create(other.xx, other.yy, obj_showDamage))
            {
                c1 = other.c1;
                c2 = other.c2;
                type = other.type;
                value = other.value;
                parent = other.parent;
                str = "-";
                str2 = "";
                
                if (is_real(value))
                {
                    if (value >= 100)
                        value = round(value);
                    
                    text = str + gml_Script_scr_bigNumber(value) + str2;
                }
            }
            
            with (other)
                instance_destroy();
            
            instance_destroy();
        }
    }
}
