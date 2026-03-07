randomize();
gc_enable(true);
gc_target_frame_time(-100);
audio_group_load(m_finis_cinematic1);
gml_Script_scr_playsound(s_intro, 1, 1, 1);
global.debug_timer = 0;
global.debug_interval = room_speed * 10;
global.language = 0;
global.maxNumber = 9000000000000000000;
global.textBulk = "";
global.textBulkCount = 0;
global.bulkActive = false;
gml_Script_scr_alarm_initialize(5);
global.f_asian = font_add(working_directory + "zpix.ttf", 12, false, false, 32, 127);
debug = false;
global.console = false;
global.showStatChange = true;
fullscreen = false;
global.borderless = false;
displayFoodText = "";
displayGoldText = "";
chestRot = 0;
_chestRot1 = 0;
_chestRot2 = 0;
_chestRot3 = 0;
showPlayers = 0;
global.buildingMsgDisplay = 0;

if (audio_is_playing(s_menutheme))
    audio_stop_sound(s_menutheme);

if (audio_is_playing(m_peaceful_1))
    audio_stop_sound(m_peaceful_1);

global.damageTypes = 4;
global.honorRanking = gml_Script_scr_ds_grid_create(2, 0);
ini_open(string(global.platformDir) + "Core Data/Permanent.ini");
global.cmdPrefix = ini_read_string("Town", "Prefix", "!");
global.bigNumberLetter[0] = "";
global.bigNumberLetter[1] = "k";
global.bigNumberLetter[2] = "M";
global.bigNumberLetter[3] = "B";
global.bigNumberLetter[4] = "T";
global.bigNumberLetter[5] = "Q";
global.bigNumberLetter[6] = "C";
global.bigNumberLetter[7] = "S";
global.BIG_BASE = 1000000000;
global.avoidLeak = false;
global.campaignPoints = ini_read_real("Meta", "Campaign Points", 0);
global.totalCampaignPoints = ini_read_real("Meta", "Total Campaign Points", 0);
var _honorRanking = ini_read_string("Honor Ranking", "String", "-1");

if (_honorRanking != "-1")
{
    ds_grid_read(global.honorRanking, _honorRanking);
    ds_grid_sort(global.honorRanking, 1, 0);
}

global.premiumChannel = 0;

if (global.channelName == "room_001")
    global.premiumChannel = 1;

if (global.townName == "Nameless Town")
{
    global.townName = string_delete(global.channelName, 6, 100) + "town";
    var str = global.townName;
    var out = string_upper(string_char_at(str, 1));
    out += string_copy(str, 2, string_length(str) - 1);
    global.townName = out;
    ini_write_string("Town", "Name", global.townName);
}

global.chatSpam = ini_read_real("Settings", "Chat Spam", 0);
global.canRaid = true;
gml_Script_twitch_chat_say_direct("/me room00Guard Greetings to all raiders! room00Raid (v" + string(global.patch) + ")");
ini_close();
ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.finalWarListName = gml_Script_scr_ds_list_create();
global.finalWarListClass = gml_Script_scr_ds_list_create();
global.totalAscensionLevel = ini_read_real("Stats", "Total Ascension Level", 0);
var listName = ini_read_string("Final War", "List Names", "");
var listClass = ini_read_string("Final War", "List Classes", "");

if (listName != "")
{
    ds_list_read(global.finalWarListName, listName);
    ds_list_read(global.finalWarListClass, listClass);
}

ini_close();

for (var i = 0; i < 4; i++)
{
    global.djinnInfo[i][0] = 0;
    global.djinnInfo[i][1] = "name:undefined";
    global.djinnInfo[i][2] = 5;
    global.djinnInfo[i][3] = "desc:undefined";
}

global.djinnInfo[0][1] = "Aqua";
global.djinnInfo[0][3] = "+*%[x] XP and resource gain.";
global.djinnInfo[0][4] = 16776960;
global.djinnInfo[0][5] = 16711680;
global.djinnInfo[1][1] = "Ignis";
global.djinnInfo[1][3] = "+*%[x] strength and intelligence.";
global.djinnInfo[1][4] = 4235519;
global.djinnInfo[1][5] = 128;
global.djinnInfo[2][1] = "Terra";
global.djinnInfo[2][3] = "+*%[x] armor and constitution.";
global.djinnInfo[2][4] = 65280;
global.djinnInfo[2][5] = 32896;
global.djinnInfo[3][1] = "Ventus";
global.djinnInfo[3][3] = "+*%[x] energy, stamina and speed.";
global.djinnInfo[3][4] = 12632256;
global.djinnInfo[3][5] = 8388736;
global.djinnOrder = [];
ini_open(string(global.platformDir) + "Village Data/Data.ini");
var _starter = ini_read_real("Djinns", "Initial Djinn", -1);

if (_starter == -1)
{
    var djinnPool = [0, 1, 2, 3];
    var tempValues = [];
    
    for (var i = 0; i < array_length(djinnPool); i++)
        tempValues[i] = djinnPool[i];
    
    while (array_length(tempValues) > 0)
    {
        var idx = irandom(array_length(tempValues) - 1);
        array_push(global.djinnOrder, tempValues[idx]);
        ini_write_real("Djinns", "Djinn " + string(array_length(global.djinnOrder) - 1) + " ID", tempValues[idx]);
        array_delete(tempValues, idx, 1);
    }
    
    global.djinnInfo[global.djinnOrder[3]][0] = 1;
    ini_write_real("Djinns", "Initial Djinn", global.djinnOrder[3]);
    ini_write_real("Djinns", "Djinn " + string(global.djinnOrder[3]) + " Free", 1);
    
    with (gml_Script_instance_create(x, y, obj_djinn))
    {
        type = global.djinnOrder[3];
        image_index = type;
    }
}
else
{
    for (var i = 0; i < 4; i++)
    {
        global.djinnOrder[i] = ini_read_real("Djinns", "Djinn " + string(i) + " ID", i);
        global.djinnInfo[global.djinnOrder[i]][0] = ini_read_real("Djinns", "Djinn " + string(global.djinnOrder[i]) + " Free", 0);
    }
    
    global.djinnInfo[global.djinnOrder[3]][0] = 1;
}

ini_close();

switch (current_weekday)
{
    case 0:
        global.currentDay = "Sunday";
        break;
    
    case 1:
        global.currentDay = "Monday";
        break;
    
    case 2:
        global.currentDay = "Tuesday";
        break;
    
    case 3:
        global.currentDay = "Wednesday";
        break;
    
    case 4:
        global.currentDay = "Thursday";
        break;
    
    case 5:
        global.currentDay = "Friday";
        break;
    
    case 6:
        global.currentDay = "Saturday";
        break;
}

