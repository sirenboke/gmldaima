q[0] = "Type " + string(global.cmdPrefix) + "help to see an extended guide of the game.";
q[1] = "Every class has a global buff. Warriors -> Extra Armor, Rogues -> Extra Dexterity, Archers -> Extra Luck, Mages -> Extra Fury Gain, Farmers -> Higher gold and food yield in Town.";
q[2] = "Each class has its own 3 special abilities. Choose the one that fits your playstyle with " + string(global.cmdPrefix) + "setskill#";
q[3] = "Using " + string(global.cmdPrefix) + "quit will save your character stats and items, allowing you to " + string(global.cmdPrefix) + "join as another character if desired. The game autosaves every 1 hour.";
q[4] = "If an enemy raid succeeds, your village will lose part of its HP and resources. If the town HP reaches 0, enemies will entirely loot the town resources!";
q[5] = "If an enemy raid succeeds, players that were not defending will lose their HP and go to an idle state.";
q[6] = "If you experience any bug or glitch, feel free to join the " + string(global.cmdPrefix) + "discord and let me know!";
q[7] = "The game is still in development and there will be key changes in the future.";
q[8] = "If you participate in quests you will get extra rewards and make the guilds grow faster.";
q[9] = "Join !raids to get items, gold and XP. You will only get the raid rewards if you were in it. Use !switch to let the next ally fight for you if you are not strong enough.";
q[10] = "Raid items will get automatically equipped if you can use them. Unused raid items will get recycled on the forge by the blacksmith, allowing him to craft forging materials to upgrade your items.";
q[11] = "Each level up will reward you with 1 talent point, 5 more every 10 levels, 5 more every 50, and 10 more every 100 (they stack with each other), which you can use in the academy to upgrade your base stats. " + string(global.cmdPrefix) + "!talent.";
q[12] = "You can " + string(global.cmdPrefix) + "donate gold, food and gems to the Town to help upgrade its buildings. You can also " + string(global.cmdPrefix) + "spend your own resources to upgrade buildings.";
q[13] = "The blacksmith will upgrade your items if he has the required materials. Use " + string(global.cmdPrefix) + "forge #*# to upgrade an " + string(global.cmdPrefix) + "!item.";
q[14] = "You can level up guilds by participating in the quests they give you. Each time you fill your contribution bar, the quest guild will earn XP.";
q[15] = "Subscribe to @Room_001 to unlock emotes, auto-switch, auto-loot, auto-buy, the " + string(global.cmdPrefix) + "!Legend status and all Kenji's " + string(global.cmdPrefix) + "!Diary Quests, as well as a sub-only 10%[x] XP and resource gain bonus and 50 Honor Points! (Rewards can take up to 1h to be received)";
q[16] = "Type " + string(global.cmdPrefix) + "! before a command to see information about it (" + string(global.cmdPrefix) + "!raid, " + string(global.cmdPrefix) + "!forge, " + string(global.cmdPrefix) + "!aura, " + string(global.cmdPrefix) + "!skill, " + string(global.cmdPrefix) + "!talent, " + string(global.cmdPrefix) + "!boss...).";
q[17] = "There are certain commands that go by " + string(global.cmdPrefix) + "? as a prefix, they will show you precise information (" + string(global.cmdPrefix) + "?relic, " + string(global.cmdPrefix) + "?pet, " + string(global.cmdPrefix) + "?vocation, " + string(global.cmdPrefix) + "?aura, " + string(global.cmdPrefix) + "?skill...).";
q[18] = "Upon reaching a higher status, you will receive an extra 50 talent points (Hero, Legend...).";
q[19] = "Remember to spend your " + string(global.cmdPrefix) + "!talent points every now and then. ";
q[20] = "Download the game for free: https://erohz.itch.io/tpdr.";
q[21] = "You can name builds for specific events (portal, raid, guard), and your character will automatically change builds when that event happens (" + string(global.cmdPrefix) + "renamebuild# portal).";
q[22] = "You can flag up to 10 Relics as favorite (" + string(global.cmdPrefix) + "favrelic#), preventing them from being recycled by accident. @Room_001 subscribers will also automatically try to buy and loot them if " + string(global.cmdPrefix) + "autobuy and " + string(global.cmdPrefix) + "autoloot are enabled.";
q[23] = "Increase !!Guilds levels by completing quests to boost !!Chests' value and increase Guilds bonuses in each of their fields.";
q[24] = "Dungeon !!Bosses drop better rewards and are much stronger than regular monsters, but they will escape if you don't defeat them in a couple of minutes.";

if (global.premiumChannel == 1)
    q[25] = "Tips and cheers will reward you with Honor Points (only on " + string(global.cmdPrefix) + "!premium channels). 1€/100bits = 10 Honor Points https://streamelements.com/" + string(global.channelName) + "/tip (This is a Premium Channel room00Starsmall )";
else
    q[25] = string(global.cmdPrefix) + "!Premium Channels are big supporters of the game (get Premium version by subscribing with Tier 3 on @Room_001 https://www.twitch.tv/subs/room_001 ), and they can directly reward their players with Honor Points when receiving tips and cheers! (This is currently not a Premium Channel)";

q[26] = "As a streamer, you can increase or decrease the player limit with " + string(global.cmdPrefix) + "setmaxplayers# command (5 to 99). Characters that are AFK (sleeping at Inn) will be saved and kicked if the Town population is maxed out so other players can join.";
q[27] = "You can spend your !Honor Points in the !!Honor Shop (Full list of Honor Shop items: https://docs.google.com/document/d/1ccoonL4PnuEFQlvhb53imMXsc-nfZWkboV2tIFWmlW8 ).";
q[28] = "Entering the " + string(global.cmdPrefix) + "!Corrupted Dimension for the first time will inevitably seal your destiny.";
q[29] = "The " + string(global.cmdPrefix) + "?skill command shows your ability description with dynamic values, indicating what type of scaling each value has (if any other than ability level).";
q[30] = "When the Witch Hut is upgraded to level 2, in addition to extra souls income and longer enchanting duration, you will gain access to " + string(global.cmdPrefix) + "!gemstone cutting, which allows you to increase certain stats of your choice.";
q[31] = "Ranged characters can " + string(global.cmdPrefix) + "swap their raiding position between ranged and melee, granting flexiblity and opening the door for different party combinations. All characters can also " + string(global.cmdPrefix) + "raidpreference(first,default,last) to determine a raiding order position preference. By default, raiders fight from lower to higher level.";
tipsList = array_length_1d(q) - 1;
text = q[irandom(tipsList)];
alarm[0] = room_speed * 20;
alarm[1] = room_speed * 120;
layer = obj_raid.layer;
depth = obj_raid.depth - 1;
