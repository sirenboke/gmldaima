global.totalDiaryQuests = 60;

for (var i = 0; i < global.totalDiaryQuests; i += 1)
{
    global.diaryQuestInfo[i][0] = 0;
    global.diaryQuestInfo[i][1] = 0;
    global.diaryQuestInfo[i][2] = 0;
    global.diaryQuestInfo[i][3] = 0;
    global.diaryQuestInfo[i][4] = 0;
    global.diaryQuestInfo[i][5] = 0;
    global.diaryQuestInfo[i][6] = 0;
    global.diaryQuestInfo[i][7] = 1;
    global.diaryQuestInfo[i][8] = 0;
    global.diaryQuestInfo[i][9] = 0;
    global.diaryQuestInfo[i][10] = 0;
    global.diaryQuestInfo[i][11] = 0;
    
    if (((i + 1) % 5) == 0)
        global.diaryQuestInfo[i][7] = 3;
}

global.diaryQuestInfo[0][0] = 50;
global.diaryQuestInfo[0][1] = "Level up " + gml_Script_scr_bigNumber(global.diaryQuestInfo[0][0]) + " times";
global.diaryQuestInfo[0][3] = 50;
global.diaryQuestInfo[0][8] = 2;
global.diaryQuestInfo[1][0] = 200;
global.diaryQuestInfo[1][1] = "Level up " + gml_Script_scr_bigNumber(global.diaryQuestInfo[1][0]) + " times";
global.diaryQuestInfo[1][3] = 250;
global.diaryQuestInfo[1][8] = 3;
global.diaryQuestInfo[2][0] = 500;
global.diaryQuestInfo[2][1] = "Level up " + gml_Script_scr_bigNumber(global.diaryQuestInfo[2][0]) + " times";
global.diaryQuestInfo[2][3] = 600;
global.diaryQuestInfo[2][8] = 5;
global.diaryQuestInfo[3][0] = 1000;
global.diaryQuestInfo[3][1] = "Level up " + gml_Script_scr_bigNumber(global.diaryQuestInfo[3][0]) + " times";
global.diaryQuestInfo[3][3] = 1000;
global.diaryQuestInfo[3][4] = 100;
global.diaryQuestInfo[3][8] = 5;
global.diaryQuestInfo[4][0] = 2000;
global.diaryQuestInfo[4][1] = "Level up " + gml_Script_scr_bigNumber(global.diaryQuestInfo[4][0]) + " times";
global.diaryQuestInfo[4][4] = 500;
global.diaryQuestInfo[4][8] = 5;
global.diaryQuestInfo[4][10] = 0.05;
global.diaryQuestInfo[5][0] = 100;
global.diaryQuestInfo[5][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[5][0]) + " enemies";
global.diaryQuestInfo[5][3] = 50;
global.diaryQuestInfo[5][9] = 0.01;
global.diaryQuestInfo[6][0] = 1000;
global.diaryQuestInfo[6][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[6][0]) + " enemies";
global.diaryQuestInfo[6][3] = 150;
global.diaryQuestInfo[6][9] = 0.01;
global.diaryQuestInfo[7][0] = 5000;
global.diaryQuestInfo[7][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[7][0]) + " enemies";
global.diaryQuestInfo[7][3] = 300;
global.diaryQuestInfo[7][9] = 0.01;
global.diaryQuestInfo[8][0] = 20000;
global.diaryQuestInfo[8][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[8][0]) + " enemies";
global.diaryQuestInfo[8][3] = 500;
global.diaryQuestInfo[8][4] = 250;
global.diaryQuestInfo[8][9] = 0.02;
global.diaryQuestInfo[9][0] = 75000;
global.diaryQuestInfo[9][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[9][0]) + " enemies";
global.diaryQuestInfo[9][3] = 500;
global.diaryQuestInfo[9][4] = 500;
global.diaryQuestInfo[9][10] = 0.05;
global.diaryQuestInfo[10][0] = 20;
global.diaryQuestInfo[10][1] = "Complete " + gml_Script_scr_bigNumber(global.diaryQuestInfo[10][0]) + " raids";
global.diaryQuestInfo[10][5] = 1000;
global.diaryQuestInfo[10][6] = 500;
global.diaryQuestInfo[10][8] = 5;
global.diaryQuestInfo[11][0] = 250;
global.diaryQuestInfo[11][1] = "Complete " + gml_Script_scr_bigNumber(global.diaryQuestInfo[11][0]) + " raids";
global.diaryQuestInfo[11][5] = 1000000;
global.diaryQuestInfo[11][6] = 50000;
global.diaryQuestInfo[11][8] = 5;
global.diaryQuestInfo[12][0] = 800;
global.diaryQuestInfo[12][1] = "Complete " + gml_Script_scr_bigNumber(global.diaryQuestInfo[12][0]) + " raids";
global.diaryQuestInfo[12][5] = 100000000;
global.diaryQuestInfo[12][6] = 100000;
global.diaryQuestInfo[12][8] = 10;
global.diaryQuestInfo[12][10] = 0.02;
global.diaryQuestInfo[13][0] = 2000;
global.diaryQuestInfo[13][1] = "Complete " + gml_Script_scr_bigNumber(global.diaryQuestInfo[13][0]) + " raids";
global.diaryQuestInfo[13][8] = 15;
global.diaryQuestInfo[13][10] = 0.03;
global.diaryQuestInfo[14][0] = 4000;
global.diaryQuestInfo[14][1] = "Complete " + gml_Script_scr_bigNumber(global.diaryQuestInfo[14][0]) + " raids";
global.diaryQuestInfo[14][8] = 25;
global.diaryQuestInfo[14][10] = 0.05;
global.diaryQuestInfo[15][0] = 1000;
global.diaryQuestInfo[15][1] = "Deal " + gml_Script_scr_bigNumber(global.diaryQuestInfo[15][0]) + " damage";
global.diaryQuestInfo[15][3] = 50;
global.diaryQuestInfo[16][0] = 100000;
global.diaryQuestInfo[16][1] = "Deal " + gml_Script_scr_bigNumber(global.diaryQuestInfo[16][0]) + " damage";
global.diaryQuestInfo[16][3] = 100;
global.diaryQuestInfo[16][11] = 0.01;
global.diaryQuestInfo[17][0] = 10000000;
global.diaryQuestInfo[17][1] = "Deal " + gml_Script_scr_bigNumber(global.diaryQuestInfo[17][0]) + " damage";
global.diaryQuestInfo[17][3] = 300;
global.diaryQuestInfo[17][11] = 0.02;
global.diaryQuestInfo[18][0] = 1000000000;
global.diaryQuestInfo[18][1] = "Deal " + gml_Script_scr_bigNumber(global.diaryQuestInfo[18][0]) + " damage";
global.diaryQuestInfo[18][4] = 50;
global.diaryQuestInfo[18][11] = 0.03;
global.diaryQuestInfo[19][0] = 10000000000000;
global.diaryQuestInfo[19][1] = "Deal " + gml_Script_scr_bigNumber(global.diaryQuestInfo[19][0]) + " damage";
global.diaryQuestInfo[19][4] = 200;
global.diaryQuestInfo[19][11] = 0.04;
global.diaryQuestInfo[20][0] = 100;
global.diaryQuestInfo[20][1] = "Mitigate " + gml_Script_scr_bigNumber(global.diaryQuestInfo[20][0]) + " damage";
global.diaryQuestInfo[20][3] = 50;
global.diaryQuestInfo[21][0] = 10000;
global.diaryQuestInfo[21][1] = "Mitigate " + gml_Script_scr_bigNumber(global.diaryQuestInfo[21][0]) + " damage";
global.diaryQuestInfo[21][3] = 100;
global.diaryQuestInfo[21][9] = 0.01;
global.diaryQuestInfo[22][0] = 1000000;
global.diaryQuestInfo[22][1] = "Mitigate " + gml_Script_scr_bigNumber(global.diaryQuestInfo[22][0]) + " damage";
global.diaryQuestInfo[22][3] = 300;
global.diaryQuestInfo[22][9] = 0.02;
global.diaryQuestInfo[23][0] = 100000000;
global.diaryQuestInfo[23][1] = "Mitigate " + gml_Script_scr_bigNumber(global.diaryQuestInfo[23][0]) + " damage";
global.diaryQuestInfo[23][4] = 50;
global.diaryQuestInfo[23][9] = 0.03;
global.diaryQuestInfo[24][0] = 1000000000000;
global.diaryQuestInfo[24][1] = "Mitigate " + gml_Script_scr_bigNumber(global.diaryQuestInfo[24][0]) + " damage";
global.diaryQuestInfo[24][4] = 200;
global.diaryQuestInfo[24][9] = 0.04;
global.diaryQuestInfo[25][0] = 50;
global.diaryQuestInfo[25][1] = "Complete Raid " + gml_Script_scr_bigNumber(global.diaryQuestInfo[25][0]) + " in under 3 minutes";
global.diaryQuestInfo[25][3] = 100;
global.diaryQuestInfo[26][0] = 250;
global.diaryQuestInfo[26][1] = "Complete Raid " + gml_Script_scr_bigNumber(global.diaryQuestInfo[26][0]) + " in under 3 minutes";
global.diaryQuestInfo[26][3] = 250;
global.diaryQuestInfo[26][4] = 25;
global.diaryQuestInfo[27][0] = 500;
global.diaryQuestInfo[27][1] = "Complete Raid " + gml_Script_scr_bigNumber(global.diaryQuestInfo[27][0]) + " in under 3 minutes";
global.diaryQuestInfo[27][3] = 500;
global.diaryQuestInfo[27][4] = 50;
global.diaryQuestInfo[28][0] = 750;
global.diaryQuestInfo[28][1] = "Complete Raid " + gml_Script_scr_bigNumber(global.diaryQuestInfo[28][0]) + " in under 3 minutes";
global.diaryQuestInfo[28][3] = 750;
global.diaryQuestInfo[28][4] = 75;
global.diaryQuestInfo[29][0] = 1000;
global.diaryQuestInfo[29][1] = "Complete Raid " + gml_Script_scr_bigNumber(global.diaryQuestInfo[29][0]) + " in under 3 minutes";
global.diaryQuestInfo[29][3] = 1000;
global.diaryQuestInfo[29][4] = 100;
global.diaryQuestInfo[29][10] = 0.1;
global.diaryQuestInfo[30][0] = 5;
global.diaryQuestInfo[30][1] = "Enchant Relics " + gml_Script_scr_bigNumber(global.diaryQuestInfo[30][0]) + " times";
global.diaryQuestInfo[30][4] = 5;
global.diaryQuestInfo[30][8] = 5;
global.diaryQuestInfo[31][0] = 20;
global.diaryQuestInfo[31][1] = "Enchant Relics " + gml_Script_scr_bigNumber(global.diaryQuestInfo[31][0]) + " times";
global.diaryQuestInfo[31][4] = 20;
global.diaryQuestInfo[31][8] = 5;
global.diaryQuestInfo[32][0] = 50;
global.diaryQuestInfo[32][1] = "Enchant Relics " + gml_Script_scr_bigNumber(global.diaryQuestInfo[32][0]) + " times";
global.diaryQuestInfo[32][4] = 50;
global.diaryQuestInfo[32][8] = 5;
global.diaryQuestInfo[33][0] = 100;
global.diaryQuestInfo[33][1] = "Enchant Relics " + gml_Script_scr_bigNumber(global.diaryQuestInfo[33][0]) + " times";
global.diaryQuestInfo[33][4] = 100;
global.diaryQuestInfo[33][8] = 10;
global.diaryQuestInfo[33][10] = 0.02;
global.diaryQuestInfo[34][0] = 250;
global.diaryQuestInfo[34][1] = "Enchant Relics " + gml_Script_scr_bigNumber(global.diaryQuestInfo[34][0]) + " times";
global.diaryQuestInfo[34][4] = 250;
global.diaryQuestInfo[34][8] = 10;
global.diaryQuestInfo[34][10] = 0.03;
global.diaryQuestInfo[35][0] = 5;
global.diaryQuestInfo[35][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[35][0]) + " enemy Bosses";
global.diaryQuestInfo[35][3] = 100;
global.diaryQuestInfo[35][11] = 0.01;
global.diaryQuestInfo[36][0] = 20;
global.diaryQuestInfo[36][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[36][0]) + " enemy Bosses";
global.diaryQuestInfo[36][3] = 200;
global.diaryQuestInfo[36][4] = 20;
global.diaryQuestInfo[36][11] = 0.01;
global.diaryQuestInfo[37][0] = 50;
global.diaryQuestInfo[37][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[37][0]) + " enemy Bosses";
global.diaryQuestInfo[37][3] = 500;
global.diaryQuestInfo[37][4] = 50;
global.diaryQuestInfo[37][10] = 0.01;
global.diaryQuestInfo[38][0] = 150;
global.diaryQuestInfo[38][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[38][0]) + " enemy Bosses";
global.diaryQuestInfo[38][4] = 150;
global.diaryQuestInfo[38][10] = 0.03;
global.diaryQuestInfo[39][0] = 300;
global.diaryQuestInfo[39][1] = "Defeat " + gml_Script_scr_bigNumber(global.diaryQuestInfo[39][0]) + " enemy Bosses";
global.diaryQuestInfo[39][4] = 300;
global.diaryQuestInfo[39][10] = 0.05;
global.diaryQuestInfo[40][0] = 1;
global.diaryQuestInfo[40][1] = "Open the Underworld Portal for the 1st time";
global.diaryQuestInfo[40][8] = 10;
global.diaryQuestInfo[40][10] = 0.01;
global.diaryQuestInfo[41][0] = 10;
global.diaryQuestInfo[41][1] = "Open the Underworld Portal " + gml_Script_scr_bigNumber(global.diaryQuestInfo[41][0]) + " times";
global.diaryQuestInfo[41][8] = 10;
global.diaryQuestInfo[41][10] = 0.01;
global.diaryQuestInfo[42][0] = 50;
global.diaryQuestInfo[42][1] = "Open the Underworld Portal " + gml_Script_scr_bigNumber(global.diaryQuestInfo[42][0]) + " times";
global.diaryQuestInfo[42][8] = 10;
global.diaryQuestInfo[42][4] = 50;
global.diaryQuestInfo[42][10] = 0.01;
global.diaryQuestInfo[43][0] = 51;
global.diaryQuestInfo[43][1] = "Defeat all Underworld Guardians";
global.diaryQuestInfo[43][8] = 10;
global.diaryQuestInfo[42][4] = 500;
global.diaryQuestInfo[43][10] = 0.02;
global.diaryQuestInfo[44][0] = 52;
global.diaryQuestInfo[44][1] = "Defeat Finis Vitae";
global.diaryQuestInfo[44][8] = 30;
global.diaryQuestInfo[42][4] = 1000;
global.diaryQuestInfo[44][10] = 0.05;
global.diaryQuestInfo[45][0] = 1;
global.diaryQuestInfo[45][1] = "Tame your first pet";
global.diaryQuestInfo[45][5] = 1000000;
global.diaryQuestInfo[45][6] = 10000;
global.diaryQuestInfo[46][0] = 5;
global.diaryQuestInfo[46][1] = "Level up a pet to level " + gml_Script_scr_bigNumber(global.diaryQuestInfo[46][0]);
global.diaryQuestInfo[46][5] = 2000000;
global.diaryQuestInfo[46][6] = 100000;
global.diaryQuestInfo[47][0] = 10;
global.diaryQuestInfo[47][1] = "Level up a pet to level " + gml_Script_scr_bigNumber(global.diaryQuestInfo[47][0]);
global.diaryQuestInfo[47][5] = 3000000;
global.diaryQuestInfo[47][6] = 250000;
global.diaryQuestInfo[48][0] = 20;
global.diaryQuestInfo[48][1] = "Level up a pet to level " + gml_Script_scr_bigNumber(global.diaryQuestInfo[48][0]);
global.diaryQuestInfo[48][5] = 4000000;
global.diaryQuestInfo[48][6] = 500000;
global.diaryQuestInfo[49][0] = 30;
global.diaryQuestInfo[49][1] = "Level up a pet to level " + gml_Script_scr_bigNumber(global.diaryQuestInfo[49][0]);
global.diaryQuestInfo[49][5] = 5000000;
global.diaryQuestInfo[49][6] = 1000000;
global.diaryQuestInfo[50][0] = 5;
global.diaryQuestInfo[50][1] = "Find " + gml_Script_scr_bigNumber(global.diaryQuestInfo[50][0]) + " gems while mining";
global.diaryQuestInfo[50][8] = 5;
global.diaryQuestInfo[51][0] = 25;
global.diaryQuestInfo[51][1] = "Find " + gml_Script_scr_bigNumber(global.diaryQuestInfo[51][0]) + " gems while mining";
global.diaryQuestInfo[51][8] = 5;
global.diaryQuestInfo[52][0] = 100;
global.diaryQuestInfo[52][1] = "Find " + gml_Script_scr_bigNumber(global.diaryQuestInfo[52][0]) + " gems while mining";
global.diaryQuestInfo[52][8] = 10;
global.diaryQuestInfo[53][0] = 250;
global.diaryQuestInfo[53][1] = "Find " + gml_Script_scr_bigNumber(global.diaryQuestInfo[53][0]) + " gems while mining";
global.diaryQuestInfo[53][8] = 10;
global.diaryQuestInfo[54][0] = 500;
global.diaryQuestInfo[54][1] = "Find " + gml_Script_scr_bigNumber(global.diaryQuestInfo[54][0]) + " gems while mining";
global.diaryQuestInfo[54][8] = 20;
global.diaryQuestInfo[54][10] = 0.02;
global.diaryQuestInfo[55][0] = 5;
global.diaryQuestInfo[55][1] = "Obtain " + gml_Script_scr_bigNumber(global.diaryQuestInfo[55][0]) + " Honor Points";
global.diaryQuestInfo[55][3] = 50;
global.diaryQuestInfo[55][4] = 5;
global.diaryQuestInfo[55][6] = 200;
global.diaryQuestInfo[55][8] = 2;
global.diaryQuestInfo[56][0] = 20;
global.diaryQuestInfo[56][1] = "Obtain " + gml_Script_scr_bigNumber(global.diaryQuestInfo[56][0]) + " Honor Points";
global.diaryQuestInfo[56][3] = 100;
global.diaryQuestInfo[56][4] = 10;
global.diaryQuestInfo[56][6] = 500;
global.diaryQuestInfo[56][8] = 3;
global.diaryQuestInfo[57][0] = 50;
global.diaryQuestInfo[57][1] = "Obtain " + gml_Script_scr_bigNumber(global.diaryQuestInfo[57][0]) + " Honor Points";
global.diaryQuestInfo[57][3] = 300;
global.diaryQuestInfo[57][4] = 30;
global.diaryQuestInfo[57][6] = 5000;
global.diaryQuestInfo[57][8] = 5;
global.diaryQuestInfo[58][0] = 100;
global.diaryQuestInfo[58][1] = "Obtain " + gml_Script_scr_bigNumber(global.diaryQuestInfo[58][0]) + " Honor Points";
global.diaryQuestInfo[58][3] = 1000;
global.diaryQuestInfo[58][4] = 100;
global.diaryQuestInfo[58][8] = 10;
global.diaryQuestInfo[58][10] = 0.02;
global.diaryQuestInfo[59][0] = 150;
global.diaryQuestInfo[59][1] = "Obtain " + gml_Script_scr_bigNumber(global.diaryQuestInfo[59][0]) + " Honor Points";
global.diaryQuestInfo[59][4] = 300;
global.diaryQuestInfo[59][8] = 15;
global.diaryQuestInfo[59][10] = 0.03;
global.secretQuestReq[0][0] = 100000000;
global.secretQuestReq[0][1] = "Kill a total of " + gml_Script_scr_bigNumber(global.secretQuestReq[0][0]) + " enemy levels";
global.secretQuestReq[0][4] = 10;
global.secretQuestReq[1][0] = 1000000000000000;
global.secretQuestReq[1][1] = "Dig " + gml_Script_scr_bigNumber(global.secretQuestReq[1][0]) + " gold from the mine";
global.secretQuestReq[1][4] = 10;
global.secretQuestReq[2][0] = 1000000000;
global.secretQuestReq[2][1] = "Harvest " + gml_Script_scr_bigNumber(global.secretQuestReq[2][0]) + " food from the farm";
global.secretQuestReq[2][4] = 10;
ini_open(string(global.platformDir) + "Village Data/Data.ini");
global.totalDiaryQuests = array_length(global.diaryQuestInfo);
global.totalDiaryChapters = round(global.totalDiaryQuests / 5);
ini_close();
var _questRewardsText = array_create(global.totalDiaryQuests, "");