global.dungeonQuotes[0] = "You feel gazes from the dark, don't you? - Unknown Mage";
global.dungeonQuotes[1] = "This floor is full of rats... Let's end this quick. - Unknown Rogue";
global.dungeonQuotes[2] = "Awful creatures await you down here... - ???";
global.dungeonQuotes[3] = "You will be lucky enough if you die fast. - ???";
global.dungeonQuotes[4] = "Oh shit, here we go again... - Sir Carl Johnson";
global.dungeonQuotes[5] = "I... I just want to go home... - Unknown Bandit";
global.dungeonQuotes[6] = "Huge treasures have been buried in these dungeons... - Unknown Warrior";
global.dungeonQuotes[7] = "The light will prevail even in the darkest dungeons! - Mia the White Mage";
global.dungeonQuotes[8] = "I can't even see the tip of my sword... this is not good. - Unknown Warrior";
global.dungeonQuotes[9] = "Woah! Did you hear that too? Where did it come from!? - Unknown Archer";
global.dungeonQuotes[10] = "Your mind is your biggest enemy... Don't let it fool you. - Unknown Wizard";
global.dungeonMaxQuotes = array_length_1d(global.dungeonQuotes) - 1;
global.startQuotes[0] = "A wise man is a strong man. - Unknown Battlemage";
global.startQuotes[1] = "So when is the gluttony farmer statue being built? - Killeredge13";
global.startQuotes[2] = "Patience is key. - ???";
global.startQuotes[3] = "You can not control those who trust in themselves. - ???";
global.startQuotes[4] = "This place seems familiar... - ???";
global.startQuotes[5] = "Is any of this worth it... ? - Erohz the Creator";
global.startQuotes[6] = "Hey, have you joined the !discord yet? - Unknown Farmer";
global.startQuotes[7] = "Portals can be dangerous... Do you really want to go there? - Unknown Elementalist";
global.startQuotes[8] = "Fight for what you believe, and it won't be a lost cause. - Unknown Warrior";
global.startQuotes[9] = "Danger? I only need a bow and an arrow. - Unknown Archer";
global.startQuotes[10] = "Blink and you will miss your own death. - Unknown Rogue";
global.startQuotes[11] = "Good towns have strong fighters and a wealthy economy - Sawode";
global.startQuotes[12] = "You take care of me, I'll take care of you, we are in this together. - Sim the Loyal";
global.startQuotes[13] = "Every day I wake up, is a day I can become stronger. - Unknown Warrior";
global.startQuotes[14] = "Missing? Haven't heard that name in years... - Unknown Archer";
global.startQuotes[15] = "Sometimes, a good defense is the best offense. - ByFd7";
global.startQuotes[16] = "The only thing that I feel when I pull the trigger is recoil. - Razzor1";
global.startQuotes[17] = "The legend says a powerful Wizard has filled this land with evil... - Unknown Farmer";
global.startQuotes[18] = "One more boss! One more boss! One more boss! - byFd7";
global.startQuotes[19] = "Farmers are the backbone of the town. - Hotsteve";
global.startMaxQuotes = array_length_1d(global.startQuotes) - 1;
gml_Script_instance_create(0, 0, obj_transition_in);
gml_Script_instance_create(0, 0, obj_god);
gml_Script_instance_create(0, 0, obj_raidMovement);
gml_Script_instance_create(0, 0, obj_tutorial);
show_debug_overlay(false);
global.relicList = gml_Script_scr_ds_list_create();
global.relicDrop = false;
global.lockedClass = true;
global.lockedClassType = "";
global.skillSpecialization[0][0] = "Berserker";
global.skillSpecialization[0][1] = "Paladin";
global.skillSpecialization[0][2] = "Knight";
global.skillSpecialization[1][0] = "Assassin";
global.skillSpecialization[1][1] = "Ninja";
global.skillSpecialization[1][2] = "Shadow";
global.skillSpecialization[2][0] = "Monk";
global.skillSpecialization[2][1] = "bird";
global.skillSpecialization[2][2] = "dog";
global.skillSpecialization[3][0] = "Ranger";
global.skillSpecialization[3][1] = "Crossbowman";
global.skillSpecialization[3][2] = "Arcane Archer";
global.skillSpecialization[4][0] = "Wizard";
global.skillSpecialization[4][1] = "Battlemage";
global.skillSpecialization[4][2] = "Elementalist";
global.maxAbilityLevel = 42;
global.maxSpecAbilityLevel = 15;
global.showRelic = 1;
alarm[0] = room_speed * 600;
alarm[1] = room_speed * 5;
global.playerName = global.userName;
global.totalPlayers = 0;
global.maxPlayers = 50;
global.quitNumber = 10;
global.language = 1;
global.raiding = false;
global.raidCost = 0;
global.bossStage = 0;
global.finalWar = false;
global.inFinalWar = false;
global.versus = "";
gml_Script_instance_create(x, y, obj_honor_shop);
gml_Script_instance_create(x, y, obj_raidPortal);
global.stageType = "Forest";
global.stageTypeWorld = global.stageType;
global.raidGold = 0;
global.raidXP = 0;
global.raidHonor = 0;
global.raidKills = 0;
global.raidTalents = 0;
global.raidGems = 0;
global.raiders = 0;
global.warriorBonus = 0;
global.warriorNumber = 0;
global.rogueBonus = 0;
global.rogueNumber = 0;
global.farmerBonus = 0;
global.farmerNumber = 0;
global.farmerResourceBonus = 0;
global.rangerBonus = 0;
global.rangerNumber = 0;
global.wizardBonus = 0;
global.wizardNumber = 0;
global.globalGoldBonus = 1;
global.globalXPBonus = 1;
global.globalFoodBonus = 1;
global.globalDamageBonus = 0;
global.globalResistanceBonus = 0;
global.auraRot = 0;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.food = ini_read_real("Stats", "Food", 250);
global.gold = ini_read_real("Stats", "Gold", 250);
global.gems = ini_read_real("Stats", "Gems", 0);
global.townHP = ini_read_real("Stats", "HP", 100);
global.townMaxHP = ini_read_real("Stats", "Max HP", 100);
global.maxGold = ini_read_real("Stats", "Max Gold", 2000);
global.maxFood = ini_read_real("Stats", "Max Food", 2000);
global.townLevel = ini_read_real("Stats", "Town Level", 1);
global.townMaxXP = ini_read_real("Stats", "Town Max XP", global.townLevel * 1000);
global.townXP = ini_read_real("Stats", "Town XP", 0);
global.underworldXP = ini_read_real("Underworld", "Underworld XP", 0);
global.underworldLevel = ini_read_real("Underworld", "Underworld Level", 1);
global.underworldMaxXP = ini_read_real("Underworld", "Underworld Max XP", global.underworldLevel * 5000);
global.tutorialStep = ini_read_real("Tutorial", "Step", 0);
displayGold = global.gold;
displayFood = global.food;
displayGems = global.gems;
displayTownHP = global.townHP;
displaySouls = 0;
displayBloodgems = 0;
global.hunterGuildLevel = 1;
global.minerGuildLevel = 1;
global.farmerGuildLevel = 1;
global.stage = ini_read_real("Stats", "Stage", 1);

if (global.stage <= 0)
    global.stage = 1;

if (global.stage >= 251)
{
    global.stageType = "Grassland";
    global.stageTypeWorld = global.stageType;
}

if (global.stage >= 501)
{
    global.stageType = "Snow Trail";
    global.stageTypeWorld = global.stageType;
}

global.recipeProgress = ini_read_real("Witch", "Recipe", 0);
global.recipeMax = ini_read_real("Witch", "Recipe Max", 5000);
global.maxPortalStage = ini_read_real("Underworld", "Stage", 0);
global.maxPortalTower = 5;
global.maxPortalFloor = 5;
global.portalStage = 1;
global.portalTower = 1;
global.portalFloor = 1;
global.underworldFog = gml_Script_scr_surface_create(1420, 800, "underworldFog");
global.souls = ini_read_real("Underworld", "Souls", 0);
global.bloodgems = ini_read_real("Underworld", "Blood Gems", 0);
ini_close();
global.blacksmithBuilt = 0;
global.shopBuilt = 0;
global.wellBuilt = 0;
global.academyBuilt = 0;
global.guildsBuilt = 0;
global.keeperBuilt = 0;
global.witchBuilt = 0;
global.academyXpBonus = 1;
global.wellGoldBonus = 0;
global.soulBonus = 1;
global.maxRelicCorruption = 1.5;

if (!instance_exists(obj_corruptedControl))
    gml_Script_instance_create(x, y, obj_corruptedControl);

if (!instance_exists(obj_portal))
    gml_Script_instance_create(x, y, obj_portal);

ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.unlockWitch = ini_read_real("Underworld", "Unlock Witch", 0);
global.gotWitch = false;
global.maxSouls = ini_read_real("Underworld", "Max Souls", 2000);
global.soulsProd = ini_read_real("Underworld", "Souls Production", 0);
global.bossSoulsBonuses = 0;
global.finisKills = ini_read_real("Underworld", "Finis Kills", 0);
global.bossSoulsTotal = 0;

for (ss = 0; ss < 7; ss += 1)
{
    global.bossSouls[ss] = ini_read_real("Underworld", "Boss Soul " + string(ss), 0);
    global.bossSoulsTotal += global.bossSouls[ss];
    
    if (global.bossSouls[ss] > 0)
        global.bossSoulsBonuses += 1;
}

if (global.finisKills > 0)
    global.bossSoulsBonuses += 3;

