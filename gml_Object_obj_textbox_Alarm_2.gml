var cv = executeScript[page];

if (is_array(cv))
{
    cv = cv[choice];
    var len = array_length_1d(cv) - 1;
    var cva = array_create(len, 0);
    array_copy(cva, 0, cv, 1, len);
    gml_Script_script_execute_alt(cv[0], cva);
}

if ((page + 1) < array_length_1d(text))
{
    var nl = nextline[page];
    
    switch (nl[choice])
    {
        case -1:
            instance_destroy();
            exit;
        
        case 0:
            page += 1;
            break;
        
        default:
            page = nl[choice];
    }
    
    event_perform(ev_alarm, 0);
}
else
{
    instance_destroy();
}

chosen = false;