for (var i = 0; i < global.totalDiaryQuests; i++)
{
    _questRewardsText[i] += "[+" + string(global.diaryQuestInfo[i][7]) + " Honor";
    
    if (global.diaryQuestInfo[i][3] > 0)
        _questRewardsText[i] += ", +" + string(gml_Script_scr_bigNumber(global.diaryQuestInfo[i][3])) + " room00Talent ";
    
    if (global.diaryQuestInfo[i][4] > 0)
        _questRewardsText[i] += ", +" + string(gml_Script_scr_bigNumber(global.diaryQuestInfo[i][4])) + " room00Gem ";
    
    if (global.diaryQuestInfo[i][5] > 0)
        _questRewardsText[i] += ", +" + string(gml_Script_scr_bigNumber(global.diaryQuestInfo[i][5])) + " Gold";
    
    if (global.diaryQuestInfo[i][6] > 0)
        _questRewardsText[i] += ", +" + string(gml_Script_scr_bigNumber(global.diaryQuestInfo[i][6])) + " Food";
    
    if (global.diaryQuestInfo[i][8] > 0)
        _questRewardsText[i] += ", +" + string(gml_Script_scr_bigNumber(global.diaryQuestInfo[i][8])) + " Energy";
    
    if (global.diaryQuestInfo[i][9] > 0)
        _questRewardsText[i] += ", +" + string(round(global.diaryQuestInfo[i][9] * 100)) + "%[+] Damage";
    
    if (global.diaryQuestInfo[i][10] > 0)
        _questRewardsText[i] += ", +" + string(round(global.diaryQuestInfo[i][10] * 100)) + "%[x] Stats";
    
    if (global.diaryQuestInfo[i][11] > 0)
        _questRewardsText[i] += ", +" + string(round(global.diaryQuestInfo[i][11] * 100)) + "%[x] Constitution";
    
    _questRewardsText[i] += "]";
    global.diaryQuestInfo[i][2] = _questRewardsText[i];
}

var _secretQuestRewardsText = array_create(3, "");

for (var i = 0; i < 3; i++)
{
    if (global.secretQuestReq[i][4] > 0)
        _secretQuestRewardsText[i] += "[+" + string(gml_Script_scr_bigNumber(global.secretQuestReq[i][4])) + " room00Gem ";
    
    _secretQuestRewardsText[i] += "]";
    global.secretQuestReq[i][2] = _secretQuestRewardsText[i];
}