global.floorName[1][0] = "Lust";
global.floorName[1][1] = "Khuul' Itto";
global.floorName[2][0] = "Greed";
global.floorName[2][1] = "Ya-Vraah' Ni";
global.floorName[3][0] = "Sloth";
global.floorName[3][1] = "Naxxarus";
global.floorName[4][0] = "Envy";
global.floorName[4][1] = "Immoa'tutapal";
global.floorName[5][0] = "Gluttony";
global.floorName[5][1] = "Minnea-tuhl";
global.floorName[6][0] = "Pride";
global.floorName[6][1] = "Zaraatras";
global.floorName[7][0] = "Wrath";
global.floorName[7][1] = "Maahkoptum";
global.floorName[8][0] = "The End";
global.floorName[8][1] = "Finis Vitae";
global.underworldXPProd = ini_read_real("Underworld", "XP Production", 0);
global.underworldGoldProd = ini_read_real("Underworld", "Gold Production", 0);
global.underworldBonus = ini_read_real("Buildings", "Underworld Bonus", 1);
global.uniqueItem[0][0] = "none";
global.uniqueItem[0][1] = "none";
global.uniqueItem[0][2] = "none";
global.uniqueItem[0][3] = "none";
global.uniqueItem[1][0] = "Undying Faith";
global.uniqueItem[1][1] = "After receiving lethal damage, become invulnerable for a few seconds, then you recover 10% of your HP.";
global.uniqueItem[1][2] = 3;
global.uniqueItem[1][3] = "All Classes";
global.uniqueItem[1][4] = 1;
global.uniqueItem[1][5] = 0;
global.uniqueItem[1][6] = "s";
global.uniqueItem[1][7] = "After receiving lethal damage, become invulnerable for *, then recover 10% of your HP.";
global.uniqueItem[2][0] = "Divine Grace";
global.uniqueItem[2][1] = "Dealing damage will execute demons when they are low on HP.";
global.uniqueItem[2][2] = 0.15;
global.uniqueItem[2][3] = "All Classes";
global.uniqueItem[2][4] = 0.05;
global.uniqueItem[2][5] = 0;
global.uniqueItem[2][6] = "%";
global.uniqueItem[2][7] = "Dealing damage will execute demons when their HP reaches *.";
global.uniqueItem[3][0] = "Blood Transmuter";
global.uniqueItem[3][1] = "Convert 25% of the exceeding healing you get into a shield.";
global.uniqueItem[3][2] = 0.15;
global.uniqueItem[3][3] = "All Classes";
global.uniqueItem[3][4] = 0.05;
global.uniqueItem[3][5] = 0;
global.uniqueItem[3][6] = "%";
global.uniqueItem[3][7] = "Convert 25% of the exceeding healing you get into a shield, up to * of your constitution.";
global.uniqueItem[4][0] = "Combat Knowledge";
global.uniqueItem[4][1] = "Your ability cost increase and ability casting time get reduced.";
global.uniqueItem[4][2] = 0.2;
global.uniqueItem[4][3] = "All Classes";
global.uniqueItem[4][4] = 0.1;
global.uniqueItem[4][5] = 0;
global.uniqueItem[4][6] = "x";
global.uniqueItem[4][7] = "Your ability cost increase and ability casting time get divided by *.";
global.uniqueItem[5][0] = "Tree of Life";
global.uniqueItem[5][1] = "Increase your HP/s depending on how much HP you are missing.";
global.uniqueItem[5][2] = 0.5;
global.uniqueItem[5][3] = "All Classes";
global.uniqueItem[5][4] = 0.25;
global.uniqueItem[5][5] = 0;
global.uniqueItem[5][6] = "%";
global.uniqueItem[5][7] = "Increase your HP/s depending on how much HP you are missing (+* at 0% HP).";
global.uniqueItem[6][0] = "Warlord";
global.uniqueItem[6][1] = "Your special damage will benefit from part of your lifesteal.";
global.uniqueItem[6][2] = 0.15;
global.uniqueItem[6][3] = "All Classes";
global.uniqueItem[6][4] = 0.05;
global.uniqueItem[6][5] = 0;
global.uniqueItem[6][6] = "%";
global.uniqueItem[6][7] = "Your special damage will benefit from * of your lifesteal.";
global.uniqueItem[7][0] = "Executioner";
global.uniqueItem[7][1] = "Your critical strikes deal even more damage.";
global.uniqueItem[7][2] = 0.75;
global.uniqueItem[7][3] = "All Classes";
global.uniqueItem[7][4] = 0.75;
global.uniqueItem[7][5] = 0;
global.uniqueItem[7][6] = "x";
global.uniqueItem[7][7] = "Your critical strikes deal *[x] more damage.";
global.uniqueItem[8][0] = "Invisibility Cloak";
global.uniqueItem[8][1] = "You can dodge critical strikes, mitigate a higher amount of damage and reduce enemy fury/hit when dodging.";
global.uniqueItem[8][2] = 2;
global.uniqueItem[8][3] = "All Classes";
global.uniqueItem[8][4] = 1;
global.uniqueItem[8][5] = 0;
global.uniqueItem[8][6] = "x";
global.uniqueItem[8][7] = "You can dodge critical strikes, divide damage when dodging by * and reduce enemy fury/hit when dodging.";
global.uniqueItem[9][0] = "Kenji's Staff";
global.uniqueItem[9][1] = "When casting your ability, deal special damage based on your fury, strength and intelligence to nearby enemies.";
global.uniqueItem[9][2] = 1;
global.uniqueItem[9][3] = "All Classes";
global.uniqueItem[9][4] = 10;
global.uniqueItem[9][5] = 0;
global.uniqueItem[9][6] = "x";
global.uniqueItem[9][7] = "When casting your ability, deal * special damage to nearby enemies (scaling with your fury, strength and intelligence).";
global.uniqueItem[10][0] = "Claws of Sim";
global.uniqueItem[10][1] = "While in combat, enemy deaths increase your base strength for 6s [Sim's Gear Set]";
global.uniqueItem[10][2] = 0.005;
global.uniqueItem[10][3] = "All Classes";
global.uniqueItem[10][4] = 0.0025;
global.uniqueItem[10][5] = 0;
global.uniqueItem[10][6] = "%";
global.uniqueItem[10][7] = "While in combat, enemy deaths increase your base strength by * for 6s.";
global.uniqueItem[11][0] = "Shield of Sim";
global.uniqueItem[11][1] = "While in combat, enemy deaths increase your base constitution for 6s [Sim's Gear Set]";
global.uniqueItem[11][2] = 0.005;
global.uniqueItem[11][3] = "All Classes";
global.uniqueItem[11][4] = 0.0025;
global.uniqueItem[11][5] = 0;
global.uniqueItem[11][6] = "%";
global.uniqueItem[11][7] = "While in combat, enemy deaths increase your base constitution by * for 6s.";
global.uniqueItem[12][0] = "Box of Sim";
global.uniqueItem[12][1] = "While in combat, enemy deaths increase your base intelligence for 6s [Sim's Gear Set]";
global.uniqueItem[12][2] = 0.005;
global.uniqueItem[12][3] = "All Classes";
global.uniqueItem[12][4] = 0.0025;
global.uniqueItem[12][5] = 0;
global.uniqueItem[12][6] = "%";
global.uniqueItem[12][7] = "While in combat, enemy deaths increase your base intelligence by * for 6s";
global.uniqueItem[13][0] = "Guardian's Covenant";
global.uniqueItem[13][1] = "Redirect part of the damage your allies take, reducing the damage they receive and taking that value as true damage. Receive a regenerating shield when entering combat.";
global.uniqueItem[13][2] = 1.1;
global.uniqueItem[13][3] = "All Classes";
global.uniqueItem[13][4] = 0.05;
global.uniqueItem[13][5] = 0;
global.uniqueItem[13][6] = "x";
global.uniqueItem[13][7] = "Redirect part of the damage your allies take, dividing the damage they receive by * and taking that value as true damage. Receive * regenerative shield when entering combat.";
global.uniqueItem[14][0] = "Unstable Matter";
global.uniqueItem[14][1] = "Your special damage has a 50% chance of dealing increased damage.";
global.uniqueItem[14][2] = 0.5;
global.uniqueItem[14][3] = "All Classes";
global.uniqueItem[14][4] = 0.05;
global.uniqueItem[14][5] = 0;
global.uniqueItem[14][6] = "%";
global.uniqueItem[14][7] = "Your special damage has a 50% chance of dealing *[x] increased damage.";
global.uniqueItem[15][0] = "Snake Bite";
global.uniqueItem[15][1] = "Deal increased physical damage based on the target's poison stacks.";
global.uniqueItem[15][2] = 0.05;
global.uniqueItem[15][3] = "All Classes";
global.uniqueItem[15][4] = 0.01;
global.uniqueItem[15][5] = 0;
global.uniqueItem[15][6] = "%";
global.uniqueItem[15][7] = "Deal *[x] increased physical damage based on the target's poison stacks.";
global.uniqueItem[16][0] = "Specialist";
global.uniqueItem[16][1] = "Convert part of status damage dealt to special damage.";
global.uniqueItem[16][2] = 0.1;
global.uniqueItem[16][3] = "All Classes";
global.uniqueItem[16][4] = 0.05;
global.uniqueItem[16][5] = 0;
global.uniqueItem[16][6] = "%";
global.uniqueItem[16][7] = "Convert * of status damage dealt to special damage.";
global.uniqueItem[17][0] = "Shieldsword";
global.uniqueItem[17][1] = "Your damage deals additional true damage based on your current shield.";
global.uniqueItem[17][2] = 0.01;
global.uniqueItem[17][3] = "All Classes";
global.uniqueItem[17][4] = 0.0025;
global.uniqueItem[17][5] = 0;
global.uniqueItem[17][6] = "%";
global.uniqueItem[17][7] = "When dealing damage, deal an extra * of your current shield as true damage.";
global.uniqueItem[18][0] = "Holy Belt";
global.uniqueItem[18][1] = "Deal true damage over time to your attackers based on your HP regeneration.";
global.uniqueItem[18][2] = 0.05;
global.uniqueItem[18][3] = "All Classes";
global.uniqueItem[18][4] = 0.01;
global.uniqueItem[18][5] = 0;
global.uniqueItem[18][6] = "%";
global.uniqueItem[18][7] = "Deal * of your HP regeneration as true damage over time to your attackers";
global.uniqueItem[19][0] = "Mana Band";
global.uniqueItem[19][1] = "Your ability lasts longer and you generate a small shield over time while it's active.";
global.uniqueItem[19][2] = 0.1;
global.uniqueItem[19][3] = "All Classes";
global.uniqueItem[19][4] = 0.02;
global.uniqueItem[19][5] = 0;
global.uniqueItem[19][6] = "%";
global.uniqueItem[19][7] = "Your ability lasts * longer and you generate * shield per second while it's active.";
global.uniqueItem[20][0] = "Elementalist";
global.uniqueItem[20][1] = "Dealing damage has a chance of creating a Fire/Ice/Poison stack. Increase your status effect damage and duration.";
global.uniqueItem[20][2] = 0.01;
global.uniqueItem[20][3] = "All Classes";
global.uniqueItem[20][4] = 0.004;
global.uniqueItem[20][5] = 0;
global.uniqueItem[20][6] = "%";
global.uniqueItem[20][7] = "Dealing damage has a * chance of creating a Fire/Ice/Poison stack. Increase your status effect damage and duration by *.";
global.uniqueItem[21][0] = "Red Odd Stone";
global.uniqueItem[21][1] = "Physical damage reduces target’s physical resistance for 3s [Odd Stones Set].";
global.uniqueItem[21][2] = 0.005;
global.uniqueItem[21][3] = "All Classes";
global.uniqueItem[21][4] = 0.001;
global.uniqueItem[21][5] = 0;
global.uniqueItem[21][6] = "%";
global.uniqueItem[21][7] = "Physical damage reduces target’s physical resistance by *[+] for 3s.";
global.uniqueItem[22][0] = "Blue Odd Stone";
global.uniqueItem[22][1] = "Special damage reduces target’s special resistance for 3s [Odd Stones Set].";
global.uniqueItem[22][2] = 0.005;
global.uniqueItem[22][3] = "All Classes";
global.uniqueItem[22][4] = 0.001;
global.uniqueItem[22][5] = 0;
global.uniqueItem[22][6] = "%";
global.uniqueItem[22][7] = "Special damage reduces target’s special resistance by *[+] for 3s.";
global.uniqueItem[23][0] = "Yellow Odd Stone";
global.uniqueItem[23][1] = "Status damage reduces target’s status resistance for 3s [Odd Stones Set].";
global.uniqueItem[23][2] = 0.005;
global.uniqueItem[23][3] = "All Classes";
global.uniqueItem[23][4] = 0.001;
global.uniqueItem[23][5] = 0;
global.uniqueItem[23][6] = "%";
global.uniqueItem[23][7] = "Status damage reduces target’s status resistance by *[+] for 3s.";
global.uniqueItem[24][0] = "Dice of Time";
global.uniqueItem[24][1] = "Your damage over time (DoT) has a chance to critically strike (except true damage), dealing extra damage.";
global.uniqueItem[24][2] = 0.1;
global.uniqueItem[24][3] = "All Classes";
global.uniqueItem[24][4] = 0.005;
global.uniqueItem[24][5] = 0;
global.uniqueItem[24][6] = "%";
global.uniqueItem[24][7] = "Your damage over time (DoT) has * of your luck to critically strike (except true damage), dealing *[x] extra damage.";
global.uniqueItem[25][0] = "Explosive Touch";
global.uniqueItem[25][1] = "Killing enemies makes them explode, dealing physical damage around them scaling with their constitution.";
global.uniqueItem[25][2] = 0.1;
global.uniqueItem[25][3] = "All Classes";
global.uniqueItem[25][4] = 0.01;
global.uniqueItem[25][5] = 0;
global.uniqueItem[25][6] = "%";
global.uniqueItem[25][7] = "Killing enemies makes them explode, dealing * of their constitution as physical damage around them.";
global.uniqueItem[26][0] = "Sharper Blade";
global.uniqueItem[26][1] = "Critical strikes have a chance to apply bleeding.";
global.uniqueItem[26][2] = 0.1;
global.uniqueItem[26][3] = "All Classes";
global.uniqueItem[26][4] = 0.02;
global.uniqueItem[26][5] = 0;
global.uniqueItem[26][6] = "%";
global.uniqueItem[26][7] = "Critical strikes have a * chance to apply bleeding.";
global.uniqueItem[27][0] = "Mia's Wand";
global.uniqueItem[27][1] = "Buffs and debuffs you apply have stronger effects and longer durations.";
global.uniqueItem[27][2] = 0.1;
global.uniqueItem[27][3] = "All Classes";
global.uniqueItem[27][4] = 0.02;
global.uniqueItem[27][5] = 0;
global.uniqueItem[27][6] = "%";
global.uniqueItem[27][7] = "Buffs and debuffs you apply have * stronger effects and * longer durations (half the effect on self).";
global.uniqueItem[28][0] = "Wise Hat";
global.uniqueItem[28][1] = "Using an ability has a 20% chance to instantly re-cast a weaker version of it.";
global.uniqueItem[28][2] = 0.1;
global.uniqueItem[28][3] = "All Classes";
global.uniqueItem[28][4] = 0.01;
global.uniqueItem[28][5] = 0;
global.uniqueItem[28][6] = "%";
global.uniqueItem[28][7] = "Using an ability has a 20% chance to instantly re-cast another version of it at * effectiveness.";
global.uniqueItem[29][0] = "Armor Oxidizer";
global.uniqueItem[29][1] = "Dealing damage to an enemy reduces its armor.";
global.uniqueItem[29][2] = 0.00025;
global.uniqueItem[29][3] = "All Classes";
global.uniqueItem[29][4] = 0.0001;
global.uniqueItem[29][5] = 0;
global.uniqueItem[29][6] = "%";
global.uniqueItem[29][7] = "Dealing damage to an enemy reduces its armor by *.";
global.maxUniqueItems = array_length(global.uniqueItem) - 1;
global.specialItem[0][0] = "none";
global.specialItem[0][1] = "none";
global.specialItem[0][2] = 0;
global.specialItem[0][3] = "All Classes";
global.specialItem[1][0] = "Hellbringer";
global.specialItem[1][1] = "Damaging enemies has a *% chance of igniting them on fire.";
global.specialItem[1][2] = 20;
global.specialItem[1][3] = "Berserker";
global.specialItem[2][0] = "Adaptative Power";
global.specialItem[2][1] = "While your ability is active, gain *% adaptative power.";
global.specialItem[2][2] = 10;
global.specialItem[2][3] = "All Classes";
global.specialItem[3][0] = "Echoes of War";
global.specialItem[3][1] = "Whenever you deal damage, theres a *% chance it gets dealt again at 50% of its value.";
global.specialItem[3][2] = 10;
global.specialItem[3][3] = "All Classes";
global.specialItem[4][0] = "Tortoise Shell";
global.specialItem[4][1] = "Completely ignore received damage if it is bellow *.";
global.specialItem[4][2] = 5000;
global.specialItem[4][3] = "All Classes";
global.specialItem[5][0] = "Double Tap";
global.specialItem[5][1] = "Your basic attacks have a *% chance of triggering twice when you attack.";
global.specialItem[5][2] = 5;
global.specialItem[5][3] = "All Classes";
global.maxSpecialItems = array_length(global.specialItem) - 1;
ini_close();

