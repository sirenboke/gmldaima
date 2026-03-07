self.scr_burn_effectiveness = function(arg0)
{
    if (arg0 < 20)
        return 1;
    
    var _excess = arg0 - 20;
    var _effectiveness = power(0.999, _excess);
    
    if (_effectiveness < 0.000001)
        _effectiveness = 0;
    
    return _effectiveness;
};
