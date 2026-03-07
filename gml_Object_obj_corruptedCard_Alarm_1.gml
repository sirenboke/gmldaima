if (gml_Script_live_call())
    return global.live_result;

if (alarm[0] == -1 && alarm[2] != -1)
{
    percent += random_range(0.01, 0.03);
    var pos = animcurve_channel_evaluate(getCurve, percent);
    scale = pos / 10;
    image_xscale = 1.5 + scale;
    image_yscale = 1.5 + scale;
    
    if (percent >= 1)
        percent = 0;
}

alarm[1] = 1;
