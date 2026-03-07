self.scr_formatTimer = function(arg0 = 0)
{
    var _t = arg0 / room_speed;
    var _unit = (_t >= 3600) ? "h" : ((_t >= 60) ? "m" : "s");
    var _value = (_t >= 3600) ? (_t / 3600) : ((_t >= 60) ? (_t / 60) : _t);
    return string(round(_value)) + _unit;
};
