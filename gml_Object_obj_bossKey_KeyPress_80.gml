if (global.dev)
{
    if (global.console == false)
    {
        portalReady = false;
        global.portalPoints = 0;
        global.portalID += 1;
        alarm[0] = -1;
        global.randAura = irandom_range(1, global.totalAuras);
        ds_list_clear(global.raidListPortalName);
        ds_list_clear(global.raidListPortalClass);
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        ini_key_delete("Underworld", "Portal List Names");
        ini_key_delete("Underworld", "Portal List Classes");
        ini_close();
        
        with (obj_player)
        {
            ini_open(string(global.platformDir) + string(myAccDir) + "Character Data.ini");
            toPortal = false;
            usePortal = -1;
            ini_write_real("Portal", "Portal ID", -1);
            ini_close();
        }
        
        gml_Script_scr_playsound(s_portalClose, 0.9, 1.1, 0.5);
        audio_stop_sound(s_portalLoop);
    }
}
