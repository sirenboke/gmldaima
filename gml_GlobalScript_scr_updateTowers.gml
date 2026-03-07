self.scr_updateTowers = function()
{
    with (obj_portal)
    {
        global.towerBuilding[1][1] = 1 + ((global.towerBuilding[1][4] - 1) / 5);
        global.towerBuilding[2][1] = floor(100 * (1 + ((global.towerBuilding[2][4] - 1) / 5)) * global.soulBonus * (1 + global.corruptionShardEffect[5]));
        global.towerBuilding[3][1] = 1 + floor((global.towerBuilding[3][4] - 1) / 3);
        global.towerBuilding[4][1] = floor(1 + ((global.towerBuilding[4][4] - 1) / 5));
        
        if (global.towerBuilding[1][4] > 0)
        {
            if (alarm[1] <= 0)
                alarm[1] = global.towerBuilding[1][2] * room_speed;
        }
        
        if (global.towerBuilding[2][4] > 0)
        {
            if (alarm[2] <= 0)
                alarm[2] = global.towerBuilding[2][2] * room_speed;
        }
        
        if (global.towerBuilding[3][4] > 0)
        {
            if (alarm[3] <= 0)
                alarm[3] = global.towerBuilding[3][2] * room_speed;
        }
        
        if (global.towerBuilding[4][4] > 0)
        {
            if (alarm[4] <= 0)
                alarm[4] = global.towerBuilding[4][2] * room_speed;
        }
        
        global.towerBuilding[0][4] = 100000000 * (1 + ((global.towerBuilding[0][1] - 1) / 5));
        global.towerBuilding[0][7] = 5000000 * (1 + ((global.towerBuilding[0][1] - 6) / 10));
        global.towerBuilding[0][10] = round(5 * (1 + (global.towerBuilding[0][1] / 10)));
        global.towerBuilding[0][13] = 1 + floor(1 * (1 + (global.towerBuilding[0][1] / 10)));
        global.towerBuilding[0][2] = round(global.towerBuilding[0][1] * 500 * (1 + (global.towerBuilding[0][1] / 10)));
        global.towerBuilding[0][3] = round(floor(global.towerBuilding[0][2] / 20000) * floor(1 + (global.towerBuilding[0][1] / 20)));
        global.towerBuilding[0][4] = round(global.towerBuilding[0][4] * (1 + (global.towerBuilding[0][1] / 10)));
        global.towerBuilding[0][7] = round(global.towerBuilding[0][7] * (1 + (global.towerBuilding[0][1] / 10)));
        global.towerBuilding[0][10] = round(global.towerBuilding[0][10] * (1 + (global.towerBuilding[0][1] / 10)));
        global.towerBuilding[0][13] = round(global.towerBuilding[0][13] * (1 + (global.towerBuilding[0][1] / 10)));
        global.towerBuilding[0][4] *= global.globalGoldBonus;
        global.towerBuilding[0][7] *= global.globalXPBonus;
        
        if (global.towerBuilding[0][1] > 0)
        {
            if (alarm[5] <= 0)
                alarm[5] = global.towerBuilding[0][5] * room_speed;
        }
        
        if (global.towerBuilding[0][1] > 4)
        {
            if (alarm[6] <= 0)
                alarm[6] = global.towerBuilding[0][8] * room_speed;
        }
        
        if (global.towerBuilding[0][1] > 9)
        {
            if (alarm[7] <= 0)
                alarm[7] = global.towerBuilding[0][11] * room_speed;
        }
        
        if (global.towerBuilding[0][1] > 14)
        {
            if (alarm[8] <= 0)
                alarm[8] = global.towerBuilding[0][14] * room_speed;
        }
        
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        
        for (var i = 1; i < global.maxPortalTower; i++)
        {
            global.towerBuilding[i][5] = round(global.towerBuilding[i][4] * 100 * (i * 5) * (1 + (global.towerBuilding[i][4] / 5)));
            global.towerBuilding[i][6] = round(floor(global.towerBuilding[i][5] / 20000) * floor(1 + (global.towerBuilding[i][4] / 10)));
            global.towerBuilding[i][1] = global.towerBuilding[i][1] * (1 + (global.towerBuilding[i][4] / 10));
            
            if (i != 1)
                global.towerBuilding[i][1] = ceil(global.towerBuilding[i][1]);
            
            ini_write_real("Underworld", "Tower " + string(i) + " Building Production", global.towerBuilding[i][1]);
            ini_write_real("Underworld", "Tower " + string(i) + " Building Timer", ceil(alarm[i] / room_speed));
            ini_write_real("Underworld", "Tower " + string(i) + " Level", global.towerBuilding[i][4]);
        }
        
        ini_write_real("Underworld", "Outpost Level", global.towerBuilding[0][1]);
        ini_write_real("Underworld", "Outpost XP Production", global.towerBuilding[0][4]);
        ini_write_real("Underworld", "Outpost XP Timer", ceil(alarm[5] / room_speed));
        ini_write_real("Underworld", "Outpost Gold Production", global.towerBuilding[0][7]);
        ini_write_real("Underworld", "Outpost Gold Timer", ceil(alarm[6] / room_speed));
        ini_write_real("Underworld", "Outpost TP Production", global.towerBuilding[0][10]);
        ini_write_real("Underworld", "Outpost TP Timer", ceil(alarm[7] / room_speed));
        ini_write_real("Underworld", "Outpost Gem Production", global.towerBuilding[0][13]);
        ini_write_real("Underworld", "Outpost Gem Timer", ceil(alarm[8] / room_speed));
        ini_close();
    }
};
