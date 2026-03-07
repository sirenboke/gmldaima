if (global.stage < global.ostage || global.stage > global.ostage)
{
    global.stage = global.ostage;
}
else
{
    global.stage += 1;
    global.ostage += 1;
    global.stage = global.ostage;
    
    if ((global.ostage % 50) == 0)
    {
        ini_open(string(global.platformDir) + "Village Data/Data.ini");
        
        if (ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 1", 0) == 0)
        {
            specialRaid[floor(global.ostage / 50)][0] = 1;
            
            if (global.ostage == 50)
            {
                var _relic1 = irandom_range(1, global.maxUniqueItems);
                var _relic2;
                
                do
                    _relic2 = irandom_range(1, global.maxUniqueItems);
                until (_relic2 != _relic1);
                
                var _relic3;
                
                do
                    _relic3 = irandom_range(1, global.maxUniqueItems);
                until (_relic3 != _relic1 && _relic3 != _relic2);
                
                specialRaid[floor(global.ostage / 50)][1] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 1", _relic1);
                specialRaid[floor(global.ostage / 50)][2] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 2", _relic2);
                specialRaid[floor(global.ostage / 50)][3] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 3", _relic3);
            }
            else
            {
                var _relic1;
                
                do
                    _relic1 = irandom_range(1, global.maxUniqueItems);
                until (_relic1 != specialRaid[floor(global.ostage / 50) - 1][1] && _relic1 != specialRaid[floor(global.ostage / 50) - 1][2] && _relic1 != specialRaid[floor(global.ostage / 50) - 1][3]);
                
                var _relic2;
                
                do
                    _relic2 = irandom_range(1, global.maxUniqueItems);
                until (_relic2 != _relic1 && _relic2 != specialRaid[floor(global.ostage / 50) - 1][1] && _relic2 != specialRaid[floor(global.ostage / 50) - 1][2] && _relic2 != specialRaid[floor(global.ostage / 50) - 1][3]);
                
                var _relic3;
                
                do
                    _relic3 = irandom_range(1, global.maxUniqueItems);
                until (_relic3 != _relic1 && _relic3 != _relic2 && _relic3 != specialRaid[floor(global.ostage / 50) - 1][1] && _relic3 != specialRaid[floor(global.ostage / 50) - 1][2] && _relic3 != specialRaid[floor(global.ostage / 50) - 1][3]);
                
                specialRaid[floor(global.ostage / 50)][1] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 1", _relic1);
                specialRaid[floor(global.ostage / 50)][2] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 2", _relic2);
                specialRaid[floor(global.ostage / 50)][3] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 3", _relic3);
            }
            
            specialRaid[floor(global.ostage / 50)][4] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Type", irandom(2));
            ini_write_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Respawn Time", -1);
            ini_write_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 1", specialRaid[floor(global.ostage / 50)][1]);
            ini_write_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 2", specialRaid[floor(global.ostage / 50)][2]);
            ini_write_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 3", specialRaid[floor(global.ostage / 50)][3]);
            ini_write_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Type", specialRaid[floor(global.ostage / 50)][4]);
            custom_alarm[50 + floor(global.ostage / 50)][0] = specialRaid[floor(global.ostage / 50)][0];
            show_debug_message("Territory Boss " + string(floor(global.ostage / 50)) + " unlocked for the first time!");
        }
        else
        {
            specialRaid[floor(global.ostage / 50)][0] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Respawn Time", -1);
            specialRaid[floor(global.ostage / 50)][1] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 1", 1 + irandom(global.maxUniqueItems - 1));
            specialRaid[floor(global.ostage / 50)][2] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 2", 1 + irandom(global.maxUniqueItems - 1));
            specialRaid[floor(global.ostage / 50)][3] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Relic 3", 1 + irandom(global.maxUniqueItems - 1));
            specialRaid[floor(global.ostage / 50)][4] = ini_read_real("Minibosses", "Miniboss " + string(floor(global.ostage / 50)) + " Type", irandom(2));
        }
        
        ini_close();
    }
}

if (global.stage > 10)
    global.raidCost = 0;

boss = false;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
ini_write_real("Stats", "Stage", global.stage);
ini_close();
