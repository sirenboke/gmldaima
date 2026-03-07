if (global.stage < 251)
    global.stageTypeWorld = "Forest";

if (global.stage >= 251)
    global.stageTypeWorld = "Grassland";

if (global.stage >= 501)
    global.stageTypeWorld = "Snow Trail";

with (gml_Script_instance_create(x, y, obj_raidTransition))
{
    show_debug_message("transitioning from corrupted dimension to " + string(global.stageTypeWorld));
    c1 = 32768;
    text1 = global.stageTypeWorld;
    text2 = "Stage " + string(global.ostage);
}
