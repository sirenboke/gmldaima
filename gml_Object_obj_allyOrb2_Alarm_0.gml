dmg /= dmgReduction;
bounces -= 1;

if (bounces > 1)
{
    with (gml_Script_instance_create(x, y, obj_allyOrb2))
    {
        dmg = other.dmg;
        dmgReduction = other.dmgReduction;
        myID = other.myID + 1;
        bounces = other.bounces;
        parent = other.target;
    }
}

instance_destroy();
