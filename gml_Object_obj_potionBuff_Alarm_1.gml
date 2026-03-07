if (instance_exists(player))
{
    var _heal = player.myStatInfo[8][3] * 0.2;
    
    with (player)
        gml_Script_scr_player_heal(_heal / 15);
    
    alarm[1] = room_speed / 5;
}
else
{
    instance_destroy();
}
