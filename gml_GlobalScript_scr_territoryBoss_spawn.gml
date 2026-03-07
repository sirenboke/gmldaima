self.scr_territoryBoss_spawn = function()
{
    var _stage = string(argument[0]);
    var _raidStage = 0;
    var _bossType = "Territory Boss ";
    
    if (string_digits(_stage) != "")
    {
        _stage = real(_stage);
        _raidStage = _stage * 50;
        
        if ((_stage % 5) == 0 && (_stage % 20) != 0)
        {
            _bossType = "Biome Boss ";
            _stage /= 5;
        }
        
        if ((_stage % 20) == 0)
        {
            _bossType = "Legendary Boss ";
            _stage /= 20;
        }
    }
    
    show_debug_message("/me " + string(_bossType) + string(_stage) + " has been detected patrolling our lands! (!raid" + string(_raidStage) + ")");
    gml_Script_twitch_chat_say("/me SMOrc " + string(_bossType) + string(_stage) + " has been detected patrolling our lands! (!raid" + string(_raidStage) + ")");
};
