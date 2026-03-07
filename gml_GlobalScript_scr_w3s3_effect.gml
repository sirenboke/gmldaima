self.scr_w3s3_effect = function()
{
    var _r28 = -1;
    
    if (is_undefined(argument[0]))
    {
        show_debug_message("Argument0 undefined, set to default");
        _r28 = 0;
    }
    else
    {
        _r28 = argument[0];
        show_debug_message("Argument0 is defined as " + string(argument[0]));
    }
    
    if (_r28 <= 0)
        _r28 = 1;
    
    if (charging == true && buffed > 0)
    {
        if (w3s3_distance > 0 && mySpecialBuff[0] > 0)
            _chargingInt += gml_Script_scr_statChange(myStatInfo[9][3] * mySpecialBuff[0] * _r28, undefined, 9, undefined, undefined);
        
        if (w3s3_distance > 0.5 && mySpecialBuff[2] > 0)
            gml_Script_scr_shield(myStatInfo[9][3] * mySpecialBuff[2], undefined, 1);
        
        gml_Script_scr_statChange(0.15, undefined, 10, undefined, undefined);
        gml_Script_scr_alarm_start(3, room_speed / 2, gml_Script_scr_w3s3_effect, _r28);
        w3s3_distance += 0.5;
        buffed -= 1;
        
        if (buffed <= 0)
        {
            buffed = 0;
            
            if (_chargingInt > 0)
                gml_Script_scr_statChange(_chargingInt, -1, 9, undefined, undefined);
            
            gml_Script_scr_statChange(0.15 * (w3s3_distance * 2), -1, 10, undefined, undefined);
            canAttack = true;
            charging = false;
            baseSpeed = 1;
            w3s3_distance = 0;
            _chargingInt = 0;
        }
    }
    else
    {
        buffed = 0;
        
        if (_chargingInt > 0)
            gml_Script_scr_statChange(_chargingInt, -1, 9, undefined, undefined);
        
        gml_Script_scr_statChange(0.15 * (w3s3_distance * 2), -1, 10, undefined, undefined);
        canAttack = true;
        charging = false;
        baseSpeed = 1;
        w3s3_distance = 0;
        _chargingInt = 0;
    }
    
    if (myRaidNumber != 0)
    {
        charging = false;
        buffed = 0;
    }
    
    show_debug_message("shield charge distance: " + string(w3s3_distance));
};
