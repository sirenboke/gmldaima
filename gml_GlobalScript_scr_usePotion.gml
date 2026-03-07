self.scr_usePotion = function()
{
    if (global.challenge_canPot == 0)
        exit;
    
    if (potion > 0)
    {
        potion -= 1;
        potHeal = myStatInfo[8][3] / 3;
        gml_Script_scr_player_heal(potHeal);
        
        if (player.myTier >= 2)
        {
            with (gml_Script_instance_create(x, y, obj_potionBuff))
            {
                player = other.id;
                heal = player.myStatInfo[8][3] * 0.2;
            }
        }
        
        if (player.myTier >= 3)
        {
            poisonDmg = 0;
            bleedTimer = 0;
            
            if (moveSpeed < omoveSpeed)
                moveSpeed = omoveSpeed;
        }
        
        if (global.chatSpam <= 1 && potion == player.myTier)
            gml_Script_twitch_chat_say_direct("/me " + string(name) + " used their tier " + string(player.myTier) + " potion and healed " + gml_Script_scr_bigNumber(round(potHeal)) + " health!");
        
        if (global.chatSpam <= 1 && potion < player.myTier)
            gml_Script_twitch_chat_say("/me " + string(name) + " used their tier " + string(player.myTier) + " potion and healed " + gml_Script_scr_bigNumber(round(potHeal)) + " health!");
        
        gml_Script_scr_playsound(s_potion1, 0.8, 1.2, 1);
    }
    else if (global.chatSpam <= 1)
    {
        gml_Script_twitch_chat_say("/me " + string(name) + " you ran out of potions!");
    }
};
