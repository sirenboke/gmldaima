self.scr_ds_list_create = function()
{
    var _id = ds_list_create();
    global.ds_counter_total++;
    global.ds_counter_list++;
    return _id;
};

self.scr_ds_map_create = function()
{
    var _id = ds_map_create();
    global.ds_counter_total++;
    global.ds_counter_map++;
    return _id;
};

self.scr_ds_grid_create = function(arg0, arg1)
{
    var _id = ds_grid_create(arg0, arg1);
    global.ds_counter_total++;
    global.ds_counter_grid++;
    return _id;
};

self.scr_surface_create = function(arg0, arg1, arg2)
{
    var _id = surface_create(arg0, arg1);
    
    if (_id != -1)
    {
        global.surface_counter_total++;
        ds_map_add(global.surface_registry, _id, arg2);
    }
    
    return _id;
};

self.scr_ds_list_destroy = function(arg0)
{
    if (ds_exists(arg0, ds_type_list))
    {
        ds_list_destroy(arg0);
        global.ds_counter_total--;
        global.ds_counter_list--;
    }
};

self.scr_ds_map_destroy = function(arg0)
{
    if (ds_exists(arg0, ds_type_map))
    {
        ds_map_destroy(arg0);
        global.ds_counter_total--;
        global.ds_counter_map--;
    }
};

self.scr_ds_grid_destroy = function(arg0)
{
    if (ds_exists(arg0, ds_type_grid))
    {
        ds_grid_destroy(arg0);
        global.ds_counter_total--;
        global.ds_counter_grid--;
    }
};

self.scr_surface_free = function(arg0)
{
    if (surface_exists(arg0))
    {
        surface_free(arg0);
        
        if (ds_map_exists(global.surface_registry, arg0))
        {
            ds_map_delete(global.surface_registry, arg0);
            global.surface_counter_total--;
        }
    }
};

self.scr_validate_surfaces = function()
{
    if (!surface_exists(global.raidFog))
        global.raidFog = gml_Script_scr_surface_create(room_width, room_height, "raidFog_recovered");
    
    if (!surface_exists(global.townFog))
        global.townFog = gml_Script_scr_surface_create(room_width, room_height, "townFog_recovered");
    
    if (!surface_exists(global.underworldFog))
        global.underworldFog = gml_Script_scr_surface_create(1420, 800, "underworldFog_recovered");
};

self.scr_debug_ds_report = function()
{
    if (global.dev)
    {
        show_debug_message("---- DS REPORT ----");
        show_debug_message("Total: " + string(global.ds_counter_total));
        show_debug_message("Lists: " + string(global.ds_counter_list));
        show_debug_message("Maps: " + string(global.ds_counter_map));
        show_debug_message("Grids: " + string(global.ds_counter_grid));
        show_debug_message("-------------------");
        show_debug_message("---- SURFACE REPORT ----");
        show_debug_message("Total Surfaces: " + string(global.surface_counter_total));
    }
    
    var _estimatedVRAM = 0;
    var _toDelete = gml_Script_scr_ds_list_create();
    var _key = ds_map_find_first(global.surface_registry);
    
    while (_key != undefined)
    {
        var _name = ds_map_find_value(global.surface_registry, _key);
        
        if (surface_exists(_key))
        {
            show_debug_message("OK: " + string(_name) + " | ID: " + string(_key) + " | Size: " + string(surface_get_width(_key)) + "x" + string(surface_get_height(_key)));
            _estimatedVRAM += (surface_get_width(_key) * surface_get_height(_key) * 4);
        }
        else
        {
            show_debug_message("LOST: " + string(_name) + " | ID: " + string(_key));
            ds_list_add(_toDelete, _key);
        }
        
        _key = ds_map_find_next(global.surface_registry, _key);
    }
    
    for (var i = 0; i < ds_list_size(_toDelete); i++)
    {
        var _deadKey = ds_list_find_value(_toDelete, i);
        ds_map_delete(global.surface_registry, _deadKey);
        global.surface_counter_total--;
    }
    
    gml_Script_scr_ds_list_destroy(_toDelete);
    
    if (global.dev)
    {
        show_debug_message("Estimated surface VRAM: " + string(_estimatedVRAM div 1024 div 1024) + " MB");
        show_debug_message("------------------------");
    }
};