if (!instance_exists(obj_milestoneControl))
    gml_Script_instance_create(x, y, obj_milestoneControl);

if (!instance_exists(obj_diaryQuests))
    gml_Script_instance_create(x, y, obj_diaryQuests);

global.talentValue[0] = 4;
global.talentValue[1] = 150;
global.talentValue[2] = 20;
global.talentValue[3] = 80;
global.talentValue[4] = 100;
global.talentValue[5] = 50;
global.talentValue[6] = 2;
global.talentValue[7] = 20;
global.talentValue[8] = 0.4;
global.talentValue[9] = 3;

if (global.stage > 10)
    global.raidCost = 0;
else
    global.raidCost = 0;

global.xpGoto[0] = -2;
global.xpGoto[1] = -2;
global.rewardList = gml_Script_scr_ds_list_create();
global.playerList = gml_Script_scr_ds_list_create();
global.readyList = gml_Script_scr_ds_list_create();
global.list_afk = gml_Script_scr_ds_list_create();
global.list_notafk = gml_Script_scr_ds_list_create();
global.islandVoting = gml_Script_scr_ds_list_create();
global.corruptedCardVoting = gml_Script_scr_ds_list_create();
global.cardTurn = 1;
global.cardTurnNext = 2;
global.cardX = 0;
global.cardXpos = room_width - 500;
global.rolling = false;
alarm[5] = room_speed * 20;
alarm[6] = room_speed;
customDisplayTab[0] = "Town Stats";
customDisplayTab[1] = "Town Milestones (1/2)";
customDisplayTab[2] = "Town Milestones (2/2)";
customDisplayTab[3] = "Honor Shop (1/5)";
customDisplayTab[4] = "Honor Shop (2/5)";
customDisplayTab[5] = "Honor Shop (3/5)";
customDisplayTab[6] = "Honor Shop (4/5)";
customDisplayTab[7] = "Honor Shop (5/5)";

