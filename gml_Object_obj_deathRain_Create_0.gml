global.rainDmg = 10;
global.rainArmor = 0.03;
gml_Script_twitch_chat_say("/color Red");
gml_Script_twitch_chat_say_direct("/me Dark blood is falling from the sky...");
gml_Script_twitch_chat_say("/color FireBrick");
global.deathrainpart_emitter = part_emitter_create(global.over_partsys);
rainParticles = 0;
