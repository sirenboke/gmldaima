if (global.dev == 1)
{
    with (obj_keyFrag)
        instance_destroy();
    
    with (obj_keyFrag2)
        instance_destroy();
    
    global.keyFrags = 1;
    global.bossTier = 0;
    global.keyFragsTier = 0;
}