if (global.unlockCorrupted == true)
    customDisplayTab[8] = "Corruption Shards";

customTabs = array_length(customDisplayTab) - 1;
gml_Script_instance_create(x, y, obj_questControl);
global.globalItemInfo[0][0] = "Weapon";
global.globalItemInfo[0][1] = "strength";
global.globalItemInfo[1][0] = "Gloves";
global.globalItemInfo[1][1] = "dexterity";
global.globalItemInfo[2][0] = "Boots";
global.globalItemInfo[2][1] = "agility";
global.globalItemInfo[3][0] = "Helmet";
global.globalItemInfo[3][1] = "armor";
global.globalItemInfo[4][0] = "Ring";
global.globalItemInfo[4][1] = "fury";
global.globalItemInfo[5][0] = "Amulet";
global.globalItemInfo[5][1] = "lifesteal";
global.globalItemInfo[6][0] = "Belt";
global.globalItemInfo[6][1] = "hp regen";
global.globalItemInfo[7][0] = "Pants";
global.globalItemInfo[7][1] = "luck";
global.globalItemInfo[8][0] = "Vest";
global.globalItemInfo[8][1] = "constitution";
global.globalItemInfo[9][0] = "Spellbook";
global.globalItemInfo[9][1] = "intelligence";
global.baseStatText[0] = global.globalItemInfo[0][1];
global.baseStatText[1] = global.globalItemInfo[1][1];
global.baseStatText[2] = global.globalItemInfo[2][1];
global.baseStatText[3] = global.globalItemInfo[3][1];
global.baseStatText[4] = global.globalItemInfo[4][1];
global.baseStatText[5] = global.globalItemInfo[5][1];
global.baseStatText[6] = global.globalItemInfo[6][1];
global.baseStatText[7] = global.globalItemInfo[7][1];
global.baseStatText[8] = global.globalItemInfo[8][1];
global.baseStatText[9] = global.globalItemInfo[9][1];
global.enemyAbilityInfo = [[0, "Fury", gml_Script_scr_enemy_ult1, spr_warriorUlt1, 0.5], [1, "Bite", gml_Script_scr_enemy_ult2, spr_warriorUlt2, 0.3], [2, "Vampirism", gml_Script_scr_enemy_ult3, spr_warriorUlt3, 1], [3, "Stomp", gml_Script_scr_enemy_ult4, spr_warriorUlt3, 0.4], [4, "Death Beam", gml_Script_scr_enemy_ult5, spr_warriorUlt3, 3], [5, "Undead Portal", gml_Script_scr_enemy_ult6, spr_warriorUlt3, 1.5], [6, "Perforation", gml_Script_scr_enemy_ult7, spr_warriorUlt3, 1.5], [7, "Acid", gml_Script_scr_enemy_ult8, spr_warriorUlt3, 1.5], [8, "Sharp Skin", gml_Script_scr_enemy_ult9, spr_warriorUlt3, 1.5]];
global.enemyAbilityMax = array_length(global.enemyAbilityInfo) - 1;
show_debug_message("Total enemy abilities: " + string(global.enemyAbilityMax));
global.playerAbilityInfo = [[[0, "Slash", gml_Script_scr_warrior_skill1, spr_warriorUlt1, 0.5], [1, "Fortify", gml_Script_scr_warrior_skill2, spr_warriorUlt2, 1], [2, "Barbed Shield", gml_Script_scr_warrior_skill3, spr_warriorUlt3, 2]], [[0, "Deep Cut", gml_Script_scr_rogue_skill1, spr_rogueUlt1, 0.3], [1, "Dagger Burst", gml_Script_scr_rogue_skill2, spr_rogueUlt2, 0.75], [2, "Smoke Bomb", gml_Script_scr_rogue_skill3, spr_rogueUlt3, 1.5]], [[0, "Inner Strength", gml_Script_scr_farmer_skill1, spr_farmerUlt1, 1.5], [1, "Gluttony", gml_Script_scr_farmer_skill2, spr_farmerUlt2, 0.5], [2, "Fatigue", gml_Script_scr_farmer_skill3, spr_farmerUlt3, 0.2]], [[0, "Precision", gml_Script_scr_ranger_skill1, spr_rangerUlt1, 1], [1, "Piercing Arrows", gml_Script_scr_ranger_skill2, spr_rangerUlt2, 1.2], [2, "Fire Arrow", gml_Script_scr_ranger_skill3, spr_rangerUlt3, 0.75]], [[0, "Thunder Strike", gml_Script_scr_wizard_skill1, spr_wizardUlt1, 2.5], [1, "Fire Shield", gml_Script_scr_wizard_skill2, spr_wizardUlt2, 1.5], [2, "Blizzard", gml_Script_scr_wizard_skill3, spr_wizardUlt3, 0.7]]];
global.playerSpecAbilityInfo = [[[[0, "Whirlwind", gml_Script_scr_warrior_skill1_spec1, spr_warrior1_Ult1, 0.5], [1, "Battlecry", gml_Script_scr_warrior_skill1_spec2, spr_warrior1_Ult2, 1], [2, "Guillotine", gml_Script_scr_warrior_skill1_spec3, spr_warrior1_Ult3, 0.3]], [[0, "Shield Master", gml_Script_scr_warrior_skill2_spec1, spr_warrior2_Ult1, 1], [1, "Holy Rain", gml_Script_scr_warrior_skill2_spec2, spr_warrior2_Ult2, 3], [2, "Blessing", gml_Script_scr_warrior_skill2_spec3, spr_warrior2_Ult3, 2]], [[0, "Focus", gml_Script_scr_warrior_skill3_spec1, spr_warrior3_Ult1, 0.5], [1, "Strike Wave", gml_Script_scr_warrior_skill3_spec2, spr_warrior3_Ult2, 1], [2, "Shield Charge", gml_Script_scr_warrior_skill3_spec3, spr_warrior3_Ult3, 0.2]]], [[[0, "Shadow Strike", gml_Script_scr_rogue_skill1_spec1, spr_rogueUlt1, 0.2], [1, "Shuriken storm", gml_Script_scr_rogue_skill1_spec2, spr_rogueUlt2, 0.7], [2, "Deadly Seal", gml_Script_scr_rogue_skill1_spec3, spr_rogueUlt3, 1.5]], [[0, "Deep Cut", gml_Script_scr_rogue_skill1, spr_rogueUlt1, 0.2], [1, "Dagger Burst", gml_Script_scr_rogue_skill2, spr_rogueUlt2, 0.7], [2, "Smoke Bomb", gml_Script_scr_rogue_skill3, spr_rogueUlt3, 1.5]], [[0, "Deep Cut", gml_Script_scr_rogue_skill1, spr_rogueUlt1, 0.2], [1, "Dagger Burst", gml_Script_scr_rogue_skill2, spr_rogueUlt2, 0.7], [2, "Smoke Bomb", gml_Script_scr_rogue_skill3, spr_rogueUlt3, 1.5]]], [[[0, "Inner Strength", gml_Script_scr_farmer_skill1, spr_farmerUlt1, 1], [1, "Gluttony", gml_Script_scr_farmer_skill2, spr_farmerUlt2, 0.7], [2, "Fatigue", gml_Script_scr_farmer_skill3, spr_farmerUlt3, 0.4]], [[0, "Inner Strength", gml_Script_scr_farmer_skill1, spr_farmerUlt1, 1], [1, "Gluttony", gml_Script_scr_farmer_skill2, spr_farmerUlt2, 0.7], [2, "Fatigue", gml_Script_scr_farmer_skill3, spr_farmerUlt3, 0.4]], [[0, "Inner Strength", gml_Script_scr_farmer_skill1, spr_farmerUlt1, 1], [1, "Gluttony", gml_Script_scr_farmer_skill2, spr_farmerUlt2, 0.7], [2, "Fatigue", gml_Script_scr_farmer_skill3, spr_farmerUlt3, 0.4]]], [[[0, "Perfect Aim", gml_Script_scr_ranger_skill1_spec1, spr_warrior3_Ult1, 1.5], [1, "Multishot", gml_Script_scr_ranger_skill1_spec2, spr_warrior3_Ult2, 2], [2, "Rain of Arrows", gml_Script_scr_ranger_skill1_spec3, spr_warrior3_Ult3, 3]], [[0, "Heavy Bolts", gml_Script_scr_ranger_skill2_spec1, spr_warrior3_Ult1, 1.5], [1, "Bear Trap", gml_Script_scr_ranger_skill2_spec2, spr_warrior3_Ult2, 1], [2, "BFB", gml_Script_scr_ranger_skill2_spec3, spr_warrior3_Ult3, 4]], [[0, "Explosive Arrow", gml_Script_scr_ranger_skill3_spec1, spr_warrior3_Ult1, 1], [1, "Lightning Arrow", gml_Script_scr_ranger_skill3_spec2, spr_warrior3_Ult2, 1], [2, "Poison Arrow", gml_Script_scr_ranger_skill3_spec3, spr_warrior3_Ult3, 1]]], [[[0, "Plasma Storm", gml_Script_scr_wizard_skill1_spec1, spr_warrior2_Ult1, 1.5], [1, "Arcane Missiles", gml_Script_scr_wizard_skill1_spec2, spr_warrior1_Ult2, 1], [2, "Death Beam", gml_Script_scr_wizard_skill1_spec3, spr_warrior1_Ult3, 1]], [[0, "Fire Aura", gml_Script_scr_wizard_skill2_spec1, spr_warrior2_Ult1, 2], [1, "Magic Dome", gml_Script_scr_wizard_skill2_spec2, spr_warrior2_Ult2, 1], [2, "Enchanted Blade", gml_Script_scr_wizard_skill2_spec3, spr_warrior2_Ult3, 1]], [[0, "Permafrost", gml_Script_scr_wizard_skill3_spec1, spr_warrior3_Ult1, 0.5], [1, "Meteoro", gml_Script_scr_wizard_skill3_spec2, spr_warrior3_Ult2, 1], [2, "Tornado", gml_Script_scr_wizard_skill3_spec3, spr_warrior3_Ult3, 0.2]]]];
global.globalSpecialBranches = 5;
global.globalSpecialInfo = [[[[[0, "Spinning speed", 1, 6, " spins/s"], [1, "Distance traveled", 1, 6, " meters"], [2, "Stun chance", 0.05, 6, "%"], [3, "Pulling", 3, 6, " pulling force"], [4, "Damage scaling", 0.1, 6, "%"]], [[0, "Strength on hit", 0.01, 6, "%"], [1, "Armor on hit", 0.01, 6, "%"], [2, "Lifesteal on hit", 0.01, 6, "%"], [3, "Heal on kill", 0.02, 6, "%"], [4, "Strength increase", 0.05, 6, "%"]], [[0, "Heal on hit", 0.05, 6, "%"], [1, "AoE damage", 1, 6, " meters"], [2, "Permanent strength on kill", 0.05, 6, "%"], [3, "Bleed chance", 0.1, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]]], [[[0, "Dexterity gain", 1, 6, " dexterity"], [1, "Permanent ally armor increase", 0.05, 6, "%"], [2, "Permanent ally constitution increase", 0.02, 6, "%"], [3, "Global damage resistance ", 0.05, 6, "%"], [4, "Shield scaling", 0.1, 6, "%"]], [[0, "Swords amount", 2, 6, " swords"], [1, "Swords duration", 1, 6, "s"], [2, "Burn stacks", 2, 6, " burn stacks"], [3, "Heal on hit", 0.02, 6, "%"], [4, "Damage scaling", 0.2, 6, "%"]], [[0, "Random damage resistance", 0.2, 6, "%"], [1, "Movement speed", 1, 6, " movement speed"], [2, "Dodge chance", 5, 6, " agility"], [3, "Damage output", 0.1, 6, "%"], [4, "HP/s scaling", 0.2, 6, "%"]]], [[[0, "Orb capacity", 0.1, 6, "%"], [1, "Extra targets", 1, 6, " targets"], [2, "Armor for the duration", 0.05, 6, "%"], [3, "HP Regen", 0.2, 6, "%"], [4, "Damage scaling", 0.1, 6, "%"]], [[0, "Total Strikes", 1, 6, " strikes"], [1, "Wave distance", 0.5, 6, " meters"], [2, "Striking speed", 0.05, 6, " striking speed"], [3, "Knockup", 0.5, 6, " knockup force"], [4, "Damage scaling", 0.2, 6, "%"]], [[0, "Intelligence while charging", 0.01, 6, "%"], [1, "Intelligence on kill", 0.01, 6, "%"], [2, "Shield generation", 0.02, 6, "%"], [3, "Extra duration on kill", 0.5, 6, "s"], [4, "Damage scaling", 0.2, 6, "%"]]]], [[[[0, "Spinning speed", 0.5, 6, "%"], [1, "Distance traveled", 0.7, 6, "%"], [2, "Stun chance", 0.7, 6, "%"], [3, "Pulling", 0.6, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Strength on hit", 0.01, 6, "%"], [1, "Armor on hit", 0.01, 6, "%"], [2, "Lifesteal on hit", 0.01, 6, "%"], [3, "Heal on kill", 0.02, 6, "%"], [4, "Strength increase", 0.05, 6, "%"]], [[0, "Heal on hit", 0.05, 6, "%"], [1, "AoE damage", 0.07, 6, "%"], [2, "Permanent strength on kill", 0.05, 6, "%"], [3, "Bleed chance", 2, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]]], [[[0, "Dexterity loss", 0.05, 6, "%"], [1, "Permanent ally armor increase", 0.01, 6, "%"], [2, "Permanent ally constitution increase", 0.002, 6, "%"], [3, "Higher damage resistance ", 0.02, 6, "%"], [4, "Shield scaling", 0.02, 6, "%"]], [[0, "Swords amount", 0.5, 6, "%"], [1, "Swords duration", 0.6, 6, "%"], [2, "Burn stacks", 1, 6, "%"], [3, "Heal on hit", 0.02, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Random damage resistance", 0.05, 6, "%"], [1, "Movement speed", 0.2, 6, "%"], [2, "Dodge chance", 0.03, 6, "%"], [3, "Damage output", 0.03, 6, "%"], [4, "HP/s scaling", 0.05, 6, "%"]]], [[[0, "Orb capacity", 0.1, 6, "%"], [1, "Extra targets", 0.5, 6, "%"], [2, "Armor for the duration", 0.05, 6, "%"], [3, "Freeze chance", 5, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Push on hit", 1, 6, "%"], [1, "Wave distance", 0.005, 6, "%"], [2, "Swing speed", 0.04, 6, "%"], [3, "Zap chance", 5, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Intelligence while charging", 0.002, 6, "%"], [1, "Intelligence on kill", 0.02, 6, "%"], [2, "Shield generation", 0.005, 6, "%"], [3, "Extra duration on kill", 0.07, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]]]], [[[[0, "Spinning speed", 0.5, 6, "%"], [1, "Distance traveled", 0.7, 6, "%"], [2, "Stun chance", 0.7, 6, "%"], [3, "Pulling", 0.6, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Strength on hit", 0.01, 6, "%"], [1, "Armor on hit", 0.01, 6, "%"], [2, "Lifesteal on hit", 0.01, 6, "%"], [3, "Heal on kill", 0.02, 6, "%"], [4, "Strength increase", 0.05, 6, "%"]], [[0, "Heal on hit", 0.05, 6, "%"], [1, "AoE damage", 0.07, 6, "%"], [2, "Permanent strength on kill", 0.05, 6, "%"], [3, "Bleed chance", 2, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]]], [[[0, "Dexterity loss", 0.05, 6, "%"], [1, "Permanent ally armor increase", 0.01, 6, "%"], [2, "Permanent ally constitution increase", 0.002, 6, "%"], [3, "Higher damage resistance ", 0.02, 6, "%"], [4, "Shield scaling", 0.02, 6, "%"]], [[0, "Swords amount", 0.5, 6, "%"], [1, "Swords duration", 0.6, 6, "%"], [2, "Burn stacks", 1, 6, "%"], [3, "Heal on hit", 0.02, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Random damage resistance", 0.05, 6, "%"], [1, "Movement speed", 0.2, 6, "%"], [2, "Dodge chance", 0.03, 6, "%"], [3, "Damage output", 0.03, 6, "%"], [4, "HP/s scaling", 0.05, 6, "%"]]], [[[0, "Orb capacity", 0.1, 6, "%"], [1, "Extra targets", 0.5, 6, "%"], [2, "Armor for the duration", 0.05, 6, "%"], [3, "Freeze chance", 5, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Push on hit", 1, 6, "%"], [1, "Wave distance", 0.005, 6, "%"], [2, "Swing speed", 0.04, 6, "%"], [3, "Zap chance", 5, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Intelligence while charging", 0.002, 6, "%"], [1, "Intelligence on kill", 0.02, 6, "%"], [2, "Shield generation", 0.005, 6, "%"], [3, "Extra duration on kill", 0.07, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]]]], [[[[0, "Bleed chance", 0.005, 6, "%"], [1, "Dexterity", 1, 6, " dexterity"], [2, "Range", 2, 6, " meters"], [3, "Pierce chance", 0.02, 6, "%"], [4, "Critical damage", 0.05, 6, "%"]], [[0, "Freeze chance", 0.02, 6, "%"], [1, "Burn chance", 0.02, 6, "%"], [2, "Poison chance", 0.02, 6, "%"], [3, "Armor reduction", 0.5, 6, " per arrow"], [4, "Arrows amount", 1, 6, " arrows"]], [[0, "Increase AoE", 0.15, 6, "%"], [1, "Increase duration", 0.5, 6, "s"], [2, "Burn chance", 0.05, 6, "%"], [3, "Armor reduction", 0.2, 6, " per tick"], [4, "Arrow density", 0.05, 6, "%"]]], [[[0, "Range", 1, 6, " meters"], [1, "Knockback", 0.05, 6, "%"], [2, "Global resistance reduction", 0.0005, 6, "%"], [3, "Shield generation", 0.02, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Global resistance reduction", 0.05, 6, "%"], [1, "Physical resistance reduction", 0.1, 6, "%"], [2, "Special resistance reduction", 0.1, 6, "%"], [3, "Effect duration", 0.5, 6, "s"], [4, "Boost all stats on activation", 0.02, 6, "%"]], [[0, "Debuff duration", 0.25, 6, "s"], [1, "Temporary shield on cast", 0.01, 6, "%"], [2, "Global resistance reduction", 0.05, 6, "%"], [3, "Armor reduction", 0.01, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]]], [[[0, "Interrupt chance", 0.1, 6, "%"], [1, "More burn stacks", 1, 6, " stacks"], [2, "Explosion range", 0.1, 6, "%"], [3, "More ammo", 1, 6, " arrows"], [4, "Damage scaling", 0.02, 6, "%"]], [[0, "Extra bounces", 1, 6, " bounces"], [1, "Longer range", 1, 6, " meters"], [2, "Faster chain reaction", 0.1, 6, "%"], [3, "More ammo", 1, 6, " arrows"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Infection range", 0.1, 6, "%"], [1, "More poison stacks", 2, 6, " stacks"], [2, "Infection chance", 0.1, 6, "%"], [3, "More ammo", 1, 6, " arrows"], [4, "Damage scaling", 0.05, 6, "%"]]]], [[[[0, "Beam frequency", 0.025, 6, "%"], [1, "Beam duration", 1, 6, "s"], [2, "Bounce range", 0.05, 6, " range"], [3, "Zap chance", 0.05, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Missiles amount", 1, 6, " missile"], [1, "Firing speed", 0.3, 6, " speed"], [2, "Shield on hit", 0.002, 6, "%"], [3, "Interrupt chance", 0.01, 6, "%"], [4, "Damage increase", 0.05, 6, "%"]], [[0, "Beam duration", 0.75, 6, "s"], [1, "Slow", 0.05, 6, "%"], [2, "Healing", 0.0005, 6, "%"], [3, "Range", 7, 6, " range"], [4, "Damage scaling", 0.05, 6, "%"]]], [[[0, "Burn chance", 0.1, 6, "%"], [1, "Shield on cast", 0.02, 6, "%"], [2, "Armor generation", 0.002, 6, "%"], [3, "HP regen scaling", 0.02, 6, "%"], [4, "Strength buff cap", 0.02, 6, "%"]], [[0, "Stun chance on deflect", 0.2, 6, "%"], [1, "Regen Dome HP", 0.05, 6, "%"], [2, "Heal deflected damage", 0.05, 6, "%"], [3, "Special damage output", 0.02, 6, "%"], [4, "Dome HP scaling", 0.02, 6, "%"]], [[0, "Extra luck", 0.02, 6, "%"], [1, "Extra range", 7, 6, " range"], [2, "Shield on cast", 0.01, 6, "%"], [3, "Intelligence buff cap", 0.05, 6, "%"], [4, "Special damage ratio", 0.05, 6, "%"]]], [[[0, "Freeze stacks", 0.3, 6, "%"], [1, "Search enemies", 0.4, 6, " speed"], [2, "Explosion range", 0.05, 6, "%"], [3, "Freeze duration", 0.01, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Amount of meteors", 1, 6, " meteors"], [1, "Trail expansion", 0.1, 6, "%"], [2, "Trail slow", 0.07, 6, "%"], [3, "Trail duration", 0.04, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]], [[0, "Tornado speed", 0.1, 6, " speed"], [1, "Pulling", 0.3, 6, " pulling force"], [2, "Ally buff", 0.05, 6, "%"], [3, "Enemy debuff", 0.05, 6, "%"], [4, "Damage scaling", 0.05, 6, "%"]]]]];
gml_Script_scr_initSkillDescriptions();
global.globalPetInfo = [[0, "None", gml_Script_scr_pet_skill1, "None", spr_warriorUlt1], [1, "Turtle", gml_Script_scr_pet_skill1, "Shell", spr_rogueUlt1], [2, "Owl", gml_Script_scr_pet_skill2, "Cleanse", spr_farmerUlt1], [3, "Wolf", gml_Script_scr_pet_skill3, "Finisher", spr_rangerUlt1], [4, "Snake", gml_Script_scr_pet_skill1, "Poison", spr_wizardUlt1]];
global.maxPets = array_length(global.globalPetInfo) - 1;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.mineBonusValue = 1;
global.farmBonusValue = 1;

