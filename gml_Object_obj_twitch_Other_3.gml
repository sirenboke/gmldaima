gml_Script_twitch_chat_say_direct("/me Dungeon Raiders is now down for maintenance SMOrc");
gml_Script_twitch_chat_disconnect();
gml_Script_twitch_free();
gml_Script_scr_ds_list_destroy(global.playerList);
gml_Script_scr_ds_list_destroy(global.raidList0);
gml_Script_scr_ds_list_destroy(global.raidList1);
gml_Script_scr_ds_list_destroy(global.readyList);
gml_Script_scr_ds_list_destroy(global.raidListPortalName);
gml_Script_scr_ds_list_destroy(global.raidListPortalClass);
gml_Script_scr_ds_list_destroy(global.raidListRedPortalName);
gml_Script_scr_ds_list_destroy(global.raidListRedPortalClass);
gml_Script_scr_ds_list_destroy(global.finalWarListName);
gml_Script_scr_ds_list_destroy(global.finalWarListClass);
gml_Script_scr_ds_list_destroy(global.relicList);
gml_Script_scr_ds_list_destroy(global.list_afk);
gml_Script_scr_ds_list_destroy(global.list_notafk);
gml_Script_scr_ds_list_destroy(global.islandVoting);
gml_Script_scr_ds_list_destroy(global.corruptedCardVoting);
mp_grid_destroy(global.gameGrid);

if (room == r_1)
{
    gml_Script_scr_ds_list_destroy(obj_build_mine.mineList);
    gml_Script_scr_ds_list_destroy(obj_build_farm.farmList);
    gml_Script_scr_ds_list_destroy(obj_build_train.trainList);
}

if (surface_exists(global.townFog))
    gml_Script_scr_surface_free(global.townFog);

if (surface_exists(global.raidFog))
    gml_Script_scr_surface_free(global.raidFog);
