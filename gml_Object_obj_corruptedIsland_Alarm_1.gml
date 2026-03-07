if (gml_Script_live_call())
    return global.live_result;

percent += random_range(0.01, 0.03);
var pos = animcurve_channel_evaluate(getCurve, percent);
yy = pos * 8;

if (percent >= 1)
    percent = 0;

alarm[1] = 1;
