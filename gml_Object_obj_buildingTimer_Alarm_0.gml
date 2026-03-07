instance_create_depth(xx, yy, depth, build);
show_debug_message("Building Final pos X:" + string(xx) + " Y:" + string(yy));
gml_Script_scr_playsound(s_built, 1, 1, 1);
gml_Script_scr_playsound(s_build1, 0.9, 1.1, 1);
gml_Script_scr_playsound(s_build2, 0.9, 1.1, 1);
instance_destroy();