if (ini_read_real("Buildings", "Witch Build", 0) == 1)
{
    with (gml_Script_instance_create(obj_witchHut.x, obj_witchHut.y, obj_buildingTimer))
    {
        build = obj_build_witchhut;
        timer = 1;
        alarm[0] = room_speed * timer;
    }
    
    global.witchBuilt = 1;
    
    with (obj_witchHut)
        instance_destroy();
}

if (ini_read_real("Buildings", "Guild Hall", 0) == 1)
{
    with (gml_Script_instance_create(obj_guilds.x, obj_guilds.y, obj_buildingTimer))
    {
        build = obj_build_guildhall;
        timer = 1;
        alarm[0] = room_speed * timer;
    }
    
    global.guildsBuilt = 1;
    
    with (obj_guilds)
        instance_destroy();
}

global.keyMap = gml_Script_scr_ds_map_create();
lastChestValue = ini_read_real("Guilds", "Last Chest Value", 0);
global.rewardChestProgress = ini_read_real("Guilds", "Chest Progress", 0);
global.chestReward[1][1] = ini_read_real("Buildings", "Chest 1 Gold", 25000);
global.chestReward[1][2] = ini_read_real("Buildings", "Chest 1 Gems", 3);
global.chestReward[2][1] = ini_read_real("Buildings", "Chest 2 XP", 25000);
global.chestReward[2][2] = ini_read_real("Buildings", "Chest 2 TP", 15);
global.chestReward[3][1] = ini_read_real("Buildings", "Chest 3 Relic 1 Type", 1);
global.chestReward[3][3] = ini_read_real("Buildings", "Chest 3 Relics 1", 1);
global.chestReward[3][2] = ini_read_real("Buildings", "Chest 3 Relic 2 Type", 1);
global.chestReward[3][4] = ini_read_real("Buildings", "Chest 3 Relics 2", 1);
var keyList = ini_read_string("Buildings", "Key List", "");

if (keyList != "")
    ds_map_read(global.keyMap, keyList);

chestTimer = room_speed;
chestDuration = room_speed * 86400;
global.chestID[1] = ini_read_real("Guilds", "Chest 1 ID", 1);
global.chestID[2] = ini_read_real("Guilds", "Chest 2 ID", 1);
global.chestID[3] = ini_read_real("Guilds", "Chest 3 ID", 1);
global.maxChestUses = 0;
global.globalRewardID = ini_read_real("Guilds", "Chest Reward ID", 1);

if (global.guildsBuilt == 1)
{
    alarm[4] = ini_read_real("Guilds", "Chest Timer", chestTimer);
    
    if (alarm[4] > room_speed)
        alarm[4] = room_speed;
    
    alarm[3] = ini_read_real("Guilds", "Chest Duration", -1);
}

global.globalShopID = ini_read_real("Buildings", "Shop ID", 1);
global.globalForgeID = ini_read_real("Buildings", "Forge ID", 1);
global.globalReforgeID = ini_read_real("Buildings", "Reforge ID", 1);

if (ini_read_real("Buildings", "Academy", 0) == 1)
{
    with (gml_Script_instance_create(obj_academy.x, obj_academy.y, obj_buildingTimer))
    {
        build = obj_build_academy;
        timer = 1;
        alarm[0] = room_speed * timer;
    }
    
    global.academyBuilt = 1;
    
    with (obj_academy)
        instance_destroy();
}

if (ini_read_real("Buildings", "Creature Keeper", 0) == 1)
{
    with (gml_Script_instance_create(obj_creatureKeeper.x, obj_creatureKeeper.y, obj_buildingTimer))
    {
        build = obj_build_creaturekeeper;
        timer = 1;
        alarm[0] = room_speed * timer;
    }
    
    global.keeperBuilt = 1;
    
    with (obj_creatureKeeper)
        instance_destroy();
}

if (ini_read_real("Buildings", "Shop", 0) == 1)
{
    with (gml_Script_instance_create(obj_shop.x, obj_shop.y, obj_buildingTimer))
    {
        build = obj_build_shop;
        timer = 1;
        alarm[0] = room_speed * timer;
    }
    
    global.shopBuilt = 1;
    
    with (obj_shop)
        instance_destroy();
}

if (ini_read_real("Buildings", "Forge", 0) == 1)
{
    with (gml_Script_instance_create(obj_blacksmith.x, obj_blacksmith.y, obj_buildingTimer))
    {
        build = obj_build_forge;
        timer = 1;
        alarm[0] = room_speed * timer;
    }
    
    global.blacksmithBuilt = 1;
    
    with (obj_blacksmith)
        instance_destroy();
}

if (ini_read_real("Buildings", "Well", 0) == 1)
{
    with (gml_Script_instance_create(obj_well.x, obj_well.y, obj_buildingTimer))
    {
        build = obj_build_well;
        timer = 1;
        alarm[0] = room_speed * timer;
    }
    
    global.wellBuilt = 1;
    
    with (obj_well)
        instance_destroy();
}

global.maxTrain = ini_read_real("Buildings", "Max Train", 4);
global.maxFarm = ini_read_real("Buildings", "Max Farm", 4);
global.maxMine = ini_read_real("Buildings", "Max Mine", 4);
global.totalAuras = 5;
global.auraInfo[0][0] = "Aura Power";
global.auraInfo[1][0] = "Aura of Vitality";
global.auraInfo[2][0] = "Aura of Wisdom";
global.auraInfo[3][0] = "Aura of Braveness";
global.auraInfo[4][0] = "Aura of Abundance";
global.auraInfo[5][0] = "Aura of Intellect";
global.auraInfo[0][1] = "Increases all your Auras.";
global.auraInfo[1][1] = "Increase your Constitution, HP regeneration and healing from all sources.";
global.auraInfo[2][1] = "Increase your XP earned from all sources.";
global.auraInfo[3][1] = "Increase your Strength and Luck.";
global.auraInfo[4][1] = "Increase the food and gold earned from all sources.";
global.auraInfo[5][1] = "Increase your Intelligence and Fury gain.";
ini_close();
ini_open(string(global.platformDir) + "Campaign Data/Credits.ini");
global.creditsGold = ini_read_real("Global", "Gold", 0);
global.creditsFood = ini_read_real("Global", "Food", 0);
global.creditsXP = ini_read_real("Global", "XP", 0);
global.creditsKills = ini_read_real("Global", "Kills", 0);
global.creditsDeaths = ini_read_real("Global", "Deaths", 0);
global.creditsHonor = ini_read_real("Global", "Honor", 0);
global.totalBunnies = ini_read_real("Global", "Total Bunnies", 0);
global.creditsBunnies = ini_read_real("Global", "Bunnies", 0);
ini_close();
global.actionText[0] = "nothing";
global.actionText[1] = "mining";
global.actionText[2] = "farming";
global.actionText[3] = "guarding";
global.actionText[4] = "raiding";
global.actionText[5] = "training";
global.actionText[6] = "resting";
ini_open(string(global.platformDir) + "Core Data/Active Players.ini");
savedMaxPlayers = ini_read_real("Saved Players", "Last Save", -1);

if (savedMaxPlayers >= 0)
{
    for (var sp = 0; sp <= savedMaxPlayers; sp += 1)
    {
        _playerName[sp] = ini_read_string(string(sp), "Name", "");
        _playerClass[sp] = ini_read_string(string(sp), "Class", "");
    }
}

ini_close();
alarm[2] = room_speed;
